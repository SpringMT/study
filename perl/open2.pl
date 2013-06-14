#!/usr/bin/perl

use strict;
use warnings;
use IPC::Open2 qw(open2);
use IPC::Open3 qw(open3);
use IO::Socket;
use POSIX;

# warning = Name "main::OUT1" used only once: possible typo
#open2(\*OUT1, undef, 'iostat', '1', '3');
#open2(\*OUT2, "<&OUT1", 'cat', '-nu');
#print while(<OUT2>);

my ($wtr, $rdr, $err);
#my $pid = open3($wtr, $rdr, $err, 'll', '-ahl');
#my $pid = open3(\*CHLD_IN, \*CHLD_OUT, \*CHLD_ERR, 'date');
my $pid = open3(\*CHLD_IN, \*CHLD_OUT, \*CHLD_ERR, 'ls');

print "$pid";
print "\n";


if ( *CHLD_OUT ) {
    print while(<CHLD_OUT>);
    print "\n";
}

if ( *CHLD_ERR ) {
    print while(<CHLD_ERR>);
    print "\n";
}

print $?;
print $^;

#print POSIX::WIFEXITED($?);
#print "\n";
#print POSIX::WEXITSTATUS($?);
print "\n";

waitpid($pid, 0);
