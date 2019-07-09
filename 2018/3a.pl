#! /usr/bin/env perl
use strict;
use warnings;

my ($id, $left_margin, $top_margin, $width, $height);
my @fabric_layout = ();
my $number_of_overlaps = 0;

open my $input_file, '<', '3_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    chomp;
    if (/^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/) {
        ($id, $left_margin, $top_margin, $width, $height) = ($1, $2, $3, $4 ,$5);
        for my $line (@fabric_layout[$top_margin .. $top_margin + $height - 1]) {
            for my $cell (@{$line}[$left_margin .. $left_margin + $width - 1]) {
                $cell++;
                $number_of_overlaps++ if $cell == 2;
            }
        }
    }
}

close $input_file;

print "this many square inches of fabric are in more than one claim: [$number_of_overlaps]\n";

