/*
   © 2018 Aaron Sami Abassi
   Licensed under the Academic Free License version 3.0
*/
#ifndef FRACTIONALIZATION_MODULE
#define FRACTIONALIZATION_MODULE

typedef int boolean;

typedef unsigned int natural;

typedef struct fractional_s {

    natural
        numerator,
        denominator;

} fractional;

typedef fractional arithmetical_abstract(const fractional* const, const fractional* const);

typedef boolean relational_abstract(const fractional* const, const fractional* const);

typedef struct arithmetical_s {

    arithmetical_abstract
        *add,
        *subtract,
        *multiply,
        *divide;

} arithmetical;

typedef struct relational_s {

    relational_abstract
        *lesser,
        *greater,
        *equal,
        *not_greater,
        *not_lesser,
        *not_equal;

} relational;

typedef struct operational_s {

    const arithmetical* arithmetic;
    const relational* relation;

} operational;

static natural greatest_common_divisor(const natural a, const natural b)
{
    /* Euclidean Algorithm */
    natural dividend, divisor, remainder;
    if (a > b) {
        dividend = a;
        divisor = b;
    } else {
        dividend = b;
        divisor = a;
    }
    while ((remainder = dividend % divisor) > 0) {
        dividend = divisor;
        divisor = remainder;
    }
    return divisor;
}

static natural least_common_multiple(const natural a, const natural b)
{
    const natural divisor = greatest_common_divisor(a, b);
    if (a > b)
        return a / divisor * b;
    return b / divisor * a;
}

static fractional reduce(const fractional* const fraction)
{
    natural divisor;
    fractional result;
    if (fraction->numerator == 0) {
        result.numerator = 0;
        result.denominator = 1;
    } else {
        divisor = greatest_common_divisor(fraction->numerator, fraction->denominator);
        result.numerator = fraction->numerator / divisor;
        result.denominator = fraction->denominator / divisor;
    }
    return result;
}

static fractional fast_add(const fractional* const base, const fractional* const relative)
{
    fractional result;
    result.numerator = base->numerator * relative->denominator + relative->numerator * base->denominator;
    result.denominator = base->denominator * relative->denominator;
    return result;
}

static fractional fast_subtract(const fractional* const base, const fractional* const relative)
{
    fractional result;
    result.numerator = base->numerator * relative->denominator - relative->numerator * base->denominator;
    result.denominator = base->denominator * relative->denominator;
    return result;
}

static fractional fast_multiply(const fractional* const base, const fractional* const relative)
{
    fractional result;
    result.numerator = base->numerator * relative->numerator;
    result.denominator = base->denominator * relative->denominator;
    return result;
}

static fractional fast_divide(const fractional* const base, const fractional* const relative)
{
    fractional result;
    result.numerator = base->numerator * relative->denominator;
    result.denominator = base->denominator * relative->numerator;
    return result;
}

static fractional reducing_add(const fractional* const base, const fractional* const relative)
{
    fractional result;
    result.denominator = least_common_multiple(base->denominator, relative->denominator);
    result.numerator = base->numerator * (result.denominator / base->denominator);
    result.numerator += relative->numerator * (result.denominator / relative->denominator);
    return reduce(&result);
}

static fractional reducing_subtract(const fractional* const base, const fractional* const relative)
{
    fractional result;
    result.denominator = least_common_multiple(base->denominator, relative->denominator);
    result.numerator = base->numerator * (result.denominator / base->denominator);
    result.numerator -= relative->numerator * (result.denominator / relative->denominator);
    return reduce(&result);
}

static fractional reducing_multiply(const fractional* const base, const fractional* const relative)
{
    natural bnrd_divisor, bdrn_divisor;
    fractional result;
    if (base->numerator > 0)
        bnrd_divisor = greatest_common_divisor(base->numerator, relative->denominator);
    else
        bnrd_divisor = 1;
    if (relative->numerator > 0)
        bdrn_divisor = greatest_common_divisor(base->denominator, relative->numerator);
    else
        bdrn_divisor = 1;
    result.numerator = (base->numerator / bnrd_divisor) * (relative->numerator / bdrn_divisor);
    result.denominator = (base->denominator / bdrn_divisor) * (relative->denominator / bnrd_divisor);
    return result;
}

