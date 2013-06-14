#!/usr/bin/perl

use strict;
use warnings;
use Carp;

use AnyEvent;
my $cv = AnyEvent->condvar;

my $wait_one_and_a_half_seconds = AnyEvent->timer (
    after => 1.5,  # after how many seconds to invoke the cb?
    cb    => sub { # the callback to invoke
        print $cv->send;
        print "timer";
    },
);

print $cv->recv;


