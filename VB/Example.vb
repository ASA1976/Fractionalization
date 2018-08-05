' © 2018 Aaron Sami Abassi
' Licensed under the Academic Free License version 3.0
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
