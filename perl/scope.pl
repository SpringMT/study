#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use v5.18;

$Data::Dumper::Deparse = 1;

{
  package TestA;
  our $foo = 'foo';
  {
    my $foo = 'bar';
    say $foo;
  }
  say $foo;
}

#local $bar = 'bar';
#my $buz = 'buz';

say $TestA::foo;
warn Dumper $TestA::foo; #( [\%main::], [qw( *main:: )] );
#say TestA::bar
#say TestA::buz



