# coding: utf-8
# © 2018 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0
FractionalType = type( 'Fractional', (), {} ) 
ArithmeticalType = type( 'Arithmetical', (), {} ) 
RelationalType = type( 'Relational', (), {} ) 
OperationalType = type( 'Operational', (), {} ) 
def Fractional( numerator = 0, denominator = 1 ):
    fraction = FractionalType()
    fraction.numerator = numerator
    fraction.denominator = denominator
    return fraction
def Arithmetical( add, subtract, multiply, divide ):
    arithmetic = ArithmeticalType()
    arithmetic.add = add
    arithmetic.subtract = subtract
    arithmetic.multiply = multiply
    arithmetic.divide = divide
    return arithmetic
def Relational( lesser, greater, equal, not_greater, not_lesser, not_equal ):
    relation = RelationalType()
    relation.lesser = lesser
    relation.greater = greater
    relation.equal = equal
    relation.not_greater = not_greater
    relation.not_lesser = not_lesser
    relation.not_equal = not_equal
    return relation
def Operational( arithmetic, relation ):
    operation = OperationalType()
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
        return int( a / divisor * b )
    return int( b / divisor * a )
def reduce( fraction ):
    if fraction.numerator == 0:
        result = Fractional()
    else:
        divisor = greatest_common_divisor( fraction.numerator, fraction.denominator )
        result = Fractional( int(fraction.numerator / divisor), int(fraction.denominator / divisor) )
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
    result.numerator = base.numerator * int(result.denominator / base.denominator)
    result.numerator += relative.numerator * int(result.denominator / relative.denominator)
    return reduce( result )
def reducing_subtract( base, relative ):
    result = Fractional()
    result.denominator = least_common_multiple( base.denominator, relative.denominator )
    result.numerator = base.numerator * int(result.denominator / base.denominator)
    result.numerator -= relative.numerator * int(result.denominator / relative.denominator)
    return reduce( result )
def reducing_multiply( base, relative ):
    if base.numerator > 0:
        bnrd_divisor = greatest_common_divisor( base.numerator, relative.denominator )
    else:
        bnrd_divisor = 1
    if relative.numerator > 0:
        bdrn_divisor = greatest_common_divisor( base.denominator, relative.numerator )
    else:
        bdrn_divisor = 1
    result = Fractional()
    result.numerator = int(base.numerator / bnrd_divisor) * int(relative.numerator / bdrn_divisor )
    result.denominator = int(base.denominator / bdrn_divisor) * int(relative.denominator / bnrd_divisor )
    return result
def reducing_divide( base, relative ):
    bnrn_divisor = greatest_common_divisor( base.numerator, relative.numerator )
    bdrd_divisor = greatest_common_divisor( base.denominator, relative.denominator )
    result = Fractional()
    result.numerator = int(base.numerator / bnrn_divisor) * int(relative.denominator / bdrd_divisor )
    result.denominator = int(base.denominator / bdrd_divisor) * int(relative.numerator / bnrn_divisor )
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
    return base.numerator * int(factor / base.denominator) < relative.numerator * int(factor / relative.denominator)
def reducing_greater( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * int(factor / base.denominator) > relative.numerator * int(factor / relative.denominator)
def reducing_equal( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * int(factor / base.denominator) == relative.numerator * int(factor / relative.denominator)
def reducing_not_greater( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * int(factor / base.denominator) <= relative.numerator * int(factor / relative.denominator)
def reducing_not_lesser( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * int(factor / base.denominator) >= relative.numerator * int(factor / relative.denominator)
def reducing_not_equal( base, relative ):
    factor = least_common_multiple( base.denominator, relative.denominator )
    return base.numerator * int(factor / base.denominator) != relative.numerator * int(factor / relative.denominator)
fast_arithmetic = Arithmetical( fast_add, fast_subtract, fast_multiply, fast_divide )
reducing_arithmetic = Arithmetical( reducing_add, reducing_subtract, reducing_multiply, reducing_divide )
fast_relation = Relational( fast_lesser, fast_greater, fast_equal, fast_not_greater, fast_not_lesser, fast_not_equal )
reducing_relation = Relational( reducing_lesser, reducing_greater, reducing_equal, reducing_not_greater, reducing_not_lesser, reducing_not_equal )
fast_operation = Operational( fast_arithmetic, fast_relation )
reducing_operation = Operational( reducing_arithmetic, reducing_relation )

