#! /usr/bin/env perl
use strict;
use warnings;

my $polymer = '';

open my $input_file, '<', '5_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    chomp;
    $polymer .= $_;
}

close $input_file;

my @polymer = split '', $polymer;
for (my $i = 0; defined $polymer[$i] and defined $polymer[$i + 1]; $i++) {
    if ($polymer[$i] eq uc($polymer[$i]) and $polymer[$i + 1] eq lc($polymer[$i]) or
            $polymer[$i] eq lc($polymer[$i]) and $polymer[$i + 1] eq uc($polymer[$i])) {
        splice(@polymer, $i, 2, ());
        $i -= $i > 0 ? 2 : 1;
    }
}

print "after fully reacting the polymer [" . @polymer . "] units remain\n";

