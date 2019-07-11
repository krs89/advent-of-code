#! /usr/bin/env perl
use strict;
use warnings;

use List::Util qw(max reduce);
use List::MoreUtils qw(first_index);

my @log_lines = ();
my %minutes_by_guard = ();
my %all_sleep_by_guard = ();

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
            $all_sleep_by_guard{$guard_id} += $wake_up_at - $fall_asleep_at;
        } elsif ($message =~ /Guard #(\d+) begins shift/) {
            $guard_id = $1;
        }
    }
}

my $guard_who_slept_most = List::Util::reduce { $all_sleep_by_guard{$b} > $all_sleep_by_guard{$a} ? $b : $a } keys %all_sleep_by_guard;
my $max_occasions_slept_at_the_same_minute =  List::Util::max @{ $minutes_by_guard{$guard_who_slept_most} };
my $max_minute_slept = List::MoreUtils::first_index { $_ eq $max_occasions_slept_at_the_same_minute }  @{ $minutes_by_guard{$guard_who_slept_most} };

print "most slept guard id [$guard_who_slept_most] multiplied by the minute he slept most [$max_minute_slept]: [" . $guard_who_slept_most * $max_minute_slept . "]\n";

