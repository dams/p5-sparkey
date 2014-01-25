#!perl
use strict;
use warnings;

use Test::More;
use Test::Exception;

use Sparkey::LogWriter;
use Sparkey::Hash;

throws_ok( sub { Sparkey::LogWriter->new() },
           qr/Wrong number of parameters/, 'throws string exception' );

throws_ok( sub { Sparkey::LogWriter->new("nosuchdir/plop.spl") },
           qr/Sparkey error: Internal error/, 'throws string exception' );

unlink('plop.spl');

{
    my $logwriter = Sparkey::LogWriter->new("plop.spl");
    isa_ok($logwriter, 'Sparkey::LogWriter');
    is($logwriter->log_path(), "plop.spl", "->log_path works");
#    $log_path
}

# is( Sparkey::Hash->new("plop.spi","plop.spl"), '0.042', 'Hash function returns' );


#$logwriter->put();

unlink('plop.spl');
throws_ok( sub { Sparkey::LogWriter->new("plop.spl", "yppans", 10) },
           qr/Unknown compression type/, 'throws string exception on unknown compression type' );



done_testing;
