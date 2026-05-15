#ifndef __STDC_VERSION__

//! @var FILE * stdout
.type stdout, @object
.extern stdout

//! @fn int printf(const char *format, ...)
.type printf, @function
.extern printf

//! @fn int fflush(FILE *stream)
.type fflush, @function
.extern fflush

#endif