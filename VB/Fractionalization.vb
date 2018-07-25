' © 2018 Aaron Sami Abassi
' Licensed under the Academic Free License version 3.0
Module Fractionalization

    Public Delegate Function ArithmeticalAbstract(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional

    Public Delegate Function RelationalAbstract(ByRef Base As Fractional, ByRef Relative As Fractional) As Boolean

    Public Structure Fractional

        Dim Numerator, Denominator As UInteger

        Sub New(ByRef Numerator As UInteger, ByRef Denominator As UInteger)
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
        Dim LNRDDivisor, LDRNDivisor As UInteger
        Dim Result As Fractional
        LNRDDivisor = GreatestCommonDivisor(Base.Numerator, Relative.Denominator)
        LDRNDivisor = GreatestCommonDivisor(Base.Denominator, Relative.Numerator)
        Result.Numerator = (Base.Numerator / LNRDDivisor) * (Relative.Numerator / LDRNDivisor)
        Result.Denominator = (Base.Denominator / LDRNDivisor) * (Relative.Denominator / LNRDDivisor)
        Return Result
    End Function

    Public Function ReducingDivide(ByRef Base As Fractional, ByRef Relative As Fractional) As Fractional
        Dim LNRNDivisor, LDRDDivisor As UInteger
        Dim Result As Fractional
        LNRNDivisor = GreatestCommonDivisor(Base.Numerator, Relative.Numerator)
        LDRDDivisor = GreatestCommonDivisor(Base.Denominator, Relative.Denominator)
        Result.Numerator = (Base.Numerator / LNRNDivisor) * (Relative.Denominator / LDRDDivisor)
        Result.Denominator = (Base.Denominator / LDRDDivisor) * (Relative.Numerator / LNRNDivisor)
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

Module Example

    Sub DisplayFraction(ByRef Fraction As Fractional)
        Console.Write(Fraction.Numerator)
        If (Fraction.Denominator <> 1) Then
            Console.Write("/" & Fraction.Denominator)
        End If
    End Sub

    Sub DisplayArithmetic(ByRef Base As Fractional, Symbol As String, ByRef Relative As Fractional, ByRef Equals As Fractional)
        DisplayFraction(Base)
        Console.Write(" " & Symbol & " ")
        DisplayFraction(Relative)
        Console.Write(" = ")
        DisplayFraction(Equals)
        Console.WriteLine()
    End Sub

    Sub DisplayRelation(ByRef Base As Fractional, Symbol As String, ByRef Relative As Fractional, ByRef Result As Boolean)
        DisplayFraction(Base)
        Console.Write(" " & Symbol & " ")
        DisplayFraction(Relative)
        Console.WriteLine(" = " & Result)
    End Sub

    Sub DisplayOperations(ByRef Operation As Operational, ByVal Base As Fractional, ByVal Relative As Fractional)
        Dim Arithmetic As Arithmetical = Operation.Arithmetic
        Dim Relation As Relational = Operation.Relation
        DisplayArithmetic(Base, "+", Relative, Arithmetic.Add(Base, Relative))
        DisplayArithmetic(Base, "-", Relative, Arithmetic.Subtract(Base, Relative))
        DisplayArithmetic(Base, "*", Relative, Arithmetic.Multiply(Base, Relative))
        DisplayArithmetic(Base, "/", Relative, Arithmetic.Divide(Base, Relative))
        DisplayRelation(Base, "<", Relative, Relation.Lesser(Base, Relative))
        DisplayRelation(Base, ">", Relative, Relation.Greater(Base, Relative))
        DisplayRelation(Base, "=", Relative, Relation.Equal(Base, Relative))
        DisplayRelation(Base, "<=", Relative, Relation.NotGreater(Base, Relative))
        DisplayRelation(Base, ">=", Relative, Relation.NotLesser(Base, Relative))
        DisplayRelation(Base, "<>", Relative, Relation.NotEqual(Base, Relative))
    End Sub

    Sub Main()
        Static X As New Fractional(1, 6)
        Static Y As New Fractional(1, 12)
        Console.WriteLine("Fast Fractional Operations")
        DisplayOperations(FastOperation, X, Y)
        Console.WriteLine()
        Console.WriteLine("Reducing Fractional Operations")
        DisplayOperations(ReducingOperation, X, Y)
    End Sub

End Module
