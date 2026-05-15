#ifndef SNAKE_VECTOR_H
#define SNAKE_VECTOR_H

#define OFFSET_vector_t_x 0
#define SIZE_vector_t_x 4

#define OFFSET_vector_t_y OFFSET_vector_t_x + SIZE_vector_t_x
#define SIZE_vector_t_y 4

#define OFFSET_vector_t_padding OFFSET_vector_t_y + SIZE_vector_t_y
#define SIZE_vector_t_padding 0

#define SIZE_vector_t OFFSET_vector_t_padding + SIZE_vector_t_padding

#ifdef __STDC_VERSION__

#include <stddef.h>
#include <stdint.h>

typedef struct {
  int32_t x;
  int32_t y;
} vector_t;

static_assert(sizeof(vector_t) == SIZE_vector_t);

static_assert(offsetof(vector_t, x) == OFFSET_vector_t_x);
static_assert(sizeof(((vector_t *)0)->x) == SIZE_vector_t_x);

static_assert(offsetof(vector_t, y) == OFFSET_vector_t_y);
static_assert(sizeof(((vector_t *)0)->y) == SIZE_vector_t_y);

//! Initialize a vector object using the given components.
//!
//! @param self the object to initialize
//! @param x the x value of this vector
//! @param y the y value of this vector
void vector_init(vector_t *self, uint32_t x, uint32_t y);

//! Compare two vectors for equality.
//!
//! @param lhs the left hand side of the comparison
//! @param rhs the right hand side of the comparison
//! @result @p true iff the vectors are equal, false otherwise
bool vector_equals(vector_t lhs, vector_t rhs);

//! Add two vectors and return the resulting vector.
//!
//! @param lhs the left hand side of the addition
//! @param rhs the right hand side of the addition
//! @result the resulting vector
vector_t vector_add(vector_t lhs, vector_t rhs);

//! Subtract two vectors and return the resulting vector.
//!
//! @param lhs the left hand side of the subtraction
//! @param rhs the right hand side of the subtraction
//! @result the resulting vector
vector_t vector_subtract(vector_t lhs, vector_t rhs);

//! Calculate the grid (manhattan) distance between two vectors.
//!
//! @param origin the origin of the calculation
//! @param destination the destination point of the calculation
//! @result the grid distance between the origin and the destination
uint32_t vector_grid_distance(vector_t origin, vector_t destination);

#else

// clang-format off

.section .text 

.global vector_init
.global vector_equals
.global vector_add
.global vector_subtract
.global vector_grid_distance

// clang-format on

#endif
#endif