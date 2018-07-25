# © 2018 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0
source fractionalization.tcl
proc DisplayFraction {FractionArray} {
    array set Fraction $FractionArray
    puts -nonewline [format {%u} $Fraction(Numerator)]
    if {$Fraction(Denominator) != 1} {
        puts -nonewline [format {/%u} $Fraction(Denominator)]
    }
}
proc DisplayArithmetic {Base Symbol Relative Equals} {
    DisplayFraction $Base
    puts -nonewline [format { %s } $Symbol]
    DisplayFraction $Relative
    puts -nonewline { = }
    DisplayFraction $Equals
    puts {}
}
proc DisplayRelation {Base Symbol Relative Result} {
    DisplayFraction $Base
    puts -nonewline [format { %s } $Symbol]
    DisplayFraction $Relative
    puts -nonewline { = }
    if {$Result} {
        puts true
    } else {
        puts false
    }
}
proc DisplayOperations {OperationArray Base Relative} {
    array set Operation $OperationArray
    array set Arithmetic $Operation(Arithmetic)
    array set Relation $Operation(Relation)
    DisplayArithmetic $Base + $Relative [$Arithmetic(Add) $Base $Relative]
    DisplayArithmetic $Base - $Relative [$Arithmetic(Subtract) $Base $Relative]
    DisplayArithmetic $Base * $Relative [$Arithmetic(Multiply) $Base $Relative]
    DisplayArithmetic $Base / $Relative [$Arithmetic(Divide) $Base $Relative]
    DisplayRelation $Base < $Relative [$Relation(Lesser) $Base $Relative]
    DisplayRelation $Base > $Relative [$Relation(Greater) $Base $Relative]
    DisplayRelation $Base == $Relative [$Relation(Equal) $Base $Relative]
    DisplayRelation $Base <= $Relative [$Relation(NotGreater) $Base $Relative]
    DisplayRelation $Base >= $Relative [$Relation(NotLesser) $Base $Relative]
    DisplayRelation $Base != $Relative [$Relation(NotEqual) $Base $Relative]
}
set FastOperation [array get ::fractionalization::FastOperation]
set ReducingOperation [array get ::fractionalization::ReducingOperation] 
set X {Numerator 1 Denominator 6}
set Y {Numerator 1 Denominator 12}
puts {Fast Fractional Operations}
DisplayOperations $FastOperation $X $Y
puts {}
puts {Reducing Fractional Operations}
DisplayOperations $ReducingOperation $X $Y

