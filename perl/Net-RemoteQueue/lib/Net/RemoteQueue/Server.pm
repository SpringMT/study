package Net::RemoteQueue::Server;

use strict;
use warnings;
use constant {
    JSONRPC_ERROR_PARSE_ERROR       => -32700,
    JSONRPC_ERROR_INVALID_REQUEST   => -32600,
    JSONRPC_ERROR_METHOD_NOT_FOUND  => -32601,
    JSONRPC_ERROR_INVALID_PARAMS    => -32602,
    JSONRPC_ERROR_INTERNAL_ERROR    => -32603,
};
use Class::Accessor::Lite (
    new => 0,
    rw  => [qw/
        accept_timeout
        dispatch_methods
        listen_port
        listen_socket
        listen_timeout
        max_workers
        max_requests_per_child
        read_buffer_size
    /],
);
use IO::Socket::INET;
use JSON::XS;
use Parallel::Prefork;
use Log::Minimal;

our $VERSION = '0.01';
our %JSONRPC_ERROR_MESSAGES = (
    -32700 => 'Parse Error',
    -32600 => 'Invalid Request',
    -32602 => 'Method Not Found',
    -32601 => 'Invalid Params',
    -32603 => 'Internal Error',
);

sub new {
    my $class = shift;
    my $args = ref $_[0] ? $_[0] : { @_ };

    my $dispatch_methods = delete $args->{dispatch_methods} || {};

    %$args = (
        accept_timeout         => 0,
        dispatch_methods       => {
            'system.echo' => 'handle_system_echo',
            'queue.send'  => 'handle_queue_send',
            %$dispatch_methods,
        },
        listen_port            => 30000,
        listen_socket          => undef,
        listen_timeout         => 5,
        max_workers            => 5,
        max_requests_per_child => 100,
        read_buffer_size       => 1024,
        error_message          => '',
        %$args,
    );

    bless $args => $class;
}

sub run {
    my $self = shift;

    $self->{listen_socket} ||= IO::Socket::INET->new(
        Blocking => 1,
        LocalHost => 'localhost',
        LocalPort => $self->{listen_port},
        Listen => SOMAXCONN,
        Proto => 'tcp',
        ReuseAddr => 1,
        Timeout => $self->{listen_timeout},
        Type => SOCK_STREAM,
    ) or die($!);

    my $pp = Parallel::Prefork->new({
        max_workers => $self->{max_workers},
        trap_signals => {
            TERM => 'TERM',
            HUP  => 'TERM',
        },
    });

    infof("Listen %d port (pid: %s)", $self->{listen_port}, $$);

    while ( $pp->signal_received ne 'TERM' ) {
        $pp->start(sub {
            $self->accept_loop;
        });
    }

    $pp->wait_all_children;

    infof('Shutdown server (pid: %s)', $$);

    exit 0;
}

sub accept_loop {
    my $self = shift;

    my $term_received = 0;
    $SIG{TERM} = sub {
        $term_received++;
        infof("TERM signal received (times: %d, pid: %s)", $term_received, $$);
        exit 0 if ($term_received > 1);
    };

    my $requests = 0;

    while ( $requests++ <= $self->{max_requests_per_child} ) {
        if ( $term_received ) {
            exit 0;
        }

        if ( my $conn = $self->{listen_socket}->accept($self->{accept_timeout}) ) {
            infof("Accept connection (PeerHost: %s, PeerPort: %d, pid: %s)", $conn->peerhost, $conn->peerport, $$);
            $self->handle_connection($conn);
        }
    }

    exit 0;
}

sub handle_connection {
    my ($self, $conn) = @_;

    my $jsonrpc_request;
    my $jsonrpc_response = {
        id      => undef,
        result  => undef,
        error   => undef,
        jsonrpc => '2.0',
    };

    if ( defined ($jsonrpc_request = $self->read_request($conn)) ) {
        if ( ref $jsonrpc_request eq 'HASH') {
            $self->handle_request($conn, $jsonrpc_request, $jsonrpc_response);
        }
        else {
            $self->set_error(
                $jsonrpc_request,
                $jsonrpc_response,
                JSONRPC_ERROR_PARSE_ERROR,
                undef,
            );
        }
        $self->write_response($conn, $jsonrpc_response);
    }

    infof("Close connection (PeerHost: %s, PeerPort: %d, pid: %s)", $conn->peerhost, $conn->peerport, $$);
    $conn->close;
}

