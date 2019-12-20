# Relational Association Programming

This source code repository contains an example of software which conforms to
the definition of the [Relational Association Paradigm](http://github.com/ASA1976/RAP).
Each of the ten programmatic elements described in the paradigm definition are 
demonstrated, where classification is also a form of situation and 
objectification is also a form of location.

---

## Fractionalization

This association contains definitions of a fractional type as well as basic 
arithmetic and relational comparison function abstracts and objective 
classifiers.  In most languages a situable representation of a natural integer
is selected (often the default unsigned integer type), however in languages
which support generic programming all the listed programmatic elements are
expressed strictly in terms of natural integer types for both numerator and 
denominator representation.

### Fractional

This conformity represents a natural fraction type.

### ArithmeticalAbstract

This abstract represents a fractional arithmetic function type. 

### RelationalAbstact

This abstract represents a fractional relation comparator function type.

### Arithmetical

This classifier represents a fractional arithmetic function table type.

### Relational

This classifier represents a fractional relation comparator function table type.
*Note that this type does not demonstrate relations between associations (as in 
the paradigm term relation) but strictly relational comparison functions*.

### Operational

This classifer represents a fractional operation function table type.

### Zero

This informity must at least represent the normalized zero fraction (0/1).

### GreatestCommonDivisor

This function calculates the greatest common divisor between two natural 
integer values.  Some languages do not require this function.

### LeastCommonMultiple

This function calculates the least common multiple between two natural integer
values.  Some languages do not require this function.

### Reduce

This function reduces (or normalizes) a given fraction and returns it. 

### FastAdd

This function adds two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastSubtract

This function subtracts two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastMultiply

This function multiplies two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastDivide

This function divides two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### ReducingAdd

This function adds two fractions and returns a reduced fractional result.

### ReducingSubtract

This function subtracts two fractions and returns a reduced fractional result.

### ReducingMultiply

This function multiplies two fractions and returns a reduced fractional result.

### ReducingDivide

This function divides two fractions and returns a reduced fractional result.

### FastLesser

This function compares two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastGreater

This function compares two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastEqual

This function compares two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastNotGreater

This function compares two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastNotLesser

This function compares two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### FastNotEqual

This function compares two fractions without considering common denominators.
Use of this function may readily overflow numerator or denominator integers.

### ReducingLesser

This function compares two fractions using inline fractional reduction.

### ReducingGreater

This function compares two fractions using inline fractional reduction.

### ReducingEqual

This function compares two fractions using inline fractional reduction.

### ReducingNotGreater

This function compares two fractions using inline fractional reduction.

### ReducingNotLesser

This function compares two fractions using inline fractional reduction.

### ReducingNotEqual

This function compares two fractions using inline fractional reduction.

### FastArithmetic

This objective contains the locations of the fast arithmetical functions.
In some languages this is implemented as a function which returns the objective.

### ReducingArithmetic

This objective contains the locations of the reducing arithmetical functions.
In some languages this is implemented as a function which returns the objective.

### FastRelation

This objective contains the locations of the fast relational functions.
In some languages this is implemented as a function which returns the objective.

### ReducingRelation

This objective contains the locations of the reducing relational functions.
In some languages this is implemented as a function which returns the objective.

### FastOperation

This objective contains the locations of the fast operational functions.
In some languages this is implemented as a function which returns the objective.

### ReducingOperation

This objective contains the locations of the reducing operational functions.
In some languages this is implemented as a function which returns the objective.

---

## Example

This second association makes use of elements defined in the Fractionalization
association (as above).  Each element from the Fractionalization association 
which is made accessible to the Example association represents one **relation** 
as defined by the paradigm.  *Note that this association is formally called 
'main' in at least one programming language*.

### DisplayFraction

This function displays a fraction to the console.

### DisplayArithmetic

This function displays a fractional arithmetic equation to the console.

### DisplayRelation

This function displays a fractional relation comparison to the console.

### DisplayOperations

This function displays all of the fractional operations between two fractions.

### Main

This function defines two fractions, displays fast fractional operations between 
the two fractions and then displays reducing fractional operations between the 
two fractions.

