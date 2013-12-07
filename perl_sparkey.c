#include <EXTERN.h>
#include <perl.h>

#include <sparkey/sparkey.h>
#include "perl_sparkey.h"

void perl_sparkey_assert_error (sparkey_returncode code) {
    if (code == SPARKEY_SUCCESS) {
        return;
    }
    croak("Sparkey error: %s", sparkey_errstring(code));
}
