#!perl
use strict;
use warnings;

use Test::More;
use Test::Exception;
use Sparkey qw(:all);

is( Sparkey::new("plop.spl"), '0.42', 'Sparkey version is 42' );

throws_ok( sub { Sparkey::new("nosuchdir/plop.spl") },
           qr/Sparkey error: Internal error/, 'throws string exception' );

done_testing;
