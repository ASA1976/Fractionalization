# © 2019 Aaron Sami Abassi
# Licensed under the Academic Free License version 3.0

package Fractionalization;
use strict;
use warnings;
sub fractional {
    my %fraction;
    $fraction{numerator} = $_[0];
    $fraction{denominator} = $_[1];
    return \%fraction;
}
sub arithmetical {
    my %arithmetic;
    $arithmetic{add} = $_[0];
    $arithmetic{subtract} = $_[1];
    $arithmetic{multiply} = $_[2];
    $arithmetic{divide} = $_[3];
    return \%arithmetic;
}
sub relational {
    my %relation;
    $relation{lesser} = $_[0];
    $relation{greater} = $_[1];
    $relation{equal} = $_[2];
    $relation{not_greater} = $_[3];
    $relation{not_lesser} = $_[4];
    $relation{not_equal} = $_[5];
    return \%relation;
}
sub operational {
    my %operation;
    $operation{arithmetic} = $_[0];
    $operation{relation} = $_[1];
    return \%operation;
}
our $zero = fractional( 0, 1 );
sub greatest_common_divisor {
    # Euclidean Algorithm
    my ($a, $b) = @_;
    my ($dividend, $divisor, $remainder);
    if ($a > $b) {
       $dividend = $a;
       $divisor = $b;
    } else {
       $dividend = $b;
       $divisor = $a;
    }
    $remainder = $dividend % $divisor;
    while ($remainder > 0) {
        $dividend = $divisor;
        $divisor = $remainder;
        $remainder = $dividend % $divisor;
    }
    return $divisor;
}
sub least_common_multiple {
    my ($a, $b) = @_;
    my $divisor = greatest_common_divisor( $a, $b );
    if ($a > $b) {
        return $a / $divisor * $b;
    }
    return $b / $divisor * $a;
}
sub reduce {
    my ($fraction) = @_;
    my ($result, $divisor);
    if ($fraction->{numerator} == 0) {
        $result = fractional( 0, 1 );
    } else {
        $divisor = greatest_common_divisor( $fraction->{numerator}, $fraction->{denominator} );
        $result = fractional( $fraction->{numerator} / $divisor, $fraction->{denominator} / $divisor ); 
    }
    return $result;
}
sub fast_add {
    my ($base, $relative) = @_;
    return fractional( 
        $base->{numerator} * $relative->{denominator} + $relative->{numerator} * $base->{denominator},
        $base->{denominator} * $relative->{denominator}
    );
}
sub fast_subtract {
    my ($base, $relative) = @_;
    return fractional( 
        $base->{numerator} * $relative->{denominator} - $relative->{numerator} * $base->{denominator},
        $base->{denominator} * $relative->{denominator}
    );
}
sub fast_multiply {
    my ($base, $relative) = @_;
    return fractional( 
        $base->{numerator} * $relative->{numerator},
        $base->{denominator} * $relative->{denominator}
    );
}
sub fast_divide {
    my ($base, $relative) = @_;
    return fractional( 
        $base->{numerator} * $relative->{denominator},
        $base->{denominator} * $relative->{numerator}
    );
}
sub reducing_add {
    my ($base, $relative) = @_;
    my %result;
    $result{denominator} = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    $result{numerator} = $base->{numerator} * ($result{denominator} / $base->{denominator});
    $result{numerator} += $relative->{numerator} * ($result{denominator} / $relative->{denominator});
    return reduce( \%result );
}
sub reducing_subtract {
    my ($base, $relative) = @_;
    my %result;
    $result{denominator} = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    $result{numerator} = $base->{numerator} * ($result{denominator} / $base->{denominator});
    $result{numerator} -= $relative->{numerator} * ($result{denominator} / $relative->{denominator});
    return reduce( \%result );
}
sub reducing_multiply {
    my ($base, $relative) = @_;
    my ($bnrd_divisor, $bdrn_divisor);
    if ($base->{numerator} > 0) {
        $bnrd_divisor = greatest_common_divisor( $base->{numerator}, $relative->{denominator} );
    } else {
        $bnrd_divisor = 1;
    }
    if ($relative->{numerator} > 0) {
        $bdrn_divisor = greatest_common_divisor( $base->{denominator}, $relative->{numerator} );
    } else {
        $bdrn_divisor = 1;
    }
    return fractional( 
        ($base->{numerator} / $bnrd_divisor) * ($relative->{numerator} / $bdrn_divisor),
        ($base->{denominator} / $bdrn_divisor) * ($relative->{denominator} / $bnrd_divisor)
    );
}
sub reducing_divide {
    my ($base, $relative) = @_;
    my ($bnrn_divisor, $bdrd_divisor);
    $bnrn_divisor = greatest_common_divisor( $base->{numerator}, $relative->{numerator} );
    $bdrd_divisor = greatest_common_divisor( $base->{denominator}, $relative->{denominator} );
    return fractional( 
        ($base->{numerator} / $bnrn_divisor) * ($relative->{denominator} / $bdrd_divisor),
        ($base->{denominator} / $bdrd_divisor) * ($relative->{numerator} / $bnrn_divisor)
    );
}
sub fast_lesser {
    my ($base, $relative) = @_;
    return $base->{numerator} * $relative->{denominator} < $relative->{numerator} * $base->{denominator};
}
sub fast_greater {
    my ($base, $relative) = @_;
    return $base->{numerator} * $relative->{denominator} > $relative->{numerator} * $base->{denominator};
}
sub fast_equal {
    my ($base, $relative) = @_;
    return $base->{numerator} * $relative->{denominator} == $relative->{numerator} * $base->{denominator};
}
sub fast_not_greater {
    my ($base, $relative) = @_;
    return $base->{numerator} * $relative->{denominator} <= $relative->{numerator} * $base->{denominator};
}
sub fast_not_lesser {
    my ($base, $relative) = @_;
    return $base->{numerator} * $relative->{denominator} >= $relative->{numerator} * $base->{denominator};
}
sub fast_not_equal {
    my ($base, $relative) = @_;
    return $base->{numerator} * $relative->{denominator} != $relative->{numerator} * $base->{denominator};
}
sub reducing_lesser {
    my ($base, $relative) = @_;
    my $factor = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    return $base->{numerator} * ($factor / $base->{denominator}) < $relative->{numerator} * ($factor / $relative->{denominator});
}
sub reducing_greater {
    my ($base, $relative) = @_;
    my $factor = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    return $base->{numerator} * ($factor / $base->{denominator}) > $relative->{numerator} * ($factor / $relative->{denominator});
}
sub reducing_equal {
    my ($base, $relative) = @_;
    my $factor = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    return $base->{numerator} * ($factor / $base->{denominator}) == $relative->{numerator} * ($factor / $relative->{denominator});
}
sub reducing_not_greater {
    my ($base, $relative) = @_;
    my $factor = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    return $base->{numerator} * ($factor / $base->{denominator}) <= $relative->{numerator} * ($factor / $relative->{denominator});
}
sub reducing_not_lesser {
    my ($base, $relative) = @_;
    my $factor = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    return $base->{numerator} * ($factor / $base->{denominator}) >= $relative->{numerator} * ($factor / $relative->{denominator});
}
sub reducing_not_equal {
    my ($base, $relative) = @_;
    my $factor = least_common_multiple( $base->{denominator}, $relative->{denominator} );
    return $base->{numerator} * ($factor / $base->{denominator}) != $relative->{numerator} * ($factor / $relative->{denominator});
}
our $fast_arithmetic = arithmetical( \&fast_add, \&fast_subtract, \&fast_multiply, \&fast_divide );
our $reducing_arithmetic = arithmetical( \&reducing_add, \&reducing_subtract, \&reducing_multiply, \&reducing_divide );
our $fast_relation = relational( \&fast_lesser, \&fast_greater, \&fast_equal, \&fast_not_greater, \&fast_not_lesser, \&fast_not_equal );
our $reducing_relation = relational( \&reducing_lesser, \&reducing_greater, \&reducing_equal, \&reducing_not_greater, \&reducing_not_lesser, \&reducing_not_equal );
our $fast_operation = operational( $fast_arithmetic, $fast_relation );
our $reducing_operation = operational( $reducing_arithmetic, $reducing_relation );
1;

