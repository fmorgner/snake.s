#include <snake.s/function.S>
#include <snake.s/vector.h>

.section .text

  // void vector_init(vector_t *self, uint32_t x, uint32_t y)
  function_begin vector_init

    test %rdi, %rdi
    jz .Lexit_vector_init

    mov %esi, OFFSET_vector_t_x(%rdi)
    mov %edx, OFFSET_vector_t_y(%rdi)

  function_end

  // bool vector_equals(vector_t lhs, vector_t rhs)
  function_begin vector_equals

    cmp %rsi, %rdi
    sete %al
    movzbq %al, %rax

  function_end

  // vector_t vector_add(vector_t lhs, vector_t rhs)
  function_begin vector_add

#if SNAKE_SSE2_MATH == 1
    movq %rdi, %xmm0
    movq %rsi, %xmm1
    paddd %xmm1, %xmm0
    movq %xmm0, %rax
#else
    mov %edi, %eax
    add %esi, %eax

    mov %rdi, %rcx
    shr $32, %rcx   

    mov %rsi, %rdx
    shr $32, %rdx
    add %edx, %ecx
    shl $32, %rcx

    or %rcx, %rax
#endif

  function_end

  // vector_t vector_subtract(vector_t lhs, vector_t rhs)
  function_begin vector_subtract

#if SNAKE_SSE2_MATH == 1
    movq %rdi, %xmm0
    movq %rsi, %xmm1
    psubd %xmm1, %xmm0
    movq %xmm0, %rax
#else
    mov %edi, %eax
    sub %esi, %eax

    mov %rdi, %rcx
    shr $32, %rcx

    mov %rsi, %rdx
    shr $32, %rdx
    sub %edx, %ecx
    shl $32, %rcx

    or %rcx, %rax
#endif

  function_end

  // uint32_t vector_grid_distance(vector_t origin, vector_t destination)
  function_begin vector_grid_distance

    call vector_subtract

    mov %rax, %r8
    shr $32, %r8

    mov %eax, %ecx
    mov %eax, %edx
    sar $31, %ecx
    xor %ecx, %edx
    sub %ecx, %edx
    mov %edx, %eax

    mov %r8d, %ecx
    mov %r8d, %edx
    sar $31, %ecx
    xor %ecx, %edx
    sub %ecx, %edx

    add %edx, %eax

  function_end
