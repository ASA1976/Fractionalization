/*
   © 2018 Aaron Sami Abassi
   Licensed under the Academic Free License version 3.0
*/
#include "fractionalization.h"
#include <stdio.h>
#define ARITHMETIC REDUCING_ARITHMETIC

static void display_fraction(const fractional* const fraction)
{
    printf("%u", fraction->numerator);
    if (fraction->denominator != 1)
        printf("/%u", fraction->denominator);
}

static int fraction_calculator( void )
{
    fractional
        x, y, result;
    char
        o;
    puts("");
    puts("numerator/denominator operation numerator/denominator");
    puts("operation: + - * /");
    puts("example: 1/2 * 2/3");
    puts("");
    if (scanf("%u / %u %c %u / %u",  &x.numerator, &x.denominator, &o, &y.numerator, &y.denominator) < 5) {
        fprintf(stderr, "Unable to parse expression\n");
        return -1;
    }
    if (x.denominator == 0 || y.denominator == 0) {
        fprintf(stderr, "Denominator must not be 0\n");
        return -2;
    }
    switch (o) {
        case '+':
            result = ARITHMETIC.add(&x, &y);
            break;
        case '-':
            result = ARITHMETIC.subtract(&x, &y);
            break;
        case '*':
            result = ARITHMETIC.multiply(&x, &y);
            break;
        case '/':
            result = ARITHMETIC.divide(&x, &y);
            break;
        default:
            fprintf(stderr, "Unknown operation '%c'\n", o);
            return -3;
    }
    printf(" = ");
    display_fraction(&result);
    puts("");
    return 0;
}

int main()
{
    return fraction_calculator();
}

