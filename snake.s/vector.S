//! @file vector.S
//!
//! Type definitions, sizes, and the interface for vectors.

#ifndef SNAKE_VECTOR_S
#define SNAKE_VECTOR_S

#include <snake.s/function.S>

#define OFFSET_vector_t_x 0
#define SIZE_vector_t_x 4

#define OFFSET_vector_t_y OFFSET_vector_t_x + SIZE_vector_t_x
#define SIZE_vector_t_y 4

#define OFFSET_vector_t_padding OFFSET_vector_t_y + SIZE_vector_t_y
#define SIZE_vector_t_padding 0

#define SIZE_vector_t OFFSET_vector_t_padding + SIZE_vector_t_padding

#ifndef __STDC_VERSION__

.section .text

  //! @fn void vector_init(vector_t * self, uint32_t x, uint32_t y)
  //! @param (%rdi) self    the object to initialize
  //! @param (%esi) x       the x value of this vector
  //! @param (%edx) y       the y value of this vector
  function_begin vector_init

    test %rdi, %rdi
    jz .Lexit_vector_init

    mov %esi, OFFSET_vector_t_x(%rdi)
    mov %edx, OFFSET_vector_t_y(%rdi)

  function_end

  //! @fn bool vector_equals(vector_t lhs, vector_t rhs)
  //! @param (%rdi) lhs   the left hand side of the comparison
  //! @param (%rsi) rhs   the right hand side of the comparison
  //! @result (%rax) true iff the vectors are equal, false otherwise
  function_begin vector_equals

    cmp %rsi, %rdi
    sete %al
    movzbq %al, %rax

  function_end

  //! @fn vector_t vector_add(vector_t lhs, vector_t rhs)
  //! @param (%rdi) lhs   the left hand side of the addition
  //! @param (%rsi) rhs   the right hand side of the addition
  //! @result (%rax) the resulting vector
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

  //! @fn vector_t vector_subtract(vector_t lhs, vector_t rhs)
  //! @param (%rdi) lhs   the left hand side of the subtraction
  //! @param (%rsi) rhs   the right hand side of the subtraction
  //! @result (%rax) the resulting vector
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

  //! @fn uint32_t vector_grid_distance(vector_t lhs, vector_t rhs)
  //! @param (%rdi) lhs   the left hand side of the distance
  //! @param (%rsi) rhs   the right hand side of the distance
  //! @result (%rax) the grid distance between the vectors
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

#else

#include <stddef.h>
#include <stdint.h>

typedef struct {
  int32_t x;
  int32_t y;
} vector_t;

static_assert(sizeof(vector_t) == SIZE_vector_t);

static_assert(offsetof(vector_t, x) == OFFSET_vector_t_x);
static_assert(sizeof(((vector_t*)0)->x) == SIZE_vector_t_x);

static_assert(offsetof(vector_t, y) == OFFSET_vector_t_y);
static_assert(sizeof(((vector_t*)0)->y) == SIZE_vector_t_y);

void vector_init(vector_t * self, uint32_t x, uint32_t y);
bool vector_equals(vector_t lhs, vector_t rhs);
vector_t vector_add(vector_t lhs, vector_t rhs);
vector_t vector_subtract(vector_t lhs, vector_t rhs);
uint32_t vector_grid_distance(vector_t lhs, vector_t rhs);

#endif
#endif