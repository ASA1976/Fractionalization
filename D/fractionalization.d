// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
module fractionalization;
struct Fractional(Natural)
{
    Natural numerator, denominator; 
}
alias ArithmeticalAbstract(Natural) = Fractional!Natural function(Fractional!Natural, Fractional!Natural);
alias RelationalAbstract(Natural) = bool function(Fractional!Natural, Fractional!Natural);
struct Arithmetical(Natural)
{
    ArithmeticalAbstract!Natural add, subtract, multiply, divide;
}
struct Relational(Natural)
{
    RelationalAbstract!Natural lesser, greater, equal, not_greater, not_lesser, not_equal;
}
struct Operational(Natural)
{
    Arithmetical!Natural arithmetic;
    Relational!Natural relation;
}
Natural GreatestCommonDivisor(Natural)(Natural a, Natural b)
{
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
Natural LeastCommonMultiple(Natural)(Natural a, Natural b)
{
    const Natural divisor = GreatestCommonDivisor(a, b);
    if (a > b)
        return a / divisor * b;
    return b / divisor * a;
}
Fractional!Natural Reduce(Natural)(Fractional!Natural fraction)
{
    Natural divisor;
    if (fraction.numerator == 0)
        return Fractional!Natural(0, 1);
    divisor = GreatestCommonDivisor(fraction.numerator, fraction.denominator);
    return Fractional!Natural(fraction.numerator / divisor, fraction.denominator / divisor);
}
Fractional!Natural FastAdd(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    Fractional!Natural result;
    result.numerator = base.numerator * relative.denominator + relative.numerator * base.denominator;
    result.denominator = base.denominator * relative.denominator;
    return result;
}
Fractional!Natural FastSubtract(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    Fractional!Natural result;
    result.numerator = base.numerator * relative.denominator - relative.numerator * base.denominator;
    result.denominator = base.denominator * relative.denominator;
    return result;
}
Fractional!Natural FastMultiply(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    Fractional!Natural result;
    result.numerator = base.numerator * relative.numerator;
    result.denominator = base.denominator * relative.denominator;
    return result;
}
Fractional!Natural FastDivide(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    Fractional!Natural result;
    result.numerator = base.numerator * relative.denominator;
    result.denominator = base.denominator * relative.numerator;
    return result;
}
Fractional!Natural ReducingAdd(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural multiple = LeastCommonMultiple(base.denominator, relative.denominator);
    Fractional!Natural result;
    result.numerator = base.numerator * (multiple / base.denominator) + relative.numerator * (multiple / relative.denominator);
    result.denominator = multiple;
    return Reduce(result);
}
Fractional!Natural ReducingSubtract(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural multiple = LeastCommonMultiple(base.denominator, relative.denominator);
    Fractional!Natural result;
    result.numerator = base.numerator * (multiple / base.denominator) - relative.numerator * (multiple / relative.denominator);
    result.denominator = multiple;
    return Reduce(result);
}
Fractional!Natural ReducingMultiply(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    Natural bnrd_divisor, bdrn_divisor;
    Fractional!Natural result;
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
Fractional!Natural ReducingDivide(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural bnrn_divisor = GreatestCommonDivisor(base.numerator, relative.numerator);
    const Natural bdrd_divisor = GreatestCommonDivisor(base.denominator, relative.denominator);
    Fractional!Natural result;
    result.numerator = (base.numerator / bnrn_divisor) * (relative.denominator / bdrd_divisor);
    result.denominator = (base.denominator / bdrd_divisor) * (relative.numerator / bnrn_divisor);
    return result;
}
bool FastLesser(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    return base.numerator * relative.denominator < relative.numerator * base.denominator;
}
bool FastGreater(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    return base.numerator * relative.denominator > relative.numerator * base.denominator;
}
bool FastEqual(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    return base.numerator * relative.denominator == relative.numerator * base.denominator;
}
bool FastNotGreater(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    return base.numerator * relative.denominator <= relative.numerator * base.denominator;
}
bool FastNotLesser(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    return base.numerator * relative.denominator >= relative.numerator * base.denominator;
}
bool FastNotEqual(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    return base.numerator * relative.denominator != relative.numerator * base.denominator;
}
bool ReducingLesser(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) < relative.numerator * (factor / relative.denominator);
}
bool ReducingGreater(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) > relative.numerator * (factor / relative.denominator);
}
bool ReducingEqual(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) == relative.numerator * (factor / relative.denominator);
}
bool ReducingNotGreater(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) <= relative.numerator * (factor / relative.denominator);
}
bool ReducingNotLesser(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) >= relative.numerator * (factor / relative.denominator);
}
bool ReducingNotEqual(Natural)(Fractional!Natural base, Fractional!Natural relative)
{
    const Natural factor = LeastCommonMultiple(base.denominator, relative.denominator);
    return base.numerator * (factor / base.denominator) != relative.numerator * (factor / relative.denominator);
}
const Arithmetical!Natural FastArithmetic(Natural) = {
    add: &FastAdd!Natural,
    subtract: &FastSubtract!Natural,
    multiply: &FastMultiply!Natural,
    divide: &FastDivide!Natural
};
const Arithmetical!Natural ReducingArithmetic(Natural) = {
    add: &ReducingAdd!Natural,
    subtract: &ReducingSubtract!Natural,
    multiply: &ReducingMultiply!Natural,
    divide: &ReducingDivide!Natural
};
const Relational!Natural FastRelation(Natural) = {
    lesser: &FastLesser!Natural,
    greater: &FastGreater!Natural,
    equal: &FastEqual!Natural,
    not_greater: &FastNotGreater!Natural,
    not_lesser: &FastNotLesser!Natural,
    not_equal: &FastNotEqual!Natural
};
const Relational!Natural ReducingRelation(Natural) = {
    lesser: &ReducingLesser!Natural,
    greater: &ReducingGreater!Natural,
    equal: &ReducingEqual!Natural,
    not_greater: &ReducingNotGreater!Natural,
    not_lesser: &ReducingNotLesser!Natural,
    not_equal: &ReducingNotEqual!Natural
};
const Operational!Natural FastOperation(Natural) = {
    arithmetic: FastArithmetic!Natural,
    relation: FastRelation!Natural
};
const Operational!Natural ReducingOperation(Natural) = {
    arithmetic: ReducingArithmetic!Natural,
    relation: ReducingRelation!Natural
};

