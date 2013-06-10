package Cache::Memcached::Transparent;
use strict;
use warnings;
use Carp;
use Data::Dumper;

use Sub::Retry;
use Cache::Memcached::Fast;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $args  = shift;
    my $self = bless +{}, $class;
    $self->init( $args );
    return $self;
}

#これは修正
sub init {
    my $self = shift;
    my $args = shift;
    $self->{parent}    = Cache::Memcached::Fast->new(+{ servers => [$args->{parent}]})
        or croak "Not Defined Parent Server";
    $self->{child}     = Cache::Memcached::Fast->new(+{ servers => [$args->{child}]})
        or croak "Not Defined Child Server";
    $self->{max_retry} = $args->{max_retry} || 1;
    $self->{delay}     = $args->{delay}     || 0.1;
}

sub set {
    my ( $self, $key, $value, $expire ) = @_;
    my $res_c = retry $self->{max_retry}, $self->{delay}, sub {
        $self->{child}->set($key, $value, $expire);
    };
    croak "fail child set res:$res_c" unless $res_c;
    my $res_p = retry $self->{max_retry}, $self->{delay}, sub {
        my $res = $self->{parent}->set($key, $value, $expire);
    };
}

sub set_multi {
    my ( $self, $key_values ) = @_;
    croak 'Args Is Not Array Ref' unless ( ref($key_values) eq 'ARRAY' );
    my $error;
    for my $r ( @{$key_values} ) {
        next unless ref($key_values) eq 'ARRAY';
        next if !$r->[0] || !$r->[1];
        eval {
            $self->set(@{$r});
        };
        if ($@) {
            $error->{$r->[0]} = $r->[1];
            print "Fail set $r->[0], $r->[1], $r->[2]\n";
        }
    }
    return $error if $error;
}

sub get {
    my ( $self, $key ) = @_;
    my $val_c = $self->{child}->get($key);
    return $val_c if $val_c;

    # think about expire time ?
    my $val_p = $self->{parent}->get($key);
    return undef unless $val_p;

    my $set_res_c = retry $self->{max_retry}, $self->{delay}, sub {
        $self->{child}->set($key, $val_p);
    };
    print "Fail Set $set_res_c\n" unless $set_res_c;
    return $val_p;
}

sub get_multi {
    my ( $self, $keys ) = @_;
    croak "Args Is Not ref ARRAY" unless (ref $keys eq 'ARRAY');
    my $res;
    for my $key ( @{$keys} ) {
        my $val = $self->get($key);
        $res->{$key} = $val;
    }
    return $res;
}

1;
__END__

=head1 NAME

Cache::Memcached::Transparent -

=head1 SYNOPSIS

  use Cache::Memcached::Transparent;

=head1 DESCRIPTION

Cache::Memcached::Transparent is

=head1 AUTHOR

Spring_MT E<lt>today.is.sky.blue.sky@gamil.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
