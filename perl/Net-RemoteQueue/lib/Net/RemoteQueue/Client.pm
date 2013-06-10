package Net::RemoteQueue::Client;

use strict;
use warnings;
use Carp;

use IO::Socket::INET;
use JSON qw/encode_json decode_json/;

sub new {
    my ($class, $args) = @_;
    $args->{host} ||= "localhost";
    $args->{port} ||= 30000;
    my $self = bless $args, $class;
    return $self;
}

sub request {
    my $self = shift;

    print "aaaaa\n";
    my $send_data = encode_json(+{id => 1, method => "system.echo", params => +{message => "Hello World!"}});
    my $conn = IO::Socket::INET->new(
        PeerHost => $self->{host},
        PeerPort => $self->{port},
    ) or die($!);

    #print $conn "hogehoge\n";

    #while (<$conn>) {
        print $conn "$send_data\n";
        #print $conn->getline;
    #}
    $conn->close;
    print $conn->getline;
}

1;


