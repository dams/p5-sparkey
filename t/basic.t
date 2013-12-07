#!perl
use strict;
use warnings;

use Test::More tests => 1;
use Sparkey::LogWriter;

is( Sparkey::LogWriter::new("plop.spl"), '0.42', 'Sparkey version is 42' );

