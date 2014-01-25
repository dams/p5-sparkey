#include <EXTERN.h>
#include <perl.h>

#include <sparkey.h>
#include "perl_sparkey.h"

void perl_sparkey_assert_error (sparkey_returncode code) {
    if (code == SPARKEY_SUCCESS)
        return;
    croak("Sparkey error: %s", sparkey_errstring(code));
}

SV * perl_sparkey_compression_type_to_string (sparkey_compression_type compression_type) {
    if (compression_type == SPARKEY_COMPRESSION_NONE)
        return newSVpvs("none");
    if (compression_type == SPARKEY_COMPRESSION_SNAPPY)
        return newSVpvs("snappy");
    croak("unexpected: unknown compression type. Should be one of 'none', 'snappy'");
}

sparkey_compression_type perl_sparkey_string_to_compression_type (SV * compression_type) {
    const char * compression_type_str = (char *) SvPV_nolen(compression_type);
    if (strcasecmp(compression_type_str, "none") == 0)
        return SPARKEY_COMPRESSION_NONE;
    if (strcasecmp(compression_type_str, "snappy") == 0)
        return SPARKEY_COMPRESSION_SNAPPY;
    croak("Unknown compression type [TODO PUT COMPRESSION TYPE HERE]");
}
