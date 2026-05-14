//! @file snake.S
//!
//! Type definitions, sizes, and the interface for the snake.

#ifndef SNAKE_SNAKE_S
#define SNAKE_SNAKE_S

#include "helpers/function.S"

#define OFFSET_snake_t_x 0
#define SIZE_snake_t_x 4

#define OFFSET_snake_t_y OFFSET_snake_t_x + SIZE_snake_t_x
#define SIZE_snake_t_y 4

#define OFFSET_snake_t_length OFFSET_snake_t_y + SIZE_snake_t_y
#define SIZE_snake_t_length 4

#define OFFSET_snake_t_direction OFFSET_snake_t_length + SIZE_snake_t_length
#define SIZE_snake_t_direction 1

#define OFFSET_snake_t_padding OFFSET_snake_t_direction + SIZE_snake_t_direction
#define SIZE_snake_t_padding 3

#define SIZE_snake_t OFFSET_snake_t_padding + SIZE_snake_t_padding

#ifndef __STDC_VERSION__

.section .text

  //! @fn void snake_init(snake_t * self, int x, int y, int length)
  //! @param (%rdi) self    the object to initialize
  //! @param (%esi) x       the x position of the head of the snake
  //! @param (%edx) y       the y position of the head of the snake
  //! @param (%ecx) length  the length of the snake
  function_begin snake_init

    test %rdi, %rdi
    jz .Lexit_snake_init

    mov %esi, OFFSET_snake_t_x(%rdi)
    mov %edx, OFFSET_snake_t_y(%rdi)
    mov %ecx, OFFSET_snake_t_length(%rdi)
    xor %al, %al
    mov %al, OFFSET_snake_t_direction(%rdi)

  function_end

#else

#include <stddef.h>

typedef struct {
  int x;
  int y;
  int length;
  char direction;
  char padding[3];
} snake_t;

static_assert(sizeof(snake_t) == SIZE_snake_t);

static_assert(offsetof(snake_t, x) == OFFSET_snake_t_x);
static_assert(sizeof(((snake_t*)0)->x) == SIZE_snake_t_x);

static_assert(offsetof(snake_t, y) == OFFSET_snake_t_y);
static_assert(sizeof(((snake_t*)0)->y) == SIZE_snake_t_y);

static_assert(offsetof(snake_t, length) == OFFSET_snake_t_length);
static_assert(sizeof(((snake_t*)0)->length) == SIZE_snake_t_length);

static_assert(offsetof(snake_t, direction) == OFFSET_snake_t_direction);
static_assert(sizeof(((snake_t*)0)->direction) == SIZE_snake_t_direction);

static_assert(offsetof(snake_t, padding) == OFFSET_snake_t_padding);
static_assert(sizeof(((snake_t*)0)->padding) == SIZE_snake_t_padding);

void snake_init(snake_t * self, int x, int y, int length);

#endif
#endif
