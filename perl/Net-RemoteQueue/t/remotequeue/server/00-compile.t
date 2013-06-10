#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../../lib";

use Net::RemoteQueue::Server;

BEGIN { use_ok 'Net::RemoteQueue::Server' }
require_ok ('Net::RemoteQueue::Server');

done_testing;

