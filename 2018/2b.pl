#! /usr/bin/env perl

use strict;
use warnings;

my @stat;
my $substring;

open my $input_file, '<', '2_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    chomp;
    for my $position (0 .. length() - 1) {
        $substring = substr($_, 0, $position) . substr($_, $position + 1);
        if ($stat[$position]->{$substring}++) {
            print "common letters in box IDs: [$substring]\n";
            exit;
        }
    }
}

close $input_file;

