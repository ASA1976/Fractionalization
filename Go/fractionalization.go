// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
package fractionalization
type Fractional struct {
    Numerator, Denominator uint
}
type ArithmeticalAbstract func(Fractional, Fractional) Fractional
type RelationalAbstract func(Fractional, Fractional) bool
type Arithmetical struct {
    Add, Subtract, Multiply, Divide ArithmeticalAbstract
}
type Relational struct {
    Lesser, Greater, Equal, NotGreater, NotLesser, NotEqual RelationalAbstract
}
type Operational struct {
    Arithmetic Arithmetical
    Relation Relational
}
func GreatestCommonDivisor(a uint, b uint) uint {
    // Euclidean Algorithm
    var (dividend, divisor, remainder uint)
    if a > b {
        dividend = a
        divisor = b
    } else {
        dividend = b
        divisor = a
    }
    remainder = dividend % divisor
    for remainder > 0 {
        dividend = divisor
        divisor = remainder
        remainder = dividend % divisor
    }
    return divisor
}
func LeastCommonMultiple(a uint, b uint) uint {
    divisor := GreatestCommonDivisor(a, b)
    if a > b {
        return a / divisor * b
    }
    return b / divisor * a
}
func Reduce(fraction Fractional) Fractional {
    var divisor uint
    if fraction.Numerator == 0 {
        return Fractional{0, 1}
    }
    divisor = GreatestCommonDivisor(fraction.Numerator, fraction.Denominator)
    return Fractional{fraction.Numerator / divisor, fraction.Denominator / divisor}
}
func FastAdd(base Fractional, relative Fractional) Fractional {
    return Fractional{
        base.Numerator * relative.Denominator + relative.Numerator * base.Denominator,
        base.Denominator * relative.Denominator,
    }
}
func FastSubtract(base Fractional, relative Fractional) Fractional {
    return Fractional{
        base.Numerator * relative.Denominator - relative.Numerator * base.Denominator,
        base.Denominator * relative.Denominator,
    }
}
func FastMultiply(base Fractional, relative Fractional) Fractional {
    return Fractional{
        base.Numerator * relative.Numerator,
        base.Denominator * relative.Denominator,
    }
}
func FastDivide(base Fractional, relative Fractional) Fractional {
    return Fractional{
        base.Numerator * relative.Denominator,
        relative.Numerator * base.Denominator,
    }
}
func ReducingAdd(base Fractional, relative Fractional) Fractional {
    multiple := LeastCommonMultiple(base.Denominator, relative.Denominator)
    result := Fractional{
        base.Numerator * (multiple / base.Denominator) + relative.Numerator * (multiple / relative.Denominator),
        multiple,
    }
    return Reduce(result);
}
func ReducingSubtract(base Fractional, relative Fractional) Fractional {
    multiple := LeastCommonMultiple(base.Denominator, relative.Denominator)
    result := Fractional{
        base.Numerator * (multiple / base.Denominator) - relative.Numerator * (multiple / relative.Denominator),
        multiple,
    }
    return Reduce(result);
}
func ReducingMultiply(base Fractional, relative Fractional) Fractional {
    var (bnrd_divisor, bdrn_divisor uint)
    if base.Numerator > 0 {
        bnrd_divisor = GreatestCommonDivisor(base.Numerator, relative.Denominator)
    } else {
        bnrd_divisor = 1
    }
    if relative.Numerator > 0 {
        bdrn_divisor = GreatestCommonDivisor(base.Denominator, relative.Numerator)
    } else {
        bdrn_divisor = 1
    }
    return Fractional{
        (base.Numerator / bnrd_divisor) * (relative.Numerator / bdrn_divisor),
        (base.Denominator / bdrn_divisor) * (relative.Denominator / bnrd_divisor),
    }
}
func ReducingDivide(base Fractional, relative Fractional) Fractional {
    bnrn_divisor := GreatestCommonDivisor(base.Numerator, relative.Numerator)
    bdrd_divisor := GreatestCommonDivisor(base.Denominator, relative.Denominator)
    return Fractional{
        (base.Numerator / bnrn_divisor) * (relative.Denominator / bdrd_divisor),
        (base.Denominator / bdrd_divisor) * (relative.Numerator / bnrn_divisor),
    }
}
func FastLesser(base Fractional, relative Fractional) bool {
    return base.Numerator * relative.Denominator < relative.Numerator * base.Denominator
}
func FastGreater(base Fractional, relative Fractional) bool {
    return base.Numerator * relative.Denominator > relative.Numerator * base.Denominator
}
func FastEqual(base Fractional, relative Fractional) bool {
    return base.Numerator * relative.Denominator == relative.Numerator * base.Denominator
}
func FastNotGreater(base Fractional, relative Fractional) bool {
    return base.Numerator * relative.Denominator <= relative.Numerator * base.Denominator
}
func FastNotLesser(base Fractional, relative Fractional) bool {
    return base.Numerator * relative.Denominator >= relative.Numerator * base.Denominator
}
func FastNotEqual(base Fractional, relative Fractional) bool {
    return base.Numerator * relative.Denominator != relative.Numerator * base.Denominator
}
func ReducingLesser(base Fractional, relative Fractional) bool {
    factor := LeastCommonMultiple(base.Numerator, relative.Denominator)
    return base.Numerator * (factor / base.Denominator) < relative.Numerator * (factor / relative.Denominator)
        
}
func ReducingGreater(base Fractional, relative Fractional) bool {
    factor := LeastCommonMultiple(base.Numerator, relative.Denominator)
    return base.Numerator * (factor / base.Denominator) > relative.Numerator * (factor / relative.Denominator)
        
}
func ReducingEqual(base Fractional, relative Fractional) bool {
    factor := LeastCommonMultiple(base.Numerator, relative.Denominator)
    return base.Numerator * (factor / base.Denominator) == relative.Numerator * (factor / relative.Denominator)
        
}
func ReducingNotGreater(base Fractional, relative Fractional) bool {
    factor := LeastCommonMultiple(base.Numerator, relative.Denominator)
    return base.Numerator * (factor / base.Denominator) <= relative.Numerator * (factor / relative.Denominator)
        
}
func ReducingNotLesser(base Fractional, relative Fractional) bool {
    factor := LeastCommonMultiple(base.Numerator, relative.Denominator)
    return base.Numerator * (factor / base.Denominator) >= relative.Numerator * (factor / relative.Denominator)
        
}
func ReducingNotEqual(base Fractional, relative Fractional) bool {
    factor := LeastCommonMultiple(base.Numerator, relative.Denominator)
    return base.Numerator * (factor / base.Denominator) != relative.Numerator * (factor / relative.Denominator)
        
}
func FastArithmetic() Arithmetical {
    return Arithmetical{FastAdd, FastSubtract, FastMultiply, FastDivide}
}
func ReducingArithmetic() Arithmetical {
    return Arithmetical{ReducingAdd, ReducingSubtract, ReducingMultiply, ReducingDivide}
}
func FastRelation() Relational {
    return Relational{FastLesser, FastGreater, FastEqual, FastNotGreater, FastNotLesser, FastNotEqual}
}
func ReducingRelation() Relational {
    return Relational{ReducingLesser, ReducingGreater, ReducingEqual, ReducingNotGreater, ReducingNotLesser, ReducingNotEqual}
}
func FastOperation() Operational {
    return Operational{FastArithmetic(), FastRelation()}
}
func ReducingOperation() Operational {
    return Operational{ReducingArithmetic(), ReducingRelation()}
}

