#!/usr/bin/perl
# © 2019 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0

use lib '.';
use Fractionalization;

sub display_fraction {
    my ($fraction) = @_;
    print( $fraction->{numerator} );
    if ($fraction->{denominator} != 1) {
        print( '/' . $fraction->{denominator} );
    }
}
sub display_arithmetic {
    my ($base, $symbol, $relative, $equals) = @_;
    display_fraction( $base );
    print( ' ' . $symbol . ' ' );
    display_fraction( $relative );
    print( ' = ' );
    display_fraction( $equals );
    print( "\n" );
}
sub display_relation {
    my ($base, $symbol, $relative, $result) = @_;
    display_fraction( $base );
    print( ' ' . $symbol . ' ' );
    display_fraction( $relative );
    print( ' = ' );
    if ($result) {
        print( 'true' );
    } else {
        print( 'false' );
    }
    print( "\n" );
}
sub display_operations {
    my ($operation, $base, $relative) = @_;
    my $arithmetic = $operation->{arithmetic};
    my $relation = $operation->{relation};
    display_arithmetic( $base, '+', $relative, $arithmetic->{add}( $base, $relative ) );
    display_arithmetic( $base, '-', $relative, $arithmetic->{subtract}( $base, $relative ) );
    display_arithmetic( $base, '*', $relative, $arithmetic->{multiply}( $base, $relative ) );
    display_arithmetic( $base, '/', $relative, $arithmetic->{divide}( $base, $relative ) );
    display_relation( $base, '<', $relative, $relation->{lesser}( $base, $relative ) );
    display_relation( $base, '>', $relative, $relation->{greater}( $base, $relative ) );
    display_relation( $base, '==', $relative, $relation->{equal}( $base, $relative ) );
    display_relation( $base, '<=', $relative, $relation->{not_greater}( $base, $relative ) );
    display_relation( $base, '>=', $relative, $relation->{not_lesser}( $base, $relative ) );
    display_relation( $base, '!=', $relative, $relation->{not_equal}( $base, $relative ) );
}
my $fractional = \&Fractionalization::fractional;
my $fast_operation = $Fractionalization::fast_operation;
my $reducing_operation = $Fractionalization::reducing_operation;
my $x = &$fractional( 1, 6 );
my $y = &$fractional( 1, 12 );
print( "Fast Fractional Operations\n" );
display_operations( $fast_operation, $x, $y );
print( "\n" );
print( "Reducing Fractional Operations\n" );
display_operations( $reducing_operation, $x, $y );

