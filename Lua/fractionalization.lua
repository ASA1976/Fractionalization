-- © 2019 Aaron Sami Abassi
-- Licensed under the Academic Free License version 3.0
local function greatest_common_divisor(a, b)
    -- Euclidean Algorithm
    local dividend, divisor, remainder
    if a > b then
        dividend = a
        divisor = b
    else
        dividend = a
        divisor = b
    end
    remainder = dividend % divisor
    while remainder > 0 do
        dividend = divisor
        divisor = remainder
        remainder = dividend % divisor
    end
    return divisor
end
local function least_common_multiple(a, b)
    local divisor = greatest_common_divisor(a, b)
    if a > b then 
        return a / divisor * b
    end
    return b / divisor * a
end
local function reduce(fraction)
    if fraction.numerator == 0 then
        return {numerator = 0, denominator = 1}
    end
    local divisor = greatest_common_divisor(fraction.numerator, fraction.denominator)
    return {
        numerator = fraction.numerator / divisor, 
        denominator = fraction.denominator / divisor
    }
end
local function fast_add(base, relative)
    return {
        numerator = base.numerator * relative.denominator + relative.numerator * base.denominator,
        denominator = base.denominator * relative.denominator
    }
end
local function fast_subtract(base, relative)
    return {
        numerator = base.numerator * relative.denominator - relative.numerator * base.denominator,
        denominator = base.denominator * relative.denominator
    }
end
local function fast_multiply(base, relative)
    return {
        numerator = base.numerator * relative.numerator,
        denominator = base.denominator * relative.denominator
    }
end
local function fast_divide(base, relative)
    return {
        numerator = base.numerator * relative.denominator,
        denominator = base.denominator * relative.numerator
    }
end
local function reducing_add(base, relative)
    local multiple = least_common_multiple(base.denominator, relative.denominator)
    local result = {}
    result.numerator = base.numerator * (multiple / base.denominator) + relative.numerator * (multiple / relative.denominator)
    result.denominator = multiple
    return reduce(result)
end
local function reducing_subtract(base, relative)
    local multiple = least_common_multiple(base.denominator, relative.denominator)
    local result = {}
    result.numerator = base.numerator * (multiple / base.denominator) - relative.numerator * (multiple / relative.denominator)
    result.denominator = multiple
    return reduce(result)
end
local function reducing_multiply(base, relative)
    local bnrd_divisor, bdrn_divisor, result
    if base.numerator > 0 then
        bnrd_divisor = greatest_common_divisor(base.numerator, relative.denominator)
    else
        bnrd_divisor = 1
    end
    if relative.numerator > 0 then
        bdrn_divisor = greatest_common_divisor(base.denominator, relative.numerator)
    else
        bdrn_divisor = 1
    end
    return {
        numerator = (base.numerator / bnrd_divisor) * (relative.numerator / bdrn_divisor),
        denominator = (base.denominator / bdrn_divisor) * (relative.denominator / bnrd_divisor)
    }
end
local function reducing_divide(base, relative)
    local bnrn_divisor = greatest_common_divisor(base.numerator, relative.numerator)
    local bdrd_divisor = greatest_common_divisor(base.denominator, relative.denominator)
    return {
        numerator = (base.numerator / bnrn_divisor) * (relative.denominator / bdrd_divisor),
        denominator = (base.denominator / bdrd_divisor) * (relative.numerator / bnrn_divisor)
    }
end
local function fast_lesser(base, relative)
    return base.numerator * relative.denominator < relative.numerator * base.denominator
end
local function fast_greater(base, relative)
    return base.numerator * relative.denominator > relative.numerator * base.denominator
end
local function fast_equal(base, relative)
    return base.numerator * relative.denominator == relative.numerator * base.denominator
end
local function fast_not_greater(base, relative)
    return base.numerator * relative.denominator <= relative.numerator * base.denominator
end
local function fast_not_lesser(base, relative)
    return base.numerator * relative.denominator >= relative.numerator * base.denominator
end
local function fast_not_equal(base, relative)
    return base.numerator * relative.denominator ~= relative.numerator * base.denominator
end
local function reducing_lesser(base, relative)
    local factor = least_common_multiple(base.denominator, relative.denominator)
    return base.numerator * (factor / base.denominator) < relative.numerator * (factor / relative.denominator)
end
local function reducing_greater(base, relative)
    local factor = least_common_multiple(base.denominator, relative.denominator)
    return base.numerator * (factor / base.denominator) > relative.numerator * (factor / relative.denominator)
end
local function reducing_equal(base, relative)
    local factor = least_common_multiple(base.denominator, relative.denominator)
    return base.numerator * (factor / base.denominator) == relative.numerator * (factor / relative.denominator)
end
local function reducing_not_greater(base, relative)
    local factor = least_common_multiple(base.denominator, relative.denominator)
    return base.numerator * (factor / base.denominator) <= relative.numerator * (factor / relative.denominator)
end
local function reducing_not_lesser(base, relative)
    local factor = least_common_multiple(base.denominator, relative.denominator)
    return base.numerator * (factor / base.denominator) >= relative.numerator * (factor / relative.denominator)
end
local function reducing_not_equal(base, relative)
    local factor = least_common_multiple(base.denominator, relative.denominator)
    return base.numerator * (factor / base.denominator) ~= relative.numerator * (factor / relative.denominator)
end
local fast_arithmetic = {
    add = fast_add,
    subtract = fast_subtract,
    multiply = fast_multiply,
    divide = fast_divide
}
local reducing_arithmetic = {
    add = reducing_add,
    subtract = reducing_subtract,
    multiply = reducing_multiply,
    divide = reducing_divide
}
local fast_relation = {
    lesser = fast_lesser,
    greater = fast_greater,
    equal = fast_equal,
    not_greater = fast_not_greater,
    not_lesser = fast_not_lesser,
    not_equal = fast_not_equal
}
local reducing_relation = {
    lesser = reducing_lesser,
    greater = reducing_greater,
    equal = reducing_equal,
    not_greater = reducing_not_greater,
    not_lesser = reducing_not_lesser,
    not_equal = reducing_not_equal
}
local fast_operation = {
    arithmetic = fast_arithmetic,
    relation = fast_relation
}
local reducing_operation = {
    arithmetic = reducing_arithmetic,
    relation = reducing_relation
}
return {
    greatest_common_divisor = greatest_common_divisor,
    least_common_multiple = least_common_multiple,
    fast_add = fast_add,
    fast_subtract = fast_subtract,
    fast_multiply = fast_multiply,
    fast_divide = fast_divide,
    reducing_add = reducing_add,
    reducing_subtract = reducing_subtract,
    reducing_multiply = reducing_multiply,
    reducing_divide = reducing_divide,
    fast_lesser = fast_lesser,
    fast_greater = fast_greater,
    fast_equal = fast_equal,
    fast_not_greater = fast_not_greater,
    fast_not_lesser = fast_not_lesser,
    fast_not_equal = fast_not_equal,
    reducing_lesser = reducing_lesser,
    reducing_greater = reducing_greater,
    reducing_equal = reducing_equal,
    reducing_not_greater = reducing_not_greater,
    reducing_not_lesser = reducing_not_lesser,
    reducing_not_equal = reducing_not_equal,
    fast_arithmetic = fast_arithmetic,
    reducing_arithmetic = reducing_arithmetic,
    fast_relation = fast_relation,
    reducing_relation = reducing_relation,
    fast_operation = fast_operation,
    reducing_operation = reducing_operation
}

