#include "suites.h"

#include "snake.S"

#include <cmocka.h>



extern void snake_init(snake_t *self, int x, int y, int length);

static void test_snake_init_sets_x([[maybe_unused]] void **state) {
  // Arrange:
  snake_t snake;

  // Act:
  snake_init(&snake, 1, 2, 3);

  // Assert:
  assert_int_equal(snake.x, 1);
}

static void test_snake_init_sets_y([[maybe_unused]] void **state) {
  // Arrange:
  snake_t snake;

  // Act:
  snake_init(&snake, 1, 2, 3);

  // Assert:
  assert_int_equal(snake.y, 2);
}

static void test_snake_init_sets_length([[maybe_unused]] void **state) {
  // Arrange:
  snake_t snake;

  // Act:
  snake_init(&snake, 1, 2, 3);

  // Assert:
  assert_int_equal(snake.length, 3);
}

static void
test_snake_init_sets_direction_to_zero([[maybe_unused]] void **state) {
  // Arrange:
  snake_t snake;

  // Act:
  snake_init(&snake, 1, 2, 3);

  // Assert:
  assert_int_equal(snake.direction, 0);
}

int run_snake_tests(void) {
  struct CMUnitTest const tests[] = {
      cmocka_unit_test(test_snake_init_sets_x),
      cmocka_unit_test(test_snake_init_sets_y),
      cmocka_unit_test(test_snake_init_sets_length),
      cmocka_unit_test(test_snake_init_sets_direction_to_zero),
  };

  return cmocka_run_group_tests(tests, NULL, NULL);
}
