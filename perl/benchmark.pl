#!/usr/bin/perl

use strict;
use Benchmark qw(:all);
use DateTime;
use Time::Local;
use Time::Piece;

my $count = 10000;

my $r = timethese($count,
    {'DateTime' => '&test1;', 'Time::Local' => '&test2;', });

cmpthese $r;

sub test1 {
    my $datetime = DateTime->today->epoch;
}

sub test2 {
    my $timelocal = timelocal( 0, 0, 0, (localtime(time))[3..5] );
}

#sub test3 {
#    my $t = localtime;
#    my $timelocal = Time::Piece( 0, 0, 0, (localtime(time))[3..5] );
#}


