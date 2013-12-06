#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

/* #include <sparkey.h> */

/* C functions */

MODULE = Sparkey		PACKAGE = Sparkey		

# XS code

const char *
get_version()
    CODE:
        RETVAL = "0.42"; /*chromaprint_get_version(); */
    OUTPUT: RETVAL

