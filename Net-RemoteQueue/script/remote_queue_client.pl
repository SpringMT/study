#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Getopt::Long;
use Pod::Usage;
use Net::RemoteQueue::Client;

my $client = Net::RemoteQueue::Client->new;

$client->request;

