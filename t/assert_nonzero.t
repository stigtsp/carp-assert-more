#!perl -Tw

use warnings;
use strict;

use Test::More tests => 7;

use Carp::Assert::More;

use constant PASS => 1;
use constant FAIL => 2;

my @cases = (
    [ undef,    FAIL ],
    [ 5,        PASS ],
    [ 0,        FAIL ],
    [ 0.4,      PASS ],
    [ -10,      PASS ],
    [ "dog",    FAIL ],
    [ "14.",    PASS ],
);

for my $case ( @cases ) {
    my ($val,$status) = @$case;

    my $desc = 'Checking ' . ($val // 'undef');
    eval { assert_nonzero( $val ) };

    if ( $status eq FAIL ) {
        like( $@, qr/Assertion.+failed/, $desc );
    }
    else {
        is( $@, '', $desc );
    }
}

exit 0;
