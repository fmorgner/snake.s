//! @file position.S
//!
//! Type definitions, sizes, and the interface for positions.

#ifndef SNAKE_POSITION_S
#define SNAKE_POSITION_S

#include "helpers/function.S"

#define OFFSET_position_t_x 0
#define SIZE_position_t_x 4

#define OFFSET_position_t_y OFFSET_position_t_x + SIZE_position_t_x
#define SIZE_position_t_y 4

#define OFFSET_position_t_padding OFFSET_position_t_y + SIZE_position_t_y
#define SIZE_position_t_padding 0

#define SIZE_position_t OFFSET_position_t_padding + SIZE_position_t_padding

#ifndef __STDC_VERSION__

.section .text

  //! @fn void position_init(position_t * self, int x, int y)
  //! @param (%rdi) self    the object to initialize
  //! @param (%esi) x       the x value of this position
  //! @param (%edx) y       the y value of this position
  function_begin position_init

    test %rdi, %rdi
    jz .Lexit_position_init

    mov %esi, OFFSET_position_t_x(%rdi)
    mov %edx, OFFSET_position_t_y(%rdi)

  function_end

#else

#include <stddef.h>

typedef struct {
  int x;
  int y;
} position_t;

static_assert(sizeof(position_t) == SIZE_position_t);

static_assert(offsetof(position_t, x) == OFFSET_position_t_x);
static_assert(sizeof(((position_t*)0)->x) == SIZE_position_t_x);

static_assert(offsetof(position_t, y) == OFFSET_position_t_y);
static_assert(sizeof(((position_t*)0)->y) == SIZE_position_t_y);

void position_init(position_t * self, int x, int y);

#endif
#endif
