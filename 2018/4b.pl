#! /usr/bin/env perl
use strict;
use warnings;

use List::Util qw(max);

my @log_lines = ();
my %minutes_by_guard = ();

open my $input_file, '<', '4_input.txt' or die "can not open input file: $!";

while (<$input_file>) {
    chomp;
    push @log_lines, $_;
}

close $input_file;

my ($guard_id, $minute, $message, $fall_asleep_at, $wake_up_at);
for my $line ( sort @log_lines ) {
    if ($line =~ /^\[\d{4}-\d{2}-\d{2} \d{2}:(\d{2})] (.*)$/) {
        ($minute, $message) = ($1, $2);
        if ($message eq 'falls asleep') {
            $fall_asleep_at = $minute;
        } elsif ($message eq 'wakes up') {
            $wake_up_at = $minute;
            $_++ for ( @{ $minutes_by_guard{$guard_id} }[$fall_asleep_at .. $wake_up_at - 1] );
        } elsif ($message =~ /Guard #(\d+) begins shift/) {
            $guard_id = $1;
        }
    }
}

my %number_of_occasions = ();
my $this_many;
for my $guard_id (keys %minutes_by_guard) {
    for my $minute (0 .. 59) {
        $this_many = $minutes_by_guard{$guard_id}->[$minute];
        next unless $this_many;
        $number_of_occasions{$this_many} = [$guard_id, $minute];
    }
}

my $max = List::Util::max keys %number_of_occasions;

print "most frequent minute [$number_of_occasions{$max}->[1]] multiplied by the guard id [$number_of_occasions{$max}->[0]]: [" . $number_of_occasions{$max}->[0] * $number_of_occasions{$max}->[1] . "]\n";

