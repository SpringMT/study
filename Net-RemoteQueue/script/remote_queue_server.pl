#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Getopt::Long;
use Pod::Usage;
use Net::RemoteQueue::Server;

our $VERSION = '0.01';

my $opts = +{};
GetOptions(
    $opts,
    'listen|l=s',
    'processes|p=s',
    'plugin=i',
    'max-requests-per-child|r=s',
    'help|h', 'man',
);

pod2usage(1) if ($opts->{help});
pod2usage(-verbose => 2) if ($opts->{man});

sub main {
    my $opts = shift;

    %$opts = (
        listen => 30000,
        processes => 10,
        'max-requests-per-child' => 100,
        %$opts,
    );

    my $server = Net::RemoteQueue::Server->new(
        listen_port => $opts->{listen},
        max_workers => $opts->{processes},
        max_requests_per_child => $opts->{'max-requests-per-child'},
        plugin      => $opts->{plugin},
    );

    $server->run;
}

main($opts);

__END__

=head1 NAME

B<script_name> - write short description for script_name

=head1 VERSION

0.01

=head1 SYNOPSIS

  Options:
    --listen|-l                listen port (default: 30000)
    --processes|-p             max processes (default: 10)
    --max-request-per-child    max requests per child (default: 100)
    --help|-h                  brief help message
    --man                      full documentaion

=head1 DESCRIPTION

=head1 AUTHOR

Toru Yamaguchi E<lt>zigorou@dena.jp<gt>

=head1 SEE ALSO

=cut

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# coding: utf-8-unix
# End:
#
# vim: expandtab shiftwidth=4:

