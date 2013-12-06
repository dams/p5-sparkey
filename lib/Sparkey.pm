use strict;
use warnings;
use Exporter;
use XSLoader;

use base 'Exporter';

our $VERSION     = '0.001';
our %EXPORT_TAGS = ( 'all' => [qw<get_version>] );
our @EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } );

XSLoader::load('Sparkey', $VERSION);

1;

