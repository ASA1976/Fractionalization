# © 2018 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0
def Fractional( numerator = 0, denominator = 1 ):
    Fractional = type( 'Fractional', (), {} ) 
    fraction = Fractional()
    fraction.numerator = numerator
    fraction.denominator = denominator
    return fraction
def Arithmetical( add, subtract, multiply, divide ):
    Arithmetical = type( 'Arithmetical', (), {} ) 
    arithmetic = Arithmetical()
    arithmetic.add = add
    arithmetic.subtract = subtract
    arithmetic.multiply = multiply
    arithmetic.divide = divide
    return arithmetic
def Relational( lesser, greater, equal, not_greater, not_lesser, not_equal ):
    Relational = type( 'Relational', (), {} ) 
    relation = Relational()
    relation.lesser = lesser
    relation.greater = greater
    relation.equal = equal
    relation.not_greater = not_greater
    relation.not_lesser = not_lesser
    relation.not_equal = not_equal
    return relation
def Operational( arithmetic, relation ):
    Operational = type( 'Operational', (), {} ) 
    operation = Operational()
    operation.arithmetic = arithmetic
    operation.relation = relation
    return operation
def greatest_common_divisor( a, b ):
    # Euclidean Algorithm
    if a > b:
        dividend = a
        divisor = b
    else:
        dividend = b
        divisor = a
    remainder = dividend % divisor
    while remainder > 0:
        dividend = divisor
        divisor = remainder
        remainder = dividend % divisor
    return divisor
def least_common_multiple( a, b ):
    divisor = greatest_common_divisor( a, b )
    if a > b:
        return a / divisor * b
    return b / divisor * a
def reduce( fraction ):
    if fraction.numerator == 0:
        result = Fractional()
    else:
        divisor = greatest_common_divisor( fraction.numerator, fraction.denominator )
        result = Fractional( fraction.numerator / divisor, fraction.denominator / divisor )
    return result
def fast_add( base, relative ):
    return Fractional( 
        base.numerator * relative.denominator + relative.numerator * base.denominator,
        base.denominator * relative.denominator
    )
def fast_subtract( base, relative ):
    return Fractional(
        base.numerator * relative.denominator - relative.numerator * base.denominator,
        base.denominator * relative.denominator
    )
def fast_multiply( base, relative ):
    return Fractional(
        base.numerator * relative.numerator,
        base.denominator * relative.denominator
    )
def fast_divide( base, relative ):
    return Fractional(
        base.numerator * relative.denominator,
        base.denominator * relative.numerator
    )
def reducing_add( base, relative ):
    result = Fractional()
    result.denominator = least_common_multiple( base.denominator, relative.denominator )
    result.numerator = base.numerator * (result.denominator / base.denominator)
    result.numerator += relative.numerator * (result.denominator / relative.denominator)
    return reduce( result )
def reducing_subtract( base, relative ):
    result = Fractional()
    result.denominator = least_common_multiple( base.denominator, relative.denominator )
    result.numerator = base.numerator * (result.denominator / base.denominator)
    result.numerator -= relative.numerator * (result.denominator / relative.denominator)
    return reduce( result )
def reducing_multiply( base, relative ):
    lnrd_divisor = greatest_common_divisor( base.numerator, relative.denominator )
    ldrn_divisor = greatest_common_divisor( base.denominator, relative.numerator )
    result = Fractional()
    result.numerator = (base.numerator / lnrd_divisor) * (relative.numerator / ldrn_divisor )
    result.denominator = (base.denominator / ldrn_divisor) * (relative.denominator / lnrd_divisor )
    return result
def reducing_divide( base, relative ):
    lnrn_divisor = greatest_common_divisor( base.numerator, relative.numerator )
    ldrd_divisor = greatest_common_divisor( base.denominator, relative.denominator )
    result = Fractional()
    result.numerator = (base.numerator / lnrn_divisor) * (relative.denominator / ldrd_divisor )
    result.denominator = (base.denominator / ldrd_divisor) * (relative.numerator / lnrn_divisor )
    return result
def fast_lesser( base, relative ):
    return base.numerator * relative.denominator < relative.numerator * base.denominator
def fast_greater( base, relative ):
    return base.numerator * relative.denominator > relative.numerator * base.denominator
def fast_equal( base, relative ):
    return base.numerator * relative.denominator == relative.numerator * base.denominator
def fast_not_greater( base, relative ):
    return base.numerator * relative.denominator <= relative.numerator * base.denominator
def fast_not_lesser( base, relative ):
    return base.numerator * relative.denominator >= relative.numerator * base.denominator
def fast_not_equal( base, relative ):
    return base.numerator * relative.denominator != relative.numerator * base.denominator
def reducing_lesser( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * (factor / base.denominator) < relative.numerator * (factor / relative.denominator)
def reducing_greater( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * (factor / base.denominator) > relative.numerator * (factor / relative.denominator)
def reducing_equal( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * (factor / base.denominator) == relative.numerator * (factor / relative.denominator)
def reducing_not_greater( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * (factor / base.denominator) <= relative.numerator * (factor / relative.denominator)
def reducing_not_lesser( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * (factor / base.denominator) >= relative.numerator * (factor / relative.denominator)
def reducing_not_equal( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * (factor / base.denominator) != relative.numerator * (factor / relative.denominator)
fast_arithmetic = Arithmetical( fast_add, fast_subtract, fast_multiply, fast_divide )
reducing_arithmetic = Arithmetical( reducing_add, reducing_subtract, reducing_multiply, reducing_divide )
fast_relation = Relational( fast_lesser, fast_greater, fast_equal, fast_not_greater, fast_not_lesser, fast_not_equal )
reducing_relation = Relational( reducing_lesser, reducing_greater, reducing_equal, reducing_not_greater, reducing_not_lesser, reducing_not_equal )
fast_operation = Operational( fast_arithmetic, fast_relation )
reducing_operation = Operational( reducing_arithmetic, reducing_relation )

