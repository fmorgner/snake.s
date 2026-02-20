#include "helpers/function.S"
#include "SDL/error.S"

#ifndef __STDC_VERSION__

.section .rodata

  sdl_error_format: .string "%s: %s\n"

.section .text

  //! @function _print_sdl_error(char const * prefix)
  //!
  //! @param (%rdi) prefix The prefix to be printed in front of the error message
  function_begin _print_sdl_error

    sub $8, %rsp
    push %rdi
 
    call SDL_GetError@PLT
    mov %rax, %rdx
 
    mov (%rsp), %rsi
    lea sdl_error_format(%rip), %rdi
    call printf@PLT

  function_end

#endif