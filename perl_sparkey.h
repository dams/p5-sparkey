#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#include <proto.h>

#include "ppport.h"

#include <sparkey.h>

void perl_sparkey_assert_error (sparkey_returncode code);
SV* perl_sparkey_compression_type_to_string (sparkey_compression_type compression_type);
sparkey_compression_type perl_sparkey_string_to_compression_type (SV* compression_type);
