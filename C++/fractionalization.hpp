// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
#ifndef FRACTIONALIZATION_MODULE
#define FRACTIONALIZATION_MODULE

namespace fractionalization {

template <typename Natural>
struct Fractional {

    Natural
        numerator,
        denominator;
};

template <typename Natural>
using ArithmeticalAbstract = Fractional<Natural>(
    const Fractional<Natural>&,
    const Fractional<Natural>&);

template <typename Natural>
using RelationalAbstract = bool(
    const Fractional<Natural>&,
    const Fractional<Natural>&);

template <typename Natural>
struct Arithmetical {

    ArithmeticalAbstract<Natural>
        &add,
        &subtract,
        &multiply,
        &divide;
};

template <typename Natural>
struct Relational {

    RelationalAbstract<Natural>
        &lesser,
        &greater,
        &equal,
        &not_greater,
        &not_lesser,
        &not_equal;
};

template <typename Natural>
struct Operational {

    const Arithmetical<Natural>& arithmetic;
    const Relational<Natural>& relation;
};

template <typename Natural>
static inline Natural
GreatestCommonDivisor(
    const Natural&
        a,
    const Natural&
        b)
{
    // Euclidean Algorithm
    Natural dividend, divisor, remainder;
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

template <typename Natural>
static inline Natural
LeastCommonMultiple(
    const Natural&
        a,
    const Natural&
        b)
{
    const Natural divisor = GreatestCommonDivisor(a, b);
    if (a > b)
        return a / divisor * b;
    return b / divisor * a;
}

template <typename Natural>
static inline Fractional<Natural>
Reduce(
    const Fractional<Natural>&
        fraction)
{
    Natural divisor;
    Fractional<Natural> result;
    if (fraction.numerator == 0) {
        result.numerator = 0;
        result.denominator = 1;
    } else {
        divisor = GreatestCommonDivisor(fraction.numerator, fraction.denominator);
        result.numerator = fraction.numerator / divisor;
        result.denominator = fraction.denominator / divisor;
    }
    return result;
}

template <typename Natural>
static inline Fractional<Natural>
FastAdd(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Fractional<Natural> result = {
        base.numerator * relative.denominator + relative.numerator * base.denominator,
        base.denominator * relative.denominator
    };
    return result;
}

template <typename Natural>
static inline Fractional<Natural>
FastSubtract(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Fractional<Natural> result = {
        base.numerator * relative.denominator - relative.numerator * base.denominator,
        base.denominator * relative.denominator
    };
    return result;
}

template <typename Natural>
static inline Fractional<Natural>
FastMultiply(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Fractional<Natural> result = {
        base.numerator * relative.numerator,
        base.denominator * relative.denominator
    };
    return result;
}

template <typename Natural>
static inline Fractional<Natural>
FastDivide(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Fractional<Natural> result = {
        base.numerator * relative.denominator,
        base.denominator * relative.numerator
    };
    return result;
}

template <typename Natural>
static inline Fractional<Natural>
ReducingAdd(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    Fractional<Natural> result;
    result.denominator = LeastCommonMultiple(base.denominator, relative.denominator);
    result.numerator = base.numerator * (result.denominator / base.denominator);
    result.numerator += relative.numerator * (result.denominator / relative.denominator);
    return Reduce(result);
}

template <typename Natural>
static inline Fractional<Natural>
ReducingSubtract(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    Fractional<Natural> result;
    result.denominator = LeastCommonMultiple(base.denominator, relative.denominator);
    result.numerator = base.numerator * (result.denominator / base.denominator);
    result.numerator -= relative.numerator * (result.denominator / relative.denominator);
    return Reduce(result);
}

template <
    typename Natural>
static inline Fractional<Natural>
ReducingMultiply(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    Natural bnrd_divisor, bdrn_divisor;
    Fractional<Natural> result;
    if (base.numerator > 0)
        bnrd_divisor = GreatestCommonDivisor(base.numerator, relative.denominator);
    else
        bnrd_divisor = 1;
    if (relative.numerator > 0)
        bdrn_divisor = GreatestCommonDivisor(base.denominator, relative.numerator);
    else
        bdrn_divisor = 1;
    result.numerator = (base.numerator / bnrd_divisor) * (relative.numerator / bdrn_divisor);
    result.denominator = (base.denominator / bdrn_divisor) * (relative.denominator / bnrd_divisor);
    return result;
}

template <typename Natural>
static inline Fractional<Natural>
ReducingDivide(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Natural
        bnrn_divisor
        = GreatestCommonDivisor(base.numerator, relative.numerator),
        bdrd_divisor = GreatestCommonDivisor(base.denominator, relative.denominator);
    const Fractional<Natural> result = {
        (base.numerator / bnrn_divisor) * (relative.denominator / bdrd_divisor),
        (base.denominator / bdrd_divisor) * (relative.numerator / bnrn_divisor)
    };
    return result;
}

template <typename Natural>
static inline bool
FastLesser(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    return base.numerator * relative.denominator < relative.numerator * base.denominator;
}

template <typename Natural>
static inline bool
FastGreater(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    return base.numerator * relative.denominator > relative.numerator * base.denominator;
}

template <typename Natural>
static inline bool
FastEqual(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    return base.numerator * relative.denominator == relative.numerator * base.denominator;
}

template <typename Natural>
static inline bool
FastNotGreater(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    return base.numerator * relative.denominator <= relative.numerator * base.denominator;
}

template <typename Natural>
static inline bool
FastNotLesser(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    return base.numerator * relative.denominator >= relative.numerator * base.denominator;
}

template <typename Natural>
static inline bool
FastNotEqual(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    return base.numerator * relative.denominator != relative.numerator * base.denominator;
}

template <typename Natural>
static inline bool
ReducingLesser(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) < relative.numerator * (factor / relative.denominator);
}

template <typename Natural>
static inline bool
ReducingGreater(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) > relative.numerator * (factor / relative.denominator);
}

