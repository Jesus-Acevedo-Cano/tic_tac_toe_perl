#!/usr/bin/perl

=begin

Hack day in Holberton School/tic tac toe game

=end
=cut
use strict;
use warnings;


sub board{
    my $tiles_ref = shift;
    my $test = sprintf("
┌───┬───┬───┐
│ %s │ %s │ %s │
├───┼───┼───┤
│ %s │ %s │ %s │
├───┼───┼───┤
│ %s │ %s │ %s │
└───┴───┴───┘
", @$tiles_ref);
    print $test;
}

sub turn {
    my $player_ref = shift;
    my $tiles_ref = shift;
    print "Player $$player_ref turn: ";
    my $pick = <STDIN>;
    chomp $pick;
    if ($$player_ref == 1) {
        if (@$tiles_ref[$pick] ne 'X' && @$tiles_ref[$pick] ne 'O'){
            @$tiles_ref[$pick] = 'X';
            $$player_ref = 2;
        } else {
            print "Already filled";
        }
    } else {
        if (@$tiles_ref[$pick] ne 'X' && @$tiles_ref[$pick] ne 'O'){
            @$tiles_ref[$pick] = 'O';
            $$player_ref = 1;
        } else {
            print "Already filled";
        }
    }
}

sub end{
    print "Would you like to play another game? Y/N: ";
        my $continue = <STDIN>;
        chomp $continue;
}

sub compare{
    my @win_combo = (
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
        );
    my $winner = '';
    my $tiles_ref = shift;

    foreach my $combo (@win_combo) {
        $winner = '';
        foreach my $match (@$combo){
            $winner = $winner . @$tiles_ref[$match];
        }
        return check($winner);
    }
}

sub check{
    my $winner = shift;
    if( 'XXX' eq $winner ){
        return 1;
    } elsif ('OOO' eq $winner){
        return 2;
    }
    return 0;
}

sub start{
    my @tiles = ('0', '1', '2', '3', '4', '5', '6', '7', '8');
    my $turns = 0;
    my $flag = 0;
    board(\@tiles);
    my $player = '1';
    do {
        turn(\$player, \@tiles);
        $flag = compare(\@tiles);
        board(\@tiles);
        return $flag if ($flag == 1);
        return $flag if ($flag == 2);
        $turns++;
    } while($turns < 9);
    return ($flag);
}

BEGIN {
    my $winner = start;
    if ($winner != 0) {
        print "Player $winner won\n";
    } else {
        print "Draw\n";
    }
}
