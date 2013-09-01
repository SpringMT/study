#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use v5.18;

{
  package TestA;
  our $foo = 'foo';
}

say Dumper($TestA::foo);


