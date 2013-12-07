#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include "perl_sparkey.h"
#include <sparkey/sparkey.h>

/* C functions */

MODULE = Sparkey		PACKAGE = Sparkey		

PROTOTYPES: ENABLE

# XS code

const char *
new(filename)
    const char * filename

    PREINIT:
    sparkey_logwriter *l = malloc(sizeof(sparkey_logwriter * ));
    sparkey_logwriter *mywriter;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_create(&mywriter, filename, SPARKEY_COMPRESSION_NONE, 0);
    perl_sparkey_assert_error(rc);
    EXTEND(SP, 1);
    PUSHs(sv_2mortal(newSVpv("0.42", 0)));
