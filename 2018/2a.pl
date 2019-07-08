#! /usr/bin/env perl

use strict;
use warnings;

my %distribution_by_letter = ();
my %letter_counts = ();
my $twos = 0;
my $threes = 0;

open my $input_file, '<', '2_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    %distribution_by_letter = ();
    %letter_counts = ();
    chomp;
    map { $distribution_by_letter{$_}++ } split '', $_;
    %letter_counts = map { ($_ => 1) } values %distribution_by_letter;
    $twos++ if exists $letter_counts{2};
    $threes++ if exists $letter_counts{3};
}

close $input_file;

print "checkum: [" . $twos * $threes . "]\n";

