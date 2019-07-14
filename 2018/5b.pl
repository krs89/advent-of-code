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


my $optimized_polymer;
my @optimized_polymer;
my @reduced_polymer;
my @stat;
for my $char ('a' .. 'z') {
    ($optimized_polymer = $polymer) =~ s/$char//ig;
    @optimized_polymer = split '', $optimized_polymer;
    @reduced_polymer = react(@optimized_polymer);
    push @stat, scalar @reduced_polymer;
}


print "after fully reacting the optimized polymer [" . (sort { $a <=> $b } @stat)[0] . "] units remain\n";

sub react {
    my (@polymer) = @_;
    for (my $i = 0; defined $polymer[$i] and defined $polymer[$i + 1]; $i++) {
        if ($polymer[$i] eq uc($polymer[$i]) and $polymer[$i + 1] eq lc($polymer[$i]) or
                $polymer[$i] eq lc($polymer[$i]) and $polymer[$i + 1] eq uc($polymer[$i])) {
            splice(@polymer, $i, 2, ());
            $i -= $i > 0 ? 2 : 1;
        }
    }
    return @polymer;
}
