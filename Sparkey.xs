#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <sparkey.h>
#include "perl_sparkey.h"

#include <string.h>
#include <stdint.h>

typedef sparkey_logwriter * Sparkey__LogWriter;

/* C functions */

MODULE = Sparkey		PACKAGE = Sparkey::LogWriter

PROTOTYPES: ENABLE

# XS code

Sparkey__LogWriter
_new_create(class, filename, compression_type=SPARKEY_COMPRESSION_NONE, compression_block_size=0)
    const char *class
    const char *filename
    sparkey_compression_type compression_type
    int compression_block_size

    PREINIT:
    sparkey_logwriter *log;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_create(&log, filename, compression_type, compression_block_size);
    perl_sparkey_assert_error(rc);

    EXTEND(SP, 1); 

    /* ST(0) = sv_newmortal(); */
    /* sv_setref_pv(ST(0), "Sparkey::LogWriter", (void*)mywriter); */

    /* PUSHs(log); */
    /* PUSHs(sv_2mortal(newSVpv("0.42", 0))); */

    PUSHs( sv_setref_pv(sv_newmortal(), class, (void*)log));

Sparkey__LogWriter
_new_append(class, filename, compression_type=SPARKEY_COMPRESSION_NONE, compression_block_size=0)
    const char * class
    const char * filename

    PREINIT:
    sparkey_logwriter *log;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_append(&log, filename);
    perl_sparkey_assert_error(rc);

    EXTEND(SP, 1); 

    PUSHs( sv_setref_pv(sv_newmortal(), class, (void*)log));

Sparkey__LogWriter
put(log, key, value)
    Sparkey__LogWriter log
    const char *key
    const char *value

    PREINIT:
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_put(log, (uint64_t) strlen(key), (const uint8_t *)key, (uint64_t) strlen(value), (const uint8_t *)value);
    perl_sparkey_assert_error(rc);

MODULE = Sparkey		PACKAGE = Sparkey::Hash

PROTOTYPES: ENABLE

# XS code

const char *
new(class, hash_filename, log_filename)
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


