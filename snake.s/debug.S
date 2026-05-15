#include <snake.s/function.S>

#include <interfaces/libc/stdio.S>

#ifndef __STDC_VERSION__

.section .text

//! @fn void _print_debug(char const * format, ...)
//!
//! @param (%rdi) format The format string
function_begin _print_debug

    xor %rax, %rax
    call printf@PLT
    mov stdout(%rip), %rdi
    call fflush@PLT
  
function_end

#endif
