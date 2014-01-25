package Sparkey::LogWriter;

use strict;
use warnings;

use Sparkey;

sub new {
    my ($class, $filename) = @_;
    -e $filename
      and return $class->_new_append($filename);
    return $class->_new_create($filename);
}

1;
