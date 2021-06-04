#!perl -Tw

use warnings;
use strict;

use Test::More tests => 8;

use Carp::Assert::More;

use constant PASS => 1;
use constant FAIL => 2;

my @cases = (
    [ undef,    FAIL ],
    [ 5,        FAIL ],
    [ 0,        FAIL ],
    [ 0.4,      FAIL ],
    [ -10,      PASS ],
    [ -97.9,    FAIL ],
    [ "dog",    FAIL ],
    [ "14.",    FAIL ],
);

for my $case ( @cases ) {
    my ($val,$status) = @$case;

    my $desc = 'Checking ' . ($val // 'undef');
    eval { assert_negative_integer( $val ) };

    if ( $status eq FAIL ) {
        like( $@, qr/Assertion.+failed/, $desc );
    }
    else {
        is( $@, '', $desc );
    }
}

exit 0;
