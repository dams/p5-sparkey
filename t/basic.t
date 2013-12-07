#!perl
use strict;
use warnings;

use Test::More;
use Test::Exception;

use Sparkey::LogWriter;
use Sparkey::Hash;

is( Sparkey::LogWriter->new("plop.spl"), '0.42', 'Sparkey version is 42' );
is( Sparkey::Hash->new("plop.spi","plop.spl"), '0.042', 'Hash function returns' );

throws_ok( sub { Sparkey::LogWriter->new("nosuchdir/plop.spl") },
           qr/Sparkey error: Internal error/, 'throws string exception' );

done_testing;
