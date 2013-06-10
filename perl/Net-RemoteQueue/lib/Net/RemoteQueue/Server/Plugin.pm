package Net::RemoteQueue::Server::Plugin;

use strict;
use warnings;
use Carp;

sub new {
    my ($class, $args) = @_;

    $args->{host}
    my $self = bless{ args => $args || +{}, $class};
    return $self;
}

1;


