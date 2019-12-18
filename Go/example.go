// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
package main
import (
    . "fractionalization"
    . "fmt"
)
func DisplayFraction(fraction Fractional) {
    Print(fraction.Numerator)
    if fraction.Denominator != 1 {
        Print("/", fraction.Denominator)
    }
}
func DisplayArithmetic(left Fractional, symbol string, right Fractional, equals Fractional) {
    DisplayFraction(left)
    Print(" ", symbol, " ")
    DisplayFraction(right)
    Print(" = ")
    DisplayFraction(equals)
    Println()
}
func DisplayRelation(left Fractional, symbol string, right Fractional, result bool) {
    DisplayFraction(left)
    Print(" ", symbol, " ")
    DisplayFraction(right)
    Print(" = ")
    if result {
        Println("true")
    } else {
        Println("false")
    }
}
func DisplayOperations(operation Operational, base Fractional, relative Fractional) {
    arithmetic := operation.Arithmetic
    relation := operation.Relation
    DisplayArithmetic(base, "+", relative, arithmetic.Add(base, relative))
    DisplayArithmetic(base, "-", relative, arithmetic.Subtract(base, relative))
    DisplayArithmetic(base, "*", relative, arithmetic.Multiply(base, relative))
    DisplayArithmetic(base, "/", relative, arithmetic.Divide(base, relative))
    DisplayRelation(base, "<", relative, relation.Lesser(base, relative))
    DisplayRelation(base, ">", relative, relation.Greater(base, relative))
    DisplayRelation(base, "==", relative, relation.Equal(base, relative))
    DisplayRelation(base, "<=", relative, relation.NotGreater(base, relative))
    DisplayRelation(base, ">=", relative, relation.NotLesser(base, relative))
    DisplayRelation(base, "!=", relative, relation.NotEqual(base, relative))
}
func main() {
    x := Fractional{1, 6}
    y := Fractional{1, 12};
    Println("Fast Fractional Operations");
    DisplayOperations(FastOperation(), x, y);
    Println();
    Println("Reducing Fractional Operations");
    DisplayOperations(ReducingOperation(), x, y);
}
