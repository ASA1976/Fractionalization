# © 2018 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0
namespace eval ::fractionalization {
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
            set LNRDDivisor [GreatestCommonDivisor $Base(Numerator) $Relative(Denominator)]
        } else {
            set LNRDDivisor 1
        }
        if {$Relative(Numerator) > 0} {
            set LDRNDivisor [GreatestCommonDivisor $Relative(Numerator) $Base(Denominator)]
        } else {
            set LDRNDivisor 1
        }
        set Result(Numerator) [expr ($Base(Numerator) / $LNRDDivisor) * ($Relative(Numerator) / $LDRNDivisor)]
        set Result(Denominator) [expr ($Base(Denominator) / $LDRNDivisor) * ($Relative(Denominator) / $LNRDDivisor)]
        return [array get Result]
    }
    proc ReducingDivide {BaseFraction RelativeFraction} {
        array set Base $BaseFraction
        array set Relative $RelativeFraction
        set LNRNDivisor [GreatestCommonDivisor $Base(Numerator) $Relative(Numerator)]
        set LDRDDivisor [GreatestCommonDivisor $Base(Denominator) $Relative(Denominator)]
        set Result(Numerator) [expr ($Base(Numerator) / $LNRNDivisor) * ($Relative(Denominator) / $LDRDDivisor)]
        set Result(Denominator) [expr ($Base(Denominator) / $LDRDDivisor) * ($Relative(Numerator) / $LNRNDivisor)]
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
    set FastArithmetic(Add) [namespace origin FastAdd]
    set FastArithmetic(Subtract) [namespace origin FastSubtract]
    set FastArithmetic(Multiply) [namespace origin FastMultiply]
    set FastArithmetic(Divide) [namespace origin FastDivide]
    set ReducingArithmetic(Add) [namespace origin ReducingAdd]
    set ReducingArithmetic(Subtract) [namespace origin ReducingSubtract]
    set ReducingArithmetic(Multiply) [namespace origin ReducingMultiply]
    set ReducingArithmetic(Divide) [namespace origin ReducingDivide]
    set FastRelation(Lesser) [namespace origin FastLesser]
    set FastRelation(Greater) [namespace origin FastGreater]
    set FastRelation(Equal) [namespace origin FastEqual]
    set FastRelation(NotGreater) [namespace origin FastNotGreater]
    set FastRelation(NotLesser) [namespace origin FastNotLesser]
    set FastRelation(NotEqual) [namespace origin FastNotEqual]
    set ReducingRelation(Lesser) [namespace origin ReducingLesser]
    set ReducingRelation(Greater) [namespace origin ReducingGreater]
    set ReducingRelation(Equal) [namespace origin ReducingEqual]
    set ReducingRelation(NotGreater) [namespace origin ReducingNotGreater]
    set ReducingRelation(NotLesser) [namespace origin ReducingNotLesser]
    set ReducingRelation(NotEqual) [namespace origin ReducingNotEqual]
    set FastOperation(Arithmetic) [array get FastArithmetic]
    set FastOperation(Relation) [array get FastRelation]
    set ReducingOperation(Arithmetic) [array get ReducingArithmetic]
    set ReducingOperation(Relation) [array get ReducingRelation]
}

