#include <snake.s/snake.h>

#include <snake.s/vector.h>

#include <cmocka.h>

static void test_snake_init_sets_x([[maybe_unused]] void ** state)
{
  // Arrange:
  snake_t snake;
  vector_t head_position = {1, 2};

  // Act:
  snake_init(&snake, head_position, 3);

  // Assert:
  assert_int_equal(snake.head_position.x, 1);
}

static void test_snake_init_sets_y([[maybe_unused]] void ** state)
{
  // Arrange:
  snake_t snake;
  vector_t head_position = {1, 2};

  // Act:
  snake_init(&snake, head_position, 3);

  // Assert:
  assert_int_equal(snake.head_position.y, 2);
}

static void test_snake_init_sets_length([[maybe_unused]] void ** state)
{
  // Arrange:
  snake_t snake;
  vector_t head_position = {1, 2};

  // Act:
  snake_init(&snake, head_position, 3);

  // Assert:
  assert_int_equal(snake.length, 3);
}

static void test_snake_init_sets_direction_to_zero([[maybe_unused]] void ** state)
{
  // Arrange:
  snake_t snake;
  vector_t head_position = {1, 2};
  vector_t zero_vector = {0, 0};

  // Act:
  snake_init(&snake, head_position, 3);

  // Assert:
  assert_true(vector_equals(snake.move_direction, zero_vector));
}

int run_snake_tests(void)
{
  struct CMUnitTest const tests[] = {
    cmocka_unit_test(test_snake_init_sets_x),
    cmocka_unit_test(test_snake_init_sets_y),
    cmocka_unit_test(test_snake_init_sets_length),
    cmocka_unit_test(test_snake_init_sets_direction_to_zero),
  };

  return cmocka_run_group_tests(tests, NULL, NULL);
}
