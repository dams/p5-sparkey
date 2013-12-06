#!perl
use strict;
use warnings;

use Test::More tests => 1;
use Sparkey qw(:all);

is( Sparkey::get_version(), '0.42', 'Sparkey version is 42' );

