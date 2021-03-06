package Sparkey;


=head1 NAME

Sparkey - Perl binding for the Sparkey key-value storage database

=cut

use strict;
use warnings;

our $VERSION     = '0.001';

use Exporter;
use XSLoader;

use base 'Exporter';

# our %EXPORT_TAGS = ( 'all' => [qw<get_version>] );
# our @EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } );

XSLoader::load(__PACKAGE__, $Sparkey::VERSION);

1;

