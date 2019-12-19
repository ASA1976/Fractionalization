# © 2018 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0
namespace eval ::fractionalization {
    proc Zero {} {
        return {Numerator 0 Denominator 1}
    }
    proc GreatestCommonDivisor {UnsignedIntegerA UnsignedIntegerB} {
        # Euclidean Algorithm
        if {$UnsignedIntegerA >= $UnsignedIntegerB} {
            set Dividend $UnsignedIntegerA
            set Divisor $UnsignedIntegerB
        } else {
            set Dividend $UnsignedIntegerB
            set Divisor $UnsignedIntegerA
        }
        while {[set Remainder [expr $Dividend % $Divisor]] > 0} {
            set Dividend $Divisor
            set Divisor $Remainder
        }
        return $Divisor
    }
    proc LeastCommonMultiple {UnsignedIntegerA UnsignedIntegerB} {
        set Divisor [GreatestCommonDivisor $UnsignedIntegerA $UnsignedIntegerB]
        if {$UnsignedIntegerA > $UnsignedIntegerB} {
            return [expr $UnsignedIntegerA / $Divisor * $UnsignedIntegerB]
        }
        return [expr $UnsignedIntegerB / $Divisor * $UnsignedIntegerA]
    }
    proc Reduce {FractionArray} {
        array set Fraction $FractionArray
        if {$Fraction(Numerator) == 0} {
            set Result(Numerator) 0
            set Result(Denominator) 1
        } else {
            set Divisor [GreatestCommonDivisor $Fraction(Numerator) $Fraction(Denominator)]
            set Result(Numerator) [expr $Fraction(Numerator) / $Divisor]
            set Result(Denominator) [expr $Fraction(Denominator) / $Divisor] 
        }
        return [array get Result]
    }
    proc FastAdd {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Result(Numerator) [expr $Base(Numerator) * $Relative(Denominator) + $Relative(Numerator) * $Base(Denominator)]
        set Result(Denominator) [expr $Base(Denominator) * $Relative(Denominator)]
        return [array get Result]
    }
    proc FastSubtract {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Result(Numerator) [expr $Base(Numerator) * $Relative(Denominator) - $Relative(Numerator) * $Base(Denominator)]
        set Result(Denominator) [expr $Base(Denominator) * $Relative(Denominator)]
        return [array get Result]
    }
    proc FastMultiply {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Result(Numerator) [expr $Base(Numerator) * $Relative(Numerator)]
        set Result(Denominator) [expr $Base(Denominator) * $Relative(Denominator)]
        return [array get Result]
    }
    proc FastDivide {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Result(Numerator) [expr $Base(Numerator) * $Relative(Denominator)]
        set Result(Denominator) [expr $Base(Denominator) * $Relative(Numerator)]
        return [array get Result]
    }
    proc ReducingAdd {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Result(Denominator) [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        set Result(Numerator) [expr $Base(Numerator) * ($Result(Denominator) / $Base(Denominator))]
        incr Result(Numerator) [expr $Relative(Numerator) * ($Result(Denominator) / $Relative(Denominator))]
        return [Reduce [array get Result]]
    }
    proc ReducingSubtract {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Result(Denominator) [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        set Result(Numerator) [expr $Base(Numerator) * ($Result(Denominator) / $Base(Denominator))]
        incr Result(Numerator) [expr 0 - $Relative(Numerator) * ($Result(Denominator) / $Relative(Denominator))]
        return [Reduce [array get Result]]
    }
    proc ReducingMultiply {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        if {$Base(Numerator) > 0} {
            set BNRDDivisor [GreatestCommonDivisor $Base(Numerator) $Relative(Denominator)]
        } else {
            set BNRDDivisor 1
        }
        if {$Relative(Numerator) > 0} {
            set BDRNDivisor [GreatestCommonDivisor $Relative(Numerator) $Base(Denominator)]
        } else {
            set BDRNDivisor 1
        }
        set Result(Numerator) [expr ($Base(Numerator) / $BNRDDivisor) * ($Relative(Numerator) / $BDRNDivisor)]
        set Result(Denominator) [expr ($Base(Denominator) / $BDRNDivisor) * ($Relative(Denominator) / $BNRDDivisor)]
        return [array get Result]
    }
    proc ReducingDivide {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set BNRNDivisor [GreatestCommonDivisor $Base(Numerator) $Relative(Numerator)]
        set BDRDDivisor [GreatestCommonDivisor $Base(Denominator) $Relative(Denominator)]
        set Result(Numerator) [expr ($Base(Numerator) / $BNRNDivisor) * ($Relative(Denominator) / $BDRDDivisor)]
        set Result(Denominator) [expr ($Base(Denominator) / $BDRDDivisor) * ($Relative(Numerator) / $BNRNDivisor)]
        return [array get Result]
    }
    proc FastLesser {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        return [expr $Base(Numerator) * $Relative(Denominator)< $Relative(Numerator) * $Base(Denominator)]
    }
    proc FastGreater {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        return [expr $Base(Numerator) * $Relative(Denominator) > $Relative(Numerator) * $Base(Denominator)]
    }
    proc FastEqual {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        return [expr $Base(Numerator) * $Relative(Denominator) == $Relative(Numerator) * $Base(Denominator)]
    }
    proc FastNotGreater {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        return [expr $Base(Numerator) * $Relative(Denominator) <= $Relative(Numerator) * $Base(Denominator)]
    }
    proc FastNotLesser {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        return [expr $Base(Numerator) * $Relative(Denominator) >= $Relative(Numerator) * $Base(Denominator)]
    }
    proc FastNotEqual {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        return [expr $Base(Numerator) * $Relative(Denominator) != $Relative(Numerator) * $Base(Denominator)]
    }
    proc ReducingLesser {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Factor [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        return [expr $Base(Numerator) * ($Factor / $Base(Denominator)) < $Relative(Numerator) * ($Factor / $Relative(Denominator))]
    }
    proc ReducingGreater {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Factor [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        return [expr $Base(Numerator) * ($Factor / $Base(Denominator)) > $Relative(Numerator) * ($Factor / $Relative(Denominator))]
    }
    proc ReducingEqual {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Factor [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        return [expr $Base(Numerator) * ($Factor / $Base(Denominator)) == $Relative(Numerator) * ($Factor / $Relative(Denominator))]
    }
    proc ReducingNotGreater {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Factor [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        return [expr $Base(Numerator) * ($Factor / $Base(Denominator)) <= $Relative(Numerator) * ($Factor / $Relative(Denominator))]
    }
    proc ReducingNotLesser {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Factor [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        return [expr $Base(Numerator) * ($Factor / $Base(Denominator)) >= $Relative(Numerator) * ($Factor / $Relative(Denominator))]
    }
    proc ReducingNotEqual {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set Factor [LeastCommonMultiple $Base(Denominator) $Relative(Denominator)]
        return [expr $Base(Numerator) * ($Factor / $Base(Denominator)) != $Relative(Numerator) * ($Factor / $Relative(Denominator))]
    }
    proc FastArithmetic {} {
        set Arithmetic(Add) [namespace origin FastAdd]
        set Arithmetic(Subtract) [namespace origin FastSubtract]
        set Arithmetic(Multiply) [namespace origin FastMultiply]
        set Arithmetic(Divide) [namespace origin FastDivide]
        return [array get Arithmetic]
    }
    proc ReducingArithmetic {} {
        set Arithmetic(Add) [namespace origin ReducingAdd]
        set Arithmetic(Subtract) [namespace origin ReducingSubtract]
        set Arithmetic(Multiply) [namespace origin ReducingMultiply]
        set Arithmetic(Divide) [namespace origin ReducingDivide]
        return [array get Arithmetic]
    }
    proc FastRelation {} {
        set Relation(Lesser) [namespace origin FastLesser]
        set Relation(Greater) [namespace origin FastGreater]
        set Relation(Equal) [namespace origin FastEqual]
        set Relation(NotGreater) [namespace origin FastNotGreater]
        set Relation(NotLesser) [namespace origin FastNotLesser]
        set Relation(NotEqual) [namespace origin FastNotEqual]
        return [array get Relation]
    }
    proc ReducingRelation {} {
        set Relation(Lesser) [namespace origin ReducingLesser]
        set Relation(Greater) [namespace origin ReducingGreater]
        set Relation(Equal) [namespace origin ReducingEqual]
        set Relation(NotGreater) [namespace origin ReducingNotGreater]
        set Relation(NotLesser) [namespace origin ReducingNotLesser]
        set Relation(NotEqual) [namespace origin ReducingNotEqual]
        return [array get Relation]
    }
    proc FastOperation {} {
        set Operation(Arithmetic) [array get FastArithmetic]
        set Operation(Relation) [array get FastRelation]
        return [array get Operation]
    }
    proc ReducingOperation {} {
        set Operation(Arithmetic) [array get ReducingArithmetic]
        set Operation(Relation) [array get ReducingRelation]
        return [array get Operation]
    }
}

