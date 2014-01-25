#!perl
use strict;
use warnings;

use Test::More;
use Test::Exception;

use Sparkey::LogWriter;
use Sparkey::Hash;

throws_ok( sub { Sparkey::LogWriter->new("nosuchdir/plop.spl") },
           qr/Sparkey error: Internal error/, 'throws string exception' );

unlink('plop.spl');

my $logwriter = Sparkey::LogWriter->new("plop.spl");
isa_ok($logwriter, 'Sparkey::LogWriter');

# is( Sparkey::Hash->new("plop.spi","plop.spl"), '0.042', 'Hash function returns' );

unlink('plop.spl');
throws_ok( sub { Sparkey::LogWriter->new("plop.spl", "yppans", 10) },
           qr/Unknown compression type/, 'throws string exception on unknown compression type' );



done_testing;
