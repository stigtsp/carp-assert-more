# Carp::Assert::More

* dev branch: [![Build Status](https://github.com/petdance/carp-assert-more/workflows/testsuite/badge.svg?branch=dev)

# NAME

Carp::Assert::More - convenience wrappers around Carp::Assert

# VERSION

Version 1.20

# SYNOPSIS

A set of convenience functions for common assertions.

    use Carp::Assert::More;

    my $obj = My::Object;
    assert_isa( $obj, 'My::Object', 'Got back a correct object' );

# DESCRIPTION

Carp::Assert::More is a set of wrappers around the [Carp::Assert](https://metacpan.org/pod/Carp::Assert) functions
to make the habit of writing assertions even easier.

Everything in here is effectively syntactic sugar.  There's no technical
reason to use

    assert_isa( $foo, 'HTML::Lint' );

instead of

    assert( defined $foo );
    assert( ref($foo) eq 'HTML::Lint' );

other than readability and simplicity of the code.

My intent here is to make common assertions easy so that we as programmers
have no excuse to not use them.

# CAVEATS

I haven't specifically done anything to make Carp::Assert::More be
backwards compatible with anything besides Perl 5.6.1, much less back
to 5.004.  Perhaps someone with better testing resources in that area
can help me out here.

# SIMPLE ASSERTIONS

## assert\_is( $string, $match \[,$name\] )

Asserts that _$string_ matches _$match_.

## assert\_isnt( $string, $unmatch \[,$name\] )

Asserts that _$string_ does NOT match _$unmatch_.

## assert\_like( $string, qr/regex/ \[,$name\] )

Asserts that _$string_ matches _qr/regex/_.

The assertion fails either the string or the regex are undef.

## assert\_unlike( $string, qr/regex/ \[,$name\] )

Asserts that _$string_ matches _qr/regex/_.

The assertion fails if the regex is undef.

## assert\_defined( $this \[, $name\] )

Asserts that _$this_ is defined.

## assert\_undefined( $this \[, $name\] )

Asserts that _$this_ is not defined.

## assert\_nonblank( $this \[, $name\] )

Asserts that _$this_ is not blank and not a reference.

# NUMERIC ASSERTIONS

## assert\_numeric( $n \[, $name\] )

Asserts that `$n` looks like a number, according to `Scalar::Util::looks_like_number`.

## assert\_integer( $this \[, $name \] )

Asserts that _$this_ is an integer, which may be zero or negative.

    assert_integer( 0 );      # pass
    assert_integer( 14 );     # pass
    assert_integer( -14 );    # pass
    assert_integer( '14.' );  # FAIL

## assert\_nonzero( $this \[, $name \] )

Asserts that the numeric value of _$this_ is not zero.

    assert_nonzero( 0 );    # FAIL
    assert_nonzero( -14 );  # pass
    assert_nonzero( '14.' );  # pass

Asserts that the numeric value of _$this_ is not zero.

## assert\_positive( $this \[, $name \] )

Asserts that the numeric value of _$this_ is greater than zero.

    assert_positive( 0 );    # FAIL
    assert_positive( -14 );  # FAIL
    assert_positive( '14.' );  # pass

## assert\_nonnegative( $this \[, $name \] )

Asserts that the numeric value of _$this_ is greater than or equal
to zero.  Since non-numeric strings evaluate to zero, this means that
any non-numeric string will pass.

    assert_nonnegative( 0 );      # pass
    assert_nonnegative( -14 );    # FAIL
    assert_nonnegative( '14.' );  # pass
    assert_nonnegative( 'dog' );  # pass

## assert\_negative( $this \[, $name \] )

Asserts that the numeric value of _$this_ is less than zero.

    assert_negative( 0 );       # FAIL
    assert_negative( -14 );     # pass
    assert_negative( '14.' );   # FAIL

## assert\_nonzero\_integer( $this \[, $name \] )

Asserts that the numeric value of _$this_ is not zero, and that _$this_
is an integer.

    assert_nonzero_integer( 0 );      # FAIL
    assert_nonzero_integer( -14 );    # pass
    assert_nonzero_integer( '14.' );  # FAIL

## assert\_positive\_integer( $this \[, $name \] )

Asserts that the numeric value of _$this_ is greater than zero, and
that _$this_ is an integer.

    assert_positive_integer( 0 );     # FAIL
    assert_positive_integer( -14 );   # FAIL
    assert_positive_integer( '14.' ); # FAIL
    assert_positive_integer( '14' );  # pass

## assert\_nonnegative\_integer( $this \[, $name \] )

Asserts that the numeric value of _$this_ is not less than zero, and
that _$this_ is an integer.

    assert_nonnegative_integer( 0 );      # pass
    assert_nonnegative_integer( -14 );    # pass
    assert_nonnegative_integer( '14.' );  # FAIL

## assert\_negative\_integer( $this \[, $name \] )

Asserts that the numeric value of _$this_ is less than zero, and that
_$this_ is an integer.

    assert_negative_integer( 0 );      # FAIL
    assert_negative_integer( -14 );    # pass
    assert_negative_integer( '14.' );  # FAIL

# REFERENCE ASSERTIONS

## assert\_isa( $this, $type \[, $name \] )

Asserts that _$this_ is an object of type _$type_.

## assert\_isa\_in( $obj, \\@types \[, $description\] )

Assert that the blessed `$obj` isa one of the types in `\@types`.

    assert_isa_in( $obj, [ 'My::Foo', 'My::Bar' ], 'Must pass either a Foo or Bar object' );

## assert\_empty( $this \[, $name \] )

_$this_ must be a ref to either a hash or an array.  Asserts that that
collection contains no elements.  Will assert (with its own message,
not _$name_) unless given a hash or array ref.   It is OK if _$this_ has
been blessed into objecthood, but the semantics of checking an object to see
if it does not have keys (for a hashref) or returns 0 in scalar context (for
an array ref) may not be what you want.

    assert_empty( 0 );       # FAIL
    assert_empty( 'foo' );   # FAIL
    assert_empty( undef );   # FAIL
    assert_empty( {} );      # pass
    assert_empty( [] );      # pass
    assert_empty( {foo=>1} );# FAIL
    assert_empty( [1,2,3] ); # FAIL

## assert\_nonempty( $this \[, $name \] )

_$this_ must be a ref to either a hash or an array.  Asserts that that
collection contains at least 1 element.  Will assert (with its own message,
not _$name_) unless given a hash or array ref.   It is OK if _$this_ has
been blessed into objecthood, but the semantics of checking an object to see
if it has keys (for a hashref) or returns >0 in scalar context (for an array
ref) may not be what you want.

    assert_nonempty( 0 );       # FAIL
    assert_nonempty( 'foo' );   # FAIL
    assert_nonempty( undef );   # FAIL
    assert_nonempty( {} );      # FAIL
    assert_nonempty( [] );      # FAIL
    assert_nonempty( {foo=>1} );# pass
    assert_nonempty( [1,2,3] ); # pass

## assert\_nonref( $this \[, $name \] )

Asserts that _$this_ is not undef and not a reference.

## assert\_hashref( $ref \[,$name\] )

Asserts that _$ref_ is defined, and is a reference to a (possibly empty) hash.

**NB:** This method returns _false_ for objects, even those whose underlying
data is a hashref. This is as it should be, under the assumptions that:

- (a)

    you shouldn't rely on the underlying data structure of a particular class, and

- (b)

    you should use `assert_isa` instead.

## assert\_arrayref( $ref \[, $name\] )

## assert\_listref( $ref \[,$name\] )

Asserts that _$ref_ is defined, and is a reference to a (possibly empty) list.

**NB:** The same caveat about objects whose underlying structure is a
hash (see `assert_hashref`) applies here; this method returns false
even for objects whose underlying structure is an array.

`assert_listref` is an alias for `assert_arrayref` and may go away in
the future.  Use `assert_arrayref` instead.

## assert\_aoh( $ref \[, $name \] )

Verifies that `$array` is an arrayref, and that every element is a hashref.

The array `$array` can be an empty arraref and the assertion will pass.

## assert\_coderef( $ref \[,$name\] )

Asserts that _$ref_ is defined, and is a reference to a closure.

# TYPE-SPECIFIC ASSERTIONS

## assert\_datetime( $date )

Asserts that `$date` is a DateTime object.

# SET AND HASH MEMBERSHIP

## assert\_in( $string, \\@inlist \[,$name\] );

Asserts that _$string_ is defined and matches one of the elements
of _\\@inlist_.

_\\@inlist_ must be an array reference of defined strings.

## assert\_exists( \\%hash, $key \[,$name\] )

## assert\_exists( \\%hash, \\@keylist \[,$name\] )

Asserts that _%hash_ is indeed a hash, and that _$key_ exists in
_%hash_, or that all of the keys in _@keylist_ exist in _%hash_.

    assert_exists( \%custinfo, 'name', 'Customer has a name field' );

    assert_exists( \%custinfo, [qw( name addr phone )],
                            'Customer has name, address and phone' );

## assert\_lacks( \\%hash, $key \[,$name\] )

## assert\_lacks( \\%hash, \\@keylist \[,$name\] )

Asserts that _%hash_ is indeed a hash, and that _$key_ does NOT exist
in _%hash_, or that none of the keys in _@keylist_ exist in _%hash_.

    assert_lacks( \%users, 'root', 'Root is not in the user table' );

    assert_lacks( \%users, [qw( root admin nobody )], 'No bad usernames found' );

## assert\_all\_keys\_in( \\%hash, \\@names \[, $name \] )

Asserts that each key in `%hash` is in the list of `@names`.

This is used to ensure that there are no extra keys in a given hash.

    assert_all_keys_in( $obj, [qw( height width depth )], '$obj can only contain height, width and depth keys' );

# UTILITY ASSERTIONS

## assert\_fail( \[$name\] )

Assertion that always fails.  `assert_fail($msg)` is exactly the same
as calling `assert(0,$msg)`, but it eliminates that case where you
accidentally use `assert($msg)`, which of course never fires.

# COPYRIGHT & LICENSE

Copyright 2005-2019 Andy Lester.

This program is free software; you can redistribute it and/or modify
it under the terms of the Artistic License version 2.0.

# ACKNOWLEDGEMENTS

Thanks to
Eric A. Zarko,
Bob Diss,
Pete Krawczyk,
David Storrs,
Dan Friedman,
Allard Hoeve,
Thomas L. Shinnick,
and Leland Johnson
for code and fixes.
