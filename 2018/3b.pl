#! /usr/bin/env perl
use strict;
use warnings;

my ($id, $left_margin, $top_margin, $width, $height);
my @fabric_layout = ();
my %non_overlapping_claims = ();
my $overlaps;

open my $input_file, '<', '3_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    chomp;
    if (/^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/) {
        $overlaps = 0;
        ($id, $left_margin, $top_margin, $width, $height) = ($1, $2, $3, $4 ,$5);
        for my $line (@fabric_layout[$top_margin .. $top_margin + $height - 1]) {
            for my $cell_claim (@{$line}[$left_margin .. $left_margin + $width - 1]) {
                if ($cell_claim) {
                    delete $non_overlapping_claims{$cell_claim};
                    $overlaps = 1;
                } else {
                    $cell_claim = $id;
                }
            }
        }
        $non_overlapping_claims{$id} = 1 unless $overlaps;
    }
}

close $input_file;

print "id of claim, which does not overlap with any other claim: [" . (keys(%non_overlapping_claims))[0] . "]\n";

