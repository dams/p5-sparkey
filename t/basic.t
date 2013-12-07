#!perl
use strict;
use warnings;

use Test::More;
use Sparkey::LogWriter;
use Sparkey::Hash;

is( Sparkey::LogWriter::new("plop.spl"), '0.42', 'Sparkey version is 42' );
is( Sparkey::Hash->new("plop.spi","plop.spl"), '0.042', 'Hash function returns' );

done_testing;
