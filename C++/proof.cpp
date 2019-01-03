// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
#include "fractionalization.hpp"
#include <cstdio>

using namespace ::fractionalization;

using NaturalFractional = Fractional< unsigned int >;
using NaturalArithmetical = Arithmetical< unsigned int >;

static inline void
DisplayFraction(
    const NaturalFractional&
        fraction
) {
    printf( "%u", fraction.numerator );
    if (fraction.denominator != 1)
        printf( "/%u", fraction.denominator );
}

template <
    const NaturalArithmetical&
        Arithmetic
>
int
FractionCalculator( void ) {
    NaturalFractional
        x, y, result;
    char
        o;
    puts( "" );
    puts( "numerator/denominator operation numerator/denominator" );
    puts( "operation: + - * /" );
    puts( "example: 1/2 * 2/3" );
    puts( "" );
    if (scanf( "%u / %u %c %u / %u",  &x.numerator, &x.denominator, &o, &y.numerator, &y.denominator ) < 5) {
        fprintf( stderr, "Unable to parse expression\n" );
        return -1;
    }
    if (x.denominator == 0 || y.denominator == 0) {
        fprintf( stderr, "Denominator must not be 0\n" );
        return -2;
    }
    switch (o) {
        case '+':
            result = Arithmetic.add( x, y );
            break;
        case '-':
            result = Arithmetic.subtract( x, y );
            break;
        case '*':
            result = Arithmetic.multiply( x, y );
            break;
        case '/':
            result = Arithmetic.divide( x, y );
            break;
        default:
            fprintf( stderr, "Unknown operation '%c'\n", o );
            return -3;
    }
    printf( " = " );
    DisplayFraction( result );
    puts( "" );
    return 0;
}

int
main() {
    static auto&
        ReducingFractionCalculator = FractionCalculator< ReducingArithmetic< unsigned int > >;
    return ReducingFractionCalculator();
}
