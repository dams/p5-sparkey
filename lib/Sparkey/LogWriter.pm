package Sparkey::LogWriter;

use strict;
use warnings;

use Sparkey;
use Exporter;
use XSLoader;

use base 'Exporter';

# our %EXPORT_TAGS = ( 'all' => [qw<get_version>] );
# our @EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } );

XSLoader::load(__PACKAGE__, $Sparkey::VERSION);
