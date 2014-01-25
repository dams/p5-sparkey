package Sparkey::LogWriter;

use strict;
use warnings;

use Types::Standard qw( slurpy Str ArrayRef );
use Type::Params qw( validate compile );
use Type::Utils;

use Sparkey;

my $Invocant = class_type { class => __PACKAGE__ };

my %inside_out;

sub new {
    my ($class, $filename, $rest) = validate(\@_, Str, Str, slurpy ArrayRef);
    my $self = -e $filename
      ? $class->_new_append($filename, @$rest)
      : $class->_new_create($filename, @$rest);
    $inside_out{$self}{log_path} = $filename;
#    say STDERR Dumper(\%inside_out); use Data::Dumper;
    $self;
}

sub log_path {
    my ($self) = validate(\@_, $Invocant);
    $inside_out{$self}{log_path};
}

DESTROY {
    delete $inside_out{$_[0]};
}


1;

