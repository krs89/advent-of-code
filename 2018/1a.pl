#! /usr/bin/env perl

use strict;
use warnings;

my $current_frequency = 0;

open my $input_file, '<', '1_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    chomp;
    $current_frequency += $_;
}

close $input_file;

print "frequency after one cycle: [$current_frequency]\n";

