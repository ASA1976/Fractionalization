// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
import std.stdio;
import fractionalization;
alias NaturalFractional = Fractional!uint;
alias NaturalOperational = Operational!uint;
void DisplayFraction(NaturalFractional fraction)
{
    write(fraction.numerator);
    if (fraction.denominator != 1)
        write("/", fraction.denominator);
}
void DisplayArithmetic(NaturalFractional left, string symbol, NaturalFractional right, NaturalFractional equals)
{
    DisplayFraction(left);
    write(" ", symbol, " ");
    DisplayFraction(right);
    write(" = ");
    DisplayFraction(equals);
    writeln();
}
void DisplayRelation(NaturalFractional left, string symbol, NaturalFractional right, bool result)
{
    DisplayFraction(left);
    write(" ", symbol, " ");
    DisplayFraction(right);
    write(" = ");
    if (result)
        writeln("true");
    else
        writeln("false");
}
void DisplayOperations(NaturalOperational operation, NaturalFractional base, NaturalFractional relative)
{
    const auto arithmetic = operation.arithmetic;
    const auto relation = operation.relation;
    DisplayArithmetic(base, "+", relative, arithmetic.add(base, relative));
    DisplayArithmetic(base, "-", relative, arithmetic.subtract(base, relative));
    DisplayArithmetic(base, "*", relative, arithmetic.multiply(base, relative));
    DisplayArithmetic(base, "/", relative, arithmetic.divide(base, relative));
    DisplayRelation(base, "<", relative, relation.lesser(base, relative));
    DisplayRelation(base, ">", relative, relation.greater(base, relative));
    DisplayRelation(base, "==", relative, relation.equal(base, relative));
    DisplayRelation(base, "<=", relative, relation.not_greater(base, relative));
    DisplayRelation(base, ">=", relative, relation.not_lesser(base, relative));
    DisplayRelation(base, "!=", relative, relation.not_equal(base, relative));
}
void main()
{
    const auto natural_fast_operation = FastOperation!uint;
    const auto natural_reducing_operation = ReducingOperation!uint;
    const auto x = NaturalFractional(1, 6);
    const auto y = NaturalFractional(1, 12);
    writeln("Fast Fractional Operations");
    DisplayOperations(natural_fast_operation, x, y);
    writeln();
    writeln("Reducing Fractional Operations");
    DisplayOperations(natural_reducing_operation, x, y);
}