template <typename Natural>
static inline bool
ReducingEqual(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) == relative.numerator * (factor / relative.denominator);
}

template <typename Natural>
static inline bool
ReducingNotGreater(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) <= relative.numerator * (factor / relative.denominator);
}

template <typename Natural>
static inline bool
ReducingNotLesser(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) >= relative.numerator * (factor / relative.denominator);
}

template <typename Natural>
static inline bool
ReducingNotEqual(
    const Fractional<Natural>&
        base,
    const Fractional<Natural>&
        relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) != relative.numerator * (factor / relative.denominator);
}

template <typename Natural>
static constexpr Arithmetical<Natural>
    FastArithmetic = {
        FastAdd<Natural>,
        FastSubtract<Natural>,
        FastMultiply<Natural>,
        FastDivide<Natural>
    };

template <typename Natural>
static constexpr Arithmetical<Natural>
    ReducingArithmetic = {
        ReducingAdd<Natural>,
        ReducingSubtract<Natural>,
        ReducingMultiply<Natural>,
        ReducingDivide<Natural>
    };

template <typename Natural>
static constexpr Relational<Natural>
    FastRelation = {
        FastLesser<Natural>,
        FastGreater<Natural>,
        FastEqual<Natural>,
        FastNotGreater<Natural>,
        FastNotLesser<Natural>,
        FastNotEqual<Natural>,
    };

template <typename Natural>
static constexpr Relational<Natural>
    ReducingRelation = {
        ReducingLesser<Natural>,
        ReducingGreater<Natural>,
        ReducingEqual<Natural>,
        ReducingNotGreater<Natural>,
        ReducingNotLesser<Natural>,
        ReducingNotEqual<Natural>,
    };

template <typename Natural>
static constexpr Operational<Natural>
    FastOperation = {
        FastArithmetic<Natural>,
        FastRelation<Natural>
    };

template <typename Natural>
static constexpr Operational<Natural>
    ReducingOperation = {
        ReducingArithmetic<Natural>,
        ReducingRelation<Natural>
    };

}
#endif
