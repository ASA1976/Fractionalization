/*
   © 2018 Aaron Sami Abassi
   Licensed under the Academic Free License version 3.0
*/
#include "fractionalization.h"
#include <stdio.h>

static void display_fraction( const fractional fraction )
{
    printf( "%u", fraction.numerator );
    if (fraction.denominator > 1)
        printf( "/%u", fraction.denominator );
}

static void display_arithmetic( const fractional base, const char *const symbol, const fractional relative, const fractional equals )
{
    display_fraction( base );
    printf( " %s ", symbol );
    display_fraction( relative );
    printf( " = " );
    display_fraction( equals );
    printf( "\n" );
}

static void display_relation( const fractional base, const char *const symbol, const fractional relative, const int result )
{
    display_fraction( base );
    printf( " %s ", symbol );
    display_fraction( relative );
    printf( " = %s\n", result ? "true" : "false" );
}

static void display_operations( const operational *const operation, const fractional base, const fractional relative )
{
    const arithmetical *const arithmetic = operation->arithmetic;
    const relational *const relation = operation->relation;
    display_arithmetic( base, "+", relative, arithmetic->add( base, relative ) );
    display_arithmetic( base, "-", relative, arithmetic->subtract( base, relative ) );
    display_arithmetic( base, "*", relative, arithmetic->multiply( base, relative ) );
    display_arithmetic( base, "/", relative, arithmetic->divide( base, relative ) );
    display_relation( base, "<", relative, relation->lesser( base, relative ) );
    display_relation( base, ">", relative, relation->greater( base, relative ) );
    display_relation( base, "==", relative, relation->equal( base, relative ) );
    display_relation( base, "<=", relative, relation->not_greater( base, relative ) );
    display_relation( base, ">=", relative, relation->not_lesser( base, relative ) );
    display_relation( base, "!=", relative, relation->not_equal( base, relative ) );
}

int main()
{
    static const fractional X = {1, 6}, Y = {1, 12};
    printf( "Fast Fractional Operations\n" );
    display_operations( &FAST_OPERATION, X, Y );
    printf( "\n" );
    printf( "Reducing Fractional Operations\n" );
    display_operations( &REDUCING_OPERATION, X, Y );
    return 0;
}
