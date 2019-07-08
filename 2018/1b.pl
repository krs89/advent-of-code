#! /usr/bin/env perl

use strict;
use warnings;

my $current_frequency = 0;
my @frequency_changes = ();
my %seen = ();

open my $input_file, '<', '1_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    chomp;
    push @frequency_changes, $_;
}

close $input_file;

while (1) {
    for my $change (@frequency_changes) {
        $current_frequency += $change;
        if ($seen{$current_frequency}) {
            print "with repeating cycles first period seen twice: [$current_frequency]\n";
            exit;
        } else {
            $seen{$current_frequency}++;
        }
    }
}
