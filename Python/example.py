# coding: cp1252
# © 2018 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0
from fractionalization import Fractional, fast_operation, reducing_operation
def display_fraction( fraction ):
    output = str( fraction.numerator )
    if fraction.denominator != 1:
        output += "/" + str( fraction.denominator )
    return output
def display_arithmetic( base, symbol, relative, equals ):
    output = display_fraction( base )
    output += " " + symbol + " "
    output += display_fraction( relative )
    output += " = "
    output += display_fraction( equals )
    print output
def display_relation( base, symbol, relative, result ):
    output = display_fraction( base )
    output += " " + symbol + " "
    output += display_fraction( relative )
    output += " = "
    if result:
        output += "true"
    else:
        output += "false"
    print output
def display_operations( operation, base, relative ):
    arithmetic = operation.arithmetic
    relation = operation.relation
    display_arithmetic( base, "+", relative, arithmetic.add( base, relative ) )
    display_arithmetic( base, "-", relative, arithmetic.subtract( base, relative ) )
    display_arithmetic( base, "*", relative, arithmetic.multiply( base, relative ) )
    display_arithmetic( base, "/", relative, arithmetic.divide( base, relative ) )
    display_relation( base, "<", relative, relation.lesser( base, relative ) )
    display_relation( base, ">", relative, relation.greater( base, relative ) )
    display_relation( base, "==", relative, relation.equal( base, relative ) )
    display_relation( base, "<=", relative, relation.not_greater( base, relative ) )
    display_relation( base, ">=", relative, relation.not_lesser( base, relative ) )
    display_relation( base, "!=", relative, relation.not_equal( base, relative ) )
x = Fractional( 1, 6 )
y = Fractional( 1, 12 )
print "Fast Fractional Operations" 
display_operations( fast_operation, x, y )
print
print "Reducing Fractional Operations"
display_operations( reducing_operation, x, y )

