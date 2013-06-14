#!/usr/bin/perl

use strict;
use warnings;

my $module = $ARGV[0];
my $before_mem_size = mem_size();
print "start : ";
print conv_unit($before_mem_size) . "\n";

eval "use $module";
if($@){
  die "$module sonna module naicchuunen!";
}
my $after_mem_size = mem_size();
print "end : ";
print conv_unit($after_mem_size) . "\n";

my $res = $after_mem_size - $before_mem_size;
print "use $module : ";
print conv_unit($res) . "\n";


sub conv_unit {
  my $kb = shift;
  if($kb > 1024){
    return sprintf("%.1fMB", ($kb / 1024));
  }elsif($kb > 1048576){
    return sprintf("%.1fGB", ($kb / 1048576));
  }else{
    return $kb . "KB";
  }
}

sub mem_size {

  my $mem_size = readpipe "ps -p $$ -o rss | tail -n -1";
  $mem_size =~ s/^\s+//;
  $mem_size =~ s/\s+$//;
  return sprintf("%d", $mem_size);
}
