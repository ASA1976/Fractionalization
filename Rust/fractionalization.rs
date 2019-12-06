// © 2019 Aaron Sami Abassi
// Licensed under the Academic Free License version 3.0
mod fractionalization {
    use num::Num;
    use num::Integer;
    pub type Fractional<Natural> = (Natural, Natural);
    pub type ArithmeticalAbstract<Natural> = fn(Fractional<Natural>, Fractional<Natural>) -> Fractional<Natural>;
    pub type RelationalAbstract<Natural> = fn(Fractional<Natural>, Fractional<Natural>) -> bool;
    pub struct Arithmetical<Natural> {
        pub add: ArithmeticalAbstract<Natural>,
        pub subtract: ArithmeticalAbstract<Natural>,
        pub multiply: ArithmeticalAbstract<Natural>,
        pub divide: ArithmeticalAbstract<Natural>
    }
    pub struct Relational<Natural> {
        pub lesser: RelationalAbstract<Natural>,
        pub greater: RelationalAbstract<Natural>,
        pub equal: RelationalAbstract<Natural>,
        pub not_greater: RelationalAbstract<Natural>,
        pub not_lesser: RelationalAbstract<Natural>,
        pub not_equal: RelationalAbstract<Natural>
    }
    pub struct Operational<Natural> {
        pub arithmetic: Arithmetical<Natural>,
        pub relation: Relational<Natural>
    }
    pub fn reduce<Natural>(fraction: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Num + Integer + Copy {
        if fraction.0 == Natural::zero() {
            return (Natural::zero(), Natural::one());
        } else {
            let divisor = fraction.0.gcd(&fraction.1);
            return (fraction.0 / divisor, fraction.1 / divisor);
        }
    }
    pub fn fast_add<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        return (base.0 * relative.1 + relative.0 * base.1, base.1 * relative.1);
    }
    pub fn fast_subtract<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        return (base.0 * relative.1 - relative.0 * base.1, base.1 * relative.1);
    }
    pub fn fast_multiply<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        return (base.0 * relative.0, base.1 * relative.1);
    }
    pub fn fast_divide<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        return (base.0 * relative.1, base.1 * relative.0);
    }
    pub fn reducing_add<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        let multiple = base.1.lcm(&relative.1);
        return reduce((base.0 * (multiple / base.1) + relative.0 * (multiple / relative.1), multiple));
    }
    pub fn reducing_subtract<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        let multiple = base.1.lcm(&relative.1);
        return reduce((base.0 * (multiple / base.1) - relative.0 * (multiple / relative.1), multiple));
    }
    pub fn reducing_multiply<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        let bnrd_divisor: Natural;
        let bdrn_divisor: Natural;
        if base.0 > Natural::zero() {
            bnrd_divisor = base.0.gcd(&relative.1);
        } else {
            bnrd_divisor = Natural::one();
        }
        if relative.0 > Natural::zero() {
            bdrn_divisor = base.1.gcd(&relative.0);
        } else {
            bdrn_divisor = Natural::one();
        }
        return ((base.0 / bnrd_divisor) * (relative.0 / bdrn_divisor), (base.1 / bdrn_divisor) * (relative.1 / bnrd_divisor));
    }
    pub fn reducing_divide<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> Fractional<Natural> 
    where Natural: Integer + Copy {
        let bnrn_divisor = base.0.gcd(&relative.0);
        let bdrd_divisor = base.1.gcd(&relative.1);
        return ((base.0 / bnrn_divisor) * (relative.1 / bdrd_divisor), (base.1 / bdrd_divisor) * (relative.0 / bnrn_divisor));
    }
    pub fn fast_lesser<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer {
        return base.0 * relative.1 < relative.0 * base.1;
    }
    pub fn fast_greater<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer {
        return base.0 * relative.1 > relative.0 * base.1;
    }
    pub fn fast_equal<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer {
        return base.0 * relative.1 == relative.0 * base.1;
    }
    pub fn fast_not_greater<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer {
        return base.0 * relative.1 <= relative.0 * base.1;
    }
    pub fn fast_not_lesser<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer {
        return base.0 * relative.1 >= relative.0 * base.1;
    }
    pub fn fast_not_equal<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer {
        return base.0 * relative.1 != relative.0 * base.1;
    }
    pub fn reducing_lesser<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer + Copy {
        let factor = base.1.lcm(&relative.1);
        return base.0 * (factor / base.1) < relative.0 * (factor / relative.1);
    }
    pub fn reducing_greater<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer + Copy {
        let factor = base.1.lcm(&relative.1);
        return base.0 * (factor / base.1) > relative.0 * (factor / relative.1);
    }
    pub fn reducing_equal<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer + Copy {
        let factor = base.1.lcm(&relative.1);
        return base.0 * (factor / base.1) == relative.0 * (factor / relative.1);
    }
    pub fn reducing_not_greater<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer + Copy {
        let factor = base.1.lcm(&relative.1);
        return base.0 * (factor / base.1) <= relative.0 * (factor / relative.1);
    }
    pub fn reducing_not_lesser<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer + Copy {
        let factor = base.1.lcm(&relative.1);
        return base.0 * (factor / base.1) >= relative.0 * (factor / relative.1);
    }
    pub fn reducing_not_equal<Natural>(base: Fractional<Natural>, relative: Fractional<Natural>) -> bool 
    where Natural: Integer + Copy {
        let factor = base.1.lcm(&relative.1);
        return base.0 * (factor / base.1) != relative.0 * (factor / relative.1);
    }
    pub fn fast_arithmetic<Natural>() -> Arithmetical<Natural> 
    where Natural: Integer + Copy {
        let arithmetic = Arithmetical::<Natural> {
            add: fast_add::<Natural>,
            subtract: fast_subtract::<Natural>,
            multiply: fast_multiply::<Natural>,
            divide: fast_divide::<Natural>
        };
        return arithmetic;
    }
    pub fn reducing_arithmetic<Natural>() -> Arithmetical<Natural> 
    where Natural: Integer + Copy {
        let arithmetic = Arithmetical::<Natural> {
            add: reducing_add::<Natural>,
            subtract: reducing_subtract::<Natural>,
            multiply: reducing_multiply::<Natural>,
            divide: reducing_divide::<Natural>
        };
        return arithmetic;
    }
    pub fn fast_relation<Natural>() -> Relational<Natural> 
    where Natural: Integer {
        let relation = Relational::<Natural> {
            lesser: fast_lesser::<Natural>,
            greater: fast_greater::<Natural>,
            equal: fast_equal::<Natural>,
            not_greater: fast_not_greater::<Natural>,
            not_lesser: fast_not_lesser::<Natural>,
            not_equal: fast_not_equal::<Natural>
        };
        return relation;
    }
    pub fn reducing_relation<Natural>() -> Relational<Natural> 
    where Natural: Integer + Copy {
        let relation = Relational::<Natural> {
            lesser: reducing_lesser::<Natural>,
            greater: reducing_greater::<Natural>,
            equal: reducing_equal::<Natural>,
            not_greater: reducing_not_greater::<Natural>,
            not_lesser: reducing_not_lesser::<Natural>,
            not_equal: reducing_not_equal::<Natural>
        };
        return relation;
    }
    pub fn fast_operation<Natural>() -> Operational<Natural> 
    where Natural: Integer + Copy {
        let operation = Operational::<Natural> {
            arithmetic: fast_arithmetic::<Natural>(),
            relation: fast_relation::<Natural>()
        };
        return operation;
    }
    pub fn reducing_operation<Natural>() -> Operational<Natural> 
    where Natural: Integer + Copy {
        let operation = Operational::<Natural> {
            arithmetic: reducing_arithmetic::<Natural>(),
            relation: reducing_relation::<Natural>()
        };
        return operation;
    }
}
