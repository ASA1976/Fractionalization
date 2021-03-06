﻿' © 2018 Aaron Sami Abassi
' Licensed under the Academic Free License version 3.0
Module Fractionalization

    Public Delegate Function ArithmeticalAbstract(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional

    Public Delegate Function RelationalAbstract(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean

    Public Structure Fractional

        Dim Numerator, Denominator As UInteger

        Sub New(ByRef Numerator As UInteger, Optional ByRef Denominator As UInteger = 1)
            Me.Numerator = Numerator
            Me.Denominator = Denominator
        End Sub

    End Structure

    Public Structure Arithmetical

        ReadOnly Add, Subtract, Multiply, Divide As ArithmeticalAbstract

        Sub New(ByRef Add As ArithmeticalAbstract, ByRef Subtract As ArithmeticalAbstract, ByRef Multiply As ArithmeticalAbstract, ByRef Divide As ArithmeticalAbstract)
            Me.Add = Add
            Me.Subtract = Subtract
            Me.Multiply = Multiply
            Me.Divide = Divide
        End Sub

    End Structure

    Public Structure Relational

        ReadOnly Lesser, Greater, Equal, NotGreater, NotLesser, NotEqual As RelationalAbstract

        Sub New(ByRef Lesser As RelationalAbstract, ByRef Greater As RelationalAbstract, ByRef Equal As RelationalAbstract, ByRef NotGreater As RelationalAbstract, ByRef NotLesser As RelationalAbstract, ByRef NotEqual As RelationalAbstract)
            Me.Lesser = Lesser
            Me.Greater = Greater
            Me.Equal = Equal
            Me.NotGreater = NotGreater
            Me.NotLesser = NotLesser
            Me.NotEqual = NotEqual
        End Sub

    End Structure

    Public Structure Operational

        ReadOnly Arithmetic As Arithmetical

        ReadOnly Relation As Relational

        Sub New(ByRef Arithmetic As Arithmetical, ByRef Relation As Relational)
            Me.Arithmetic = Arithmetic
            Me.Relation = Relation
        End Sub

    End Structure

    Public ReadOnly Zero As New Fractional(0, 1)

    Public Function GreatestCommonDivisor(A As UInteger, B As UInteger) As UInteger
        ' Eclidean Algorithm
        Dim Dividend, Divisor, Remainder As UInteger
        If A > B Then
            Dividend = A
            Divisor = B
        Else
            Dividend = B
            Divisor = A
        End If
        While (Remainder = Dividend Mod Divisor) > 0
            Dividend = Divisor
            Divisor = Remainder
        End While
        Return Divisor
    End Function

    Public Function LeastCommonMultiple(A As UInteger, B As UInteger) As UInteger
        Dim Divisor As UInteger
        Divisor = GreatestCommonDivisor(A, B)
        If A > B Then
            Return A / Divisor * B
        End If
        Return B / Divisor * A
    End Function

    Public Function Reduce(ByRef Fraction As Fractional) As Fractional
        Dim Divisor As UInteger
        Dim Result As Fractional
        If Fraction.Numerator = 0 Then
            Result.Numerator = 0
            Result.Denominator = 1
        Else
            Divisor = GreatestCommonDivisor(Fraction.Numerator, Fraction.Denominator)
            Result.Numerator = Fraction.Numerator / Divisor
            Result.Denominator = Fraction.Denominator / Divisor
        End If
        Return Result
    End Function

    Public Function FastAdd(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim Result As Fractional
        Result.Numerator = Base.Numerator * Relative.Denominator + Relative.Numerator * Base.Denominator
        Result.Denominator = Base.Denominator * Relative.Denominator
        Return Result
    End Function

    Public Function FastSubtract(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim Result As Fractional
        Result.Numerator = Base.Numerator * Relative.Denominator - Relative.Numerator * Base.Denominator
        Result.Denominator = Base.Denominator * Relative.Denominator
        Return Result
    End Function

    Public Function FastMultiply(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim Result As Fractional
        Result.Numerator = Base.Numerator * Relative.Numerator
        Result.Denominator = Base.Denominator * Relative.Denominator
        Return Result
    End Function

    Public Function FastDivide(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim Result As Fractional
        Result.Numerator = Base.Numerator * Relative.Denominator
        Result.Denominator = Base.Denominator * Relative.Numerator
        Return Result
    End Function

    Public Function ReducingAdd(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim Result As Fractional
        Result.Denominator = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Result.Numerator = Base.Numerator * (Result.Denominator / Base.Denominator)
        Result.Numerator += Relative.Numerator * (Result.Denominator / Relative.Denominator)
        Return Reduce(Result)
    End Function

    Public Function ReducingSubtract(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim Result As Fractional
        Result.Denominator = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Result.Numerator = Base.Numerator * (Result.Denominator / Base.Denominator)
        Result.Numerator -= Relative.Numerator * (Result.Denominator / Relative.Denominator)
        Return Reduce(Result)
    End Function

    Public Function ReducingMultiply(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim BNRDDivisor, BDRNDivisor As UInteger
        Dim Result As Fractional
        If Base.Numerator > 0 Then
            BNRDDivisor = GreatestCommonDivisor(Base.Numerator, Relative.Denominator)
        Else
            BNRDDivisor = 1
        End If
        If Relative.Numerator > 0 Then
            BDRNDivisor = GreatestCommonDivisor(Base.Denominator, Relative.Numerator)
        Else
            BDRNDivisor = 1
        End If
        Result.Numerator = (Base.Numerator / BNRDDivisor) * (Relative.Numerator / BDRNDivisor)
        Result.Denominator = (Base.Denominator / BDRNDivisor) * (Relative.Denominator / BNRDDivisor)
        Return Result
    End Function

    Public Function ReducingDivide(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim BNRNDivisor, BDRDDivisor As UInteger
        Dim Result As Fractional
        BNRNDivisor = GreatestCommonDivisor(Base.Numerator, Relative.Numerator)
        BDRDDivisor = GreatestCommonDivisor(Base.Denominator, Relative.Denominator)
        Result.Numerator = (Base.Numerator / BNRNDivisor) * (Relative.Denominator / BDRDDivisor)
        Result.Denominator = (Base.Denominator / BDRDDivisor) * (Relative.Numerator / BNRNDivisor)
        Return Result
    End Function

    Public Function FastLesser(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Return Base.Numerator * Relative.Denominator < Relative.Numerator * Base.Denominator
    End Function

    Public Function FastGreater(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Return Base.Numerator * Relative.Denominator > Relative.Numerator * Base.Denominator
    End Function

    Public Function FastEqual(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Return Base.Numerator * Relative.Denominator = Relative.Numerator * Base.Denominator
    End Function

    Public Function FastNotGreater(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Return Base.Numerator * Relative.Denominator <= Relative.Numerator * Base.Denominator
    End Function

    Public Function FastNotLesser(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Return Base.Numerator * Relative.Denominator >= Relative.Numerator * Base.Denominator
    End Function

    Public Function FastNotEqual(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Return Base.Numerator * Relative.Denominator <> Relative.Numerator * Base.Denominator
    End Function

    Public Function ReducingLesser(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Dim Factor As UInteger = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Return Base.Numerator * (Factor / Base.Denominator) < Relative.Numerator * (Factor / Relative.Denominator)
    End Function

    Public Function ReducingGreater(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Dim Factor As UInteger = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Return Base.Numerator * (Factor / Base.Denominator) > Relative.Numerator * (Factor / Relative.Denominator)
    End Function

    Public Function ReducingEqual(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Dim Factor As UInteger = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Return Base.Numerator * (Factor / Base.Denominator) = Relative.Numerator * (Factor / Relative.Denominator)
    End Function

    Public Function ReducingNotGreater(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Dim Factor As UInteger = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Return Base.Numerator * (Factor / Base.Denominator) <= Relative.Numerator * (Factor / Relative.Denominator)
    End Function

    Public Function ReducingNotLesser(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Dim Factor As UInteger = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Return Base.Numerator * (Factor / Base.Denominator) >= Relative.Numerator * (Factor / Relative.Denominator)
    End Function

    Public Function ReducingNotEqual(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean
        Dim Factor As UInteger = LeastCommonMultiple(Base.Denominator, Relative.Denominator)
        Return Base.Numerator * (Factor / Base.Denominator) <> Relative.Numerator * (Factor / Relative.Denominator)
    End Function

    Public ReadOnly FastArithmetic As New Arithmetical(AddressOf FastAdd, AddressOf FastSubtract, AddressOf FastMultiply, AddressOf FastDivide)

    Public ReadOnly ReducingArithmetic As New Arithmetical(AddressOf ReducingAdd, AddressOf ReducingSubtract, AddressOf ReducingMultiply, AddressOf ReducingDivide)

    Public ReadOnly FastRelation As New Relational(AddressOf FastLesser, AddressOf FastGreater, AddressOf FastEqual, AddressOf FastNotGreater, AddressOf FastNotLesser, AddressOf FastNotEqual)

    Public ReadOnly ReducingRelation As New Relational(AddressOf ReducingLesser, AddressOf ReducingGreater, AddressOf ReducingEqual, AddressOf ReducingNotGreater, AddressOf ReducingNotLesser, AddressOf ReducingNotEqual)

    Public ReadOnly FastOperation As New Operational(FastArithmetic, FastRelation)

    Public ReadOnly ReducingOperation As New Operational(ReducingArithmetic, ReducingRelation)

End Module
