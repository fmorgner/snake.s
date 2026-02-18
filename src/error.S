#include "helpers/function.S"

.section .text

  //! @function _print_sdl_error(char const * format)
  function_begin _print_sdl_error

    push %rdi
    sub $8, %rsp
 
    call SDL_GetError@PLT
    mov %rax, %rsi
 
    add $8, %rsp
    pop %rdi

    call printf@PLT

  function_end

