#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <sparkey.h>

#include <string.h>
#include <stdint.h>

typedef sparkey_logwriter * Sparkey__LogWriter;
typedef sparkey_logreader * Sparkey__LogReader;
typedef sparkey_logiter * Sparkey__LogReader__Iterator;

/* Utility functions */

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
    croak("unexpected: unknown internal compression type");
}

sparkey_compression_type perl_sparkey_string_to_compression_type (SV * compression_type) {
    const char * compression_type_str = (char *) SvPV_nolen(compression_type);
    if (strcasecmp(compression_type_str, "none") == 0)
        return SPARKEY_COMPRESSION_NONE;
    if (strcasecmp(compression_type_str, "snappy") == 0)
        return SPARKEY_COMPRESSION_SNAPPY;
    croak("Unknown compression type. Should be one of 'none', 'snappy'");
}

/* XS code */

MODULE = Sparkey		PACKAGE = Sparkey::LogWriter

PROTOTYPES: ENABLE

# XS code

void
_new_create(class, filename, compression_type=SPARKEY_COMPRESSION_NONE, compression_block_size=0)
    const char *class
    const char *filename
    sparkey_compression_type compression_type
    int compression_block_size

    PREINIT:
    Sparkey__LogWriter log_writer;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_create(&log_writer, filename, compression_type, compression_block_size);
    perl_sparkey_assert_error(rc);

    PUSHs( sv_setref_pv(sv_newmortal(), class, (void*)log_writer));

void
_new_append(class, filename)
    const char * class
    const char * filename

    PREINIT:
    Sparkey__LogWriter log_writer;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_append(&log_writer, filename);
    perl_sparkey_assert_error(rc);

    PUSHs( sv_setref_pv(sv_newmortal(), class, (void*)log_writer));

void
put(log_writer, key, value)
    Sparkey::LogWriter log_writer
    const char *key
    const char *value

    PREINIT:
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_put(log_writer, (uint64_t) strlen(key), (const uint8_t *)key, (uint64_t) strlen(value), (const uint8_t *)value);
    perl_sparkey_assert_error(rc);

void
close(log_writer)
    Sparkey::LogWriter log_writer

    PREINIT:
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logwriter_close(&log_writer);
    perl_sparkey_assert_error(rc);


MODULE = Sparkey		PACKAGE = Sparkey::LogReader

PROTOTYPES: ENABLE

void
new(class, filename)
    const char *class
    const char *filename

    PREINIT:
    Sparkey__LogReader log_reader;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logreader_open(&log_reader, filename);
    perl_sparkey_assert_error(rc);

    PUSHs( sv_setref_pv(sv_newmortal(), class, (void*)log_reader) );

MODULE = Sparkey		PACKAGE = Sparkey::LogReader::Iterator

PROTOTYPES: ENABLE

void
new(class, log_reader)
    const char *class
    Sparkey::LogReader log_reader

    PREINIT:
    Sparkey__LogReader__Iterator log_iterator;
    sparkey_returncode rc;

    PPCODE:
    rc = sparkey_logiter_create(&log_iterator, log_reader);
    perl_sparkey_assert_error(rc);

    PUSHs( sv_setref_pv(sv_newmortal(), class, (void*)log_iterator) );

MODULE = Sparkey		PACKAGE = Sparkey::Hash

PROTOTYPES: ENABLE

const char *
testing_stuff(class, hash_filename, log_filename)
    const char * class
    const char * hash_filename 
    const char * log_filename

    PREINIT:
    sparkey_returncode rc;

    PPCODE:

    /* check the return code */
    rc = sparkey_hash_write(hash_filename, log_filename, 0);
    perl_sparkey_assert_error(rc);
    PUSHs(sv_2mortal(newSVpv("0.042", 0)));


