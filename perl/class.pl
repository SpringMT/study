#!/usr/bin/env perl
use strict;
use warnings;
use v5.18;

package TestA;
  sub func1 {
    say 123;
  }
  sub new {
    my $class = shift;
    bless {}, $class;
  }
  sub func2 {
    my $class = shift;
    say 123;
  }

package TestB;
use parent -norequire => 'TestA';
sub test_b {say 1234}

#package TestC;
#use parent 'TestA';

package TestD;
use base 'TestA';
push @{ TestD::ISA }, 'TestB';

use Class::Inspector;
say @{Class::Inspector->methods('TestB')};
say @{Class::Inspector->methods('TestD')};


