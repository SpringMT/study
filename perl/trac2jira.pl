#!/usr/bin/perl

use strict;
use warnings;
use Carp;

my $OUTPUT_DIR = $ARGV[0];

print "$OUTPUT_DIR\n";

opendir my $DH, $OUTPUT_DIR
    or croak "$!: $OUTPUT_DIR";

while ( my $old_file = readdir($DH) ) {
    my $old_file_tmp = $old_file;
    my @hierarchy = split ("%2F", $old_file );
    my $page_name = pop @hierarchy;

    if ( @hierarchy ) {
        my $dir = $OUTPUT_DIR;
        for my $dir_name (@hierarchy) {
            $dir .=   "\/$dir_name";
            #print "$dir\n";
            `mkdir -p $dir`;
        }
        my $old_file_path = $OUTPUT_DIR . "/" . $old_file_tmp;
        my $new_file_path = $dir . "/" . $page_name;
        print "$old_file_path 2 $new_file_path\n";
        rename $old_file_path, $new_file_path;
        unlink $old_file_path;
    }
}

