#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <sparkey.h>
#include "perl_sparkey.h"

/* C functions */

MODULE = Sparkey		PACKAGE = Sparkey::LogWriter

PROTOTYPES: ENABLE

# XS code

const char *
new(class, filename, compression_type=SPARKEY_COMPRESSION_NONE, compression_block_size=0)
    const char * class
    const char * filename
    sparkey_compression_type compression_type
    int compression_block_size

    PREINIT:
    sparkey_logwriter *mywriter;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_create(&mywriter, filename, compression_type, compression_block_size);
    perl_sparkey_assert_error(rc);
    EXTEND(SP, 1);
    PUSHs(sv_2mortal(newSVpv("0.42", 0)));

MODULE = Sparkey		PACKAGE = Sparkey::Hash

PROTOTYPES: ENABLE

# XS code

const char *
new(class,hash_filename,log_filename)
    const char * class
    const char * hash_filename 
    const char * log_filename

    PREINIT:
    sparkey_returncode rc;

    PPCODE:
    // check the return code
    rc = sparkey_hash_write(hash_filename, log_filename, 0);
    perl_sparkey_assert_error(rc);
    EXTEND(SP, 1);
    PUSHs(sv_2mortal(newSVpv("0.042", 0)));