static fractional reducing_divide(const fractional* const base, const fractional* const relative)
{
    natural bnrn_divisor, bdrd_divisor;
    fractional result;
    bnrn_divisor = greatest_common_divisor(base->numerator, relative->numerator);
    bdrd_divisor = greatest_common_divisor(base->denominator, relative->denominator);
    result.numerator = (base->numerator / bnrn_divisor) * (relative->denominator / bdrd_divisor);
    result.denominator = (base->denominator / bdrd_divisor) * (relative->numerator / bnrn_divisor);
    return result;
}

static boolean fast_lesser(const fractional* const base, const fractional* const relative)
{
    return base->numerator * relative->denominator < relative->numerator * base->denominator;
}

static boolean fast_greater(const fractional* const base, const fractional* const relative)
{
    return base->numerator * relative->denominator > relative->numerator * base->denominator;
}

static boolean fast_equal(const fractional* const base, const fractional* const relative)
{
    return base->numerator * relative->denominator == relative->numerator * base->denominator;
}

static boolean fast_not_greater(const fractional* const base, const fractional* const relative)
{
    return base->numerator * relative->denominator <= relative->numerator * base->denominator;
}

static boolean fast_not_lesser(const fractional* const base, const fractional* const relative)
{
    return base->numerator * relative->denominator >= relative->numerator * base->denominator;
}

static boolean fast_not_equal(const fractional* const base, const fractional* const relative)
{
    return base->numerator * relative->denominator != relative->numerator * base->denominator;
}

static boolean reducing_lesser(const fractional* const base, const fractional* const relative)
{
    const natural factor = least_common_multiple(base->denominator, relative->denominator);
    return base->numerator * (factor / base->denominator) < relative->numerator * (factor / relative->denominator);
}

static boolean reducing_greater(const fractional* const base, const fractional* const relative)
{
    const natural factor = least_common_multiple(base->denominator, relative->denominator);
    return base->numerator * (factor / base->denominator) > relative->numerator * (factor / relative->denominator);
}

static boolean reducing_equal(const fractional* const base, const fractional* const relative)
{
    const natural factor = least_common_multiple(base->denominator, relative->denominator);
    return base->numerator * (factor / base->denominator) == relative->numerator * (factor / relative->denominator);
}

static boolean reducing_not_greater(const fractional* const base, const fractional* const relative)
{
    const natural factor = least_common_multiple(base->denominator, relative->denominator);
    return base->numerator * (factor / base->denominator) <= relative->numerator * (factor / relative->denominator);
}

static boolean reducing_not_lesser(const fractional* const base, const fractional* const relative)
{
    const natural factor = least_common_multiple(base->denominator, relative->denominator);
    return base->numerator * (factor / base->denominator) >= relative->numerator * (factor / relative->denominator);
}

static boolean reducing_not_equal(const fractional* const base, const fractional* const relative)
{
    const natural factor = least_common_multiple(base->denominator, relative->denominator);
    return base->numerator * (factor / base->denominator) != relative->numerator * (factor / relative->denominator);
}

static const arithmetical
    FAST_ARITHMETIC
    = {
          fast_add,
          fast_subtract,
          fast_multiply,
          fast_divide
      },
    REDUCING_ARITHMETIC = { reducing_add, reducing_subtract, reducing_multiply, reducing_divide };

static const relational
    FAST_RELATION
    = {
          fast_lesser,
          fast_greater,
          fast_equal,
          fast_not_greater,
          fast_not_lesser,
          fast_not_equal
      },
    REDUCING_RELATION = { reducing_lesser, reducing_greater, reducing_equal, reducing_not_greater, reducing_not_lesser, reducing_not_equal };

static const operational
    FAST_OPERATION
    = {
          &FAST_ARITHMETIC,
          &FAST_RELATION
      },
    REDUCING_OPERATION = { &REDUCING_ARITHMETIC, &REDUCING_RELATION };

#endif