sub handle_request {
    my ($self, $conn, $jsonrpc_request, $jsonrpc_response) = @_;

    for my $field (qw/id method params jsonrpc/) {
        unless ( defined $jsonrpc_request->{$field} ) {
            $self->set_error(
                $jsonrpc_request,
                $jsonrpc_response,
                JSONRPC_ERROR_INVALID_PARAMS,
                sprintf('Not exists "%s" field in JSON-RPC request payload', $field),
            );
            return 0;
        }
    }

    $jsonrpc_response->{id} = $jsonrpc_request->{id};
    my $method = $jsonrpc_request->{method};

    unless (exists $self->{dispatch_methods}{$method}) {
        $self->set_error(
            $jsonrpc_request,
            $jsonrpc_response,
            JSONRPC_ERROR_METHOD_NOT_FOUND,
            sprintf('No such a method "%s"', $method),
        );
        return 0;
    }

    my $handle_method = $self->{dispatch_methods}{$method};

    if ($self->can($handle_method)) {
        eval {
            $self->$handle_method($jsonrpc_request, $jsonrpc_response);
        };
    }
    elsif (!$self->can($handle_method) && defined $self->{plugin} ) {
        my $class = "Net::RemoteQueue::Server::Plugin::".$self->{plugin};
        $class->new();
        if ($class->can($handle_method)) {
            eval {
                $class->$handle_method($jsonrpc_request, $jsonrpc_response);
            };
        }
    }
    else {
        warnf(
            "Not implemented %s method (PeerHost: %s, PeerPort: %d, pid: %s)",
            $method,
            $conn->peerhost, $conn->peerport, $$,
        );
        $self->set_error(
            $jsonrpc_request,
            $jsonrpc_response,
            JSONRPC_ERROR_INTERNAL_ERROR,
            sprintf('Not implemented this method "%s"', $method),
        );
        return;
    }

    if (my $e = $@) {
        critf(
            "%s on %s (PeerHost: %s, PeerPort: %d, pid: %s)", 
            $e, $method,
            $conn->peerhost, $conn->peerport, $$,
        );
        $self->set_error(
            $jsonrpc_request,
            $jsonrpc_response,
            JSONRPC_ERROR_INTERNAL_ERROR,
            "$e",
        );
        return;
    }

    return 1;
}

sub handle_system_echo {
    my ($self, $jsonrpc_request, $jsonrpc_response) = @_;
    $jsonrpc_response->{result} = $jsonrpc_request->{params};
    return 1;
}

sub read_request {
    my ($self, $conn) = @_;

    ### jsonrpc_request
    my $request_data = '';

    while (1) {
        if ( defined $conn->sysread(my $buf, $self->{read_buffer_size}) ) {
            ### connection closed by peer
            if (length $buf == 0) {
                infof("Connection closed by peer (PeerHost: %s, PeerPort: %d, pid: %s)", $conn->peerhost, $conn->peerport, $$);
                return;
            }
            debugf("Read buffer %s (pid: %s)", ddf($buf), $$);
            $request_data .= $buf;
            last if ($buf =~ m/\0/);
        }
        else {
            return;
        }
    }

    my $jsonrpc_request;
    eval {
        $jsonrpc_request = decode_json($request_data);
    };
    if (my $e = $@) {
        $self->{error_message} = "$e";
        return 0;
    }

    return ref $jsonrpc_request ? $jsonrpc_request : 0;
}

sub write_response {
    my ( $self, $conn, $jsonrpc_response ) = @_;

    my $response = encode_json($jsonrpc_response);
    debugf("Response: %s (PeerHost: %s, PeerPort: %d, pid: %s)", $response, $conn->peerhost, $conn->peerport, $$);
    $conn->syswrite($response, length $response);

    1;
}

sub set_error {
    my ( $self, $jsonrpc_request, $jsonrpc_response, $code, $message, $data ) = @_;

    $jsonrpc_request ||= {};

    if ( exists $JSONRPC_ERROR_MESSAGES{$code} ) {
        $message = defined $message ? 
            sprintf( '%s, %s', $JSONRPC_ERROR_MESSAGES{$code}, $message )
                : $JSONRPC_ERROR_MESSAGES{$code};
    }
    else {
        $message ||= 'Unknown error';
    }

    $jsonrpc_response->{id} = $jsonrpc_request->{id} || undef;
    $jsonrpc_response->{result} = undef;
    $jsonrpc_response->{error}  = {
        code    => $code,
        message => $message,
        ( defined $data && ref $data eq 'HASH' ) ? ( data => $data ) : (),
    };

    return;
}

1;
__END__

=head1 NAME

Net::RemoteQueue::Server -

=head1 SYNOPSIS

  use Net::RemoteQueue::Server;

=head1 DESCRIPTION

Net::RemoteQueue::Server is

=head1 AUTHOR

Toru Yamaguchi E<lt>zigorou@cpan.orgE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# coding: utf-8-unix
# End:
#
# vim: expandtab shiftwidth=4:
 
