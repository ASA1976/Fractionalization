// © 2018 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
#include "fractionalization.hpp"
#include <stdio.h>

using namespace ::fractionalization;

using NaturalFractional = Fractional< unsigned int >;
using NaturalOperational = Operational< unsigned int >;

static inline void
DisplayFraction(
    const NaturalFractional&
        fraction
) {
    printf( "%u", fraction.numerator );
    if (fraction.denominator > 1)
        printf( "/%u", fraction.denominator );
}

static inline void
DisplayArithmetic(
    const NaturalFractional&
        left,
    const char* const
        symbol,
    const NaturalFractional&
        right,
    const NaturalFractional&
        equals
) {
    DisplayFraction( left );
    printf( " %s ", symbol );
    DisplayFraction( right );
    printf( " = " );
    DisplayFraction( equals );
    puts( "" );
}

static inline void
DisplayRelation(
    const NaturalFractional&
        left,
    const char* const
        symbol,
    const NaturalFractional&
        right,
    const bool result
) {
    DisplayFraction( left );
    printf( " %s ", symbol );
    DisplayFraction( right );
    printf( " = %s", result ? "true" : "false" );
    puts( "" );
}

static inline void
DisplayOperations(
    const NaturalOperational&
        operation,
    const NaturalFractional&
        base,
    const NaturalFractional&
        relative
) {
    const auto
        arithmetic = operation.arithmetic;
    const auto
        relation = operation.relation;
    DisplayArithmetic( base, "+", relative, arithmetic.add( base, relative ) );
    DisplayArithmetic( base, "-", relative, arithmetic.subtract( base, relative ) );
    DisplayArithmetic( base, "*", relative, arithmetic.multiply( base, relative ) );
    DisplayArithmetic( base, "/", relative, arithmetic.divide( base, relative ) );
    DisplayRelation( base, "<", relative, relation.lesser( base,  relative ) );
    DisplayRelation( base, ">", relative, relation.greater( base, relative ) );
    DisplayRelation( base, "==", relative, relation.equal( base, relative ) );
    DisplayRelation( base, "<=", relative, relation.not_greater( base, relative ) );
    DisplayRelation( base, ">=", relative, relation.not_lesser( base, relative ) );
    DisplayRelation( base, "!=", relative, relation.not_equal( base, relative ) );
}

int
main() {
    static auto
        NaturalFastOperation = FastOperation< unsigned int >;
    static auto
        NaturalReducingOperation = ReducingOperation< unsigned int >;
    static const NaturalFractional
        X = {1, 6},
        Y = {1, 12};
    puts( "Fast NaturalFractional Operations" );
    DisplayOperations( NaturalFastOperation, X, Y );
    puts( "" );
    puts( "Reducing NaturalFractional Operations" );
    DisplayOperations( NaturalReducingOperation, X, Y );
    return 0;
}
