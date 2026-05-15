#ifndef SNAKE_SNAKE_H
#define SNAKE_SNAKE_H

#define OFFSET_snake_t_head_position 0
#define SIZE_snake_t_head_position 8

#define OFFSET_snake_t_move_direction OFFSET_snake_t_head_position + SIZE_snake_t_head_position
#define SIZE_snake_t_move_direction 8

#define OFFSET_snake_t_length OFFSET_snake_t_move_direction + SIZE_snake_t_move_direction
#define SIZE_snake_t_length 4

#define SIZE_snake_t OFFSET_snake_t_length + SIZE_snake_t_length

#ifdef __STDC_VERSION__

#include <snake.s/vector.h>

#include <stddef.h>

typedef struct
{
  vector_t head_position;
  vector_t move_direction;
  int length;
} snake_t;

static_assert(sizeof(snake_t) == SIZE_snake_t);

static_assert(offsetof(snake_t, head_position) == OFFSET_snake_t_head_position);
static_assert(sizeof(((snake_t *)0)->head_position) == SIZE_snake_t_head_position);

static_assert(offsetof(snake_t, move_direction) == OFFSET_snake_t_move_direction);
static_assert(sizeof(((snake_t *)0)->move_direction) == SIZE_snake_t_move_direction);

static_assert(offsetof(snake_t, length) == OFFSET_snake_t_length);
static_assert(sizeof(((snake_t *)0)->length) == SIZE_snake_t_length);

//! Initialize a snake given the initial position and length of its head.
//!
//! @param self the object to initialize
//! @param head_position the position of the head of the snake
//! @param length the length of the snake
void snake_init(snake_t * self, vector_t head_position, int length);

#else

// clang-format off

.section .text 

.global snake_init

// clang-format on

#endif
#endif