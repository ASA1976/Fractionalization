// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
mod fractionalization;
use fractionalization::*;
type NaturalFractional = Fractional<u32>;
type NaturalOperational = Operational<u32>;
fn display_fraction(fraction: NaturalFractional) {
    print!("{}", fraction.0);
    if fraction.1 != 1 {
        print!("/{}", fraction.1);
    }
}
fn display_arithmetic(left: NaturalFractional, symbol: &str, right: NaturalFractional, equals: NaturalFractional) {
    display_fraction(left);
    print!(" {} ", symbol);
    display_fraction(right);
    print!(" = ");
    display_fraction(equals);
    println!();
}
fn display_relation(left: NaturalFractional, symbol: &str, right: NaturalFractional, result: bool) {
    display_fraction(left);
    print!(" {} ", symbol);
    display_fraction(right);
    print!(" = ");
    if result {
        println!("true");
    } else {
        println!("false");
    }
}
fn display_operations(operation: NaturalOperational, base: NaturalFractional, relative: NaturalFractional) {
    let arithmetic = operation.arithmetic;
    let relation = operation.relation;
    display_arithmetic(base, "+", relative, {arithmetic.add}(base, relative));
    display_arithmetic(base, "-", relative, {arithmetic.subtract}(base, relative));
    display_arithmetic(base, "*", relative, {arithmetic.multiply}(base, relative));
    display_arithmetic(base, "/", relative, {arithmetic.divide}(base, relative));
    display_relation(base, "<", relative, {relation.lesser}(base, relative));
    display_relation(base, ">", relative, {relation.greater}(base, relative));
    display_relation(base, "==", relative, {relation.equal}(base, relative));
    display_relation(base, "<=", relative, {relation.not_greater}(base, relative));
    display_relation(base, ">=", relative, {relation.not_lesser}(base, relative));
    display_relation(base, "!=", relative, {relation.not_equal}(base, relative));
}
fn main() {
    let natural_fast_operation = fast_operation::<u32>();
    let natural_reducing_operation = reducing_operation::<u32>();
    let x = (1, 6);
    let y = (1, 12);
    println!("Fast Fractional Operations");
    display_operations(natural_fast_operation, x, y);
    println!();
    println!("Reducing Fractional Operations");
    display_operations(natural_reducing_operation, x, y);
}
