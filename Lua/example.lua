-- © 2019 Aaron Sami Abassi
-- Licensed under the Academic Free License version 3.0
local fractionalization = require "fractionalization"
local function display_fraction(fraction)
    io.write(fraction.numerator)
    if fraction.denominator ~= 1 then
        io.write("/")
        io.write(fraction.denominator)
    end
end
local function display_arithmetic(left, symbol, right, equals)
    display_fraction(left)
    io.write(" ", symbol, " ")
    display_fraction(right)
    io.write(" = ")
    display_fraction(equals)
    print()
end
local function display_relation(left, symbol, right, result)
    display_fraction(left)
    io.write(" ",  symbol, " ")
    display_fraction(right)
    io.write(" = ")
    if result then
        print("true")
    else
        print("false")
    end
end
local function display_operations(operation, base, relative)
    local arithmetic = operation.arithmetic
    local relation = operation.relation
    display_arithmetic(base, "+", relative, arithmetic.add(base, relative))
    display_arithmetic(base, "-", relative, arithmetic.subtract(base, relative))
    display_arithmetic(base, "*", relative, arithmetic.multiply(base, relative))
    display_arithmetic(base, "/", relative, arithmetic.divide(base, relative))
    display_relation(base, "<", relative, relation.lesser(base, relative))
    display_relation(base, ">", relative, relation.greater(base, relative))
    display_relation(base, "==", relative, relation.equal(base, relative))
    display_relation(base, "<=", relative, relation.not_greater(base, relative))
    display_relation(base, ">=", relative, relation.not_lesser(base, relative))
    display_relation(base, "~=", relative, relation.not_equal(base, relative))
end
local fast_operation = fractionalization.fast_operation
local reducing_operation = fractionalization.reducing_operation
local x = {numerator=1, denominator=6}
local y = {numerator=1, denominator=12}
print("Fast Fractional Operations")
display_operations(fast_operation, x, y)
print()
print("Reducing Fractional Operations")
display_operations(reducing_operation, x, y)

