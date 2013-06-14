#!/usr/bin/perl

use strict;
use warnings;
use Geo::IP;

my $module = $ARGV[0];
my $start_mem_size = mem_size();
print "start : ";
print conv_unit($start_mem_size) . "\n";

#my $package ='Geo::IP';
#eval{ use $package};

my $gi = Geo::IP->open("/Users/haruyama.makoto/Downloads/GeoLiteCity.dat", GEOIP_STANDARD);
my $open_mem_size = mem_size();
my $res_o = $open_mem_size - $start_mem_size;
print "open : ";
print conv_unit($res_o) . "\n";

my $record = $gi->record_by_addr("125.2.180.38");
my $region = $record->region;

my $region_mem_size = mem_size();
my $res_r = $region_mem_size - $start_mem_size;
print "region : ";
print conv_unit($res_r) . "\n";

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
