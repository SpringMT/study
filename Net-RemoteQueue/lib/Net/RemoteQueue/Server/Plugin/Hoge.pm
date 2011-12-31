package Net::RemoteQueue::Server::Plugin::Hoge;

use strict;
use warnings;
use Carp;

use parent qw/Net::RemoteQueue::Server::Plugin/;

sub hoge {
    my $self = shift;
    return "hogehoge";
}

1;


