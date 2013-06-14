#!/usr/bin/perl

use strict;
use warnings;
use Carp;

my $var = 123;

if ($var == 123) {
  my $var_2 = 456;
}

#print "$var_2\n";

sub get_var {
  #$var = 456;
  print sub {123}
}

&get_var
