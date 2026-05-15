#include <snake.s/snake.h>
#include <snake.s/function.S>
#include <snake.s/vector.h>

.section .text

  // void snake_init(snake_t * self, vector_t head_position, int length)
  function_begin snake_init

    test %rdi, %rdi
    jz .Lexit_snake_init

    mov %rsi, OFFSET_snake_t_head_position(%rdi)
    mov %edx, OFFSET_snake_t_length(%rdi)
    movq $0, OFFSET_snake_t_move_direction(%rdi)   

  function_end

