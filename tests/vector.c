#include "suites.h"

#include "vector.S"

#include <cmocka.h>

static void test_vector_init_sets_x([[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector;

  // Act:
  vector_init(&vector, 1, 2);

  // Assert:
  assert_int_equal(vector.x, 1);
}

static void test_vector_init_sets_y([[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector;

  // Act:
  vector_init(&vector, 1, 2);

  // Assert:
  assert_int_equal(vector.y, 2);
}

static void
test_vector_equals_is_true_for_equal_vectors([[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 1, .y = 2};
  vector_t other = {.x = 1, .y = 2};

  // Act:
  auto result = vector_equals(vector, other);

  // Assert:
  assert_true(result);
}

static void
test_vector_equals_is_false_for_unequal_vectors([[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 1, .y = 2};
  vector_t otherY = {.x = 1, .y = 3};
  vector_t otherX = {.x = 2, .y = 2};
  vector_t otherXY = {.x = 2, .y = 3};

  // Act:
  auto resultY = vector_equals(vector, otherY);
  auto resultX = vector_equals(vector, otherX);
  auto resultXY = vector_equals(vector, otherXY);

  // Assert:
  assert_false(resultX);
  assert_false(resultY);
  assert_false(resultXY);
}

static void
test_vector_add_correctly_calculates_sum([[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 1, .y = 2};
  vector_t other = {.x = 3, .y = 4};

  // Act:
  auto result = vector_add(vector, other);

  // Assert:
  assert_int_equal(result.x, 4);
  assert_int_equal(result.y, 6);
}

static void test_vector_subtract_correctly_calculates_difference(
    [[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 1, .y = 2};
  vector_t other = {.x = 3, .y = 4};

  // Act:
  auto result = vector_subtract(vector, other);

  // Assert:
  assert_int_equal(result.x, -2);
  assert_int_equal(result.y, -2);
}

static void test_vector_subtract_correctly_calculates_difference_all_zero(
    [[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 0, .y = 0};
  vector_t other = {.x = 0, .y = 0};

  // Act:
  auto result = vector_subtract(vector, other);

  // Assert:
  assert_int_equal(result.x, 0);
  assert_int_equal(result.y, 0);
}

static void test_vector_subtract_correctly_calculates_difference_all_non_zero(
    [[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 10, .y = 20};
  vector_t other = {.x = 3, .y = 4};

  // Act:
  auto result = vector_subtract(vector, other);

  // Assert:
  assert_int_equal(result.x, 7);
  assert_int_equal(result.y, 16);
}

static void
test_vector_grid_distance_calculates_difference([[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 1, .y = 2};
  vector_t other = {.x = 3, .y = 4};

  // Act:
  auto result = vector_grid_distance(vector, other);

  // Assert:
  assert_int_equal(result, 4);
}

static void test_vector_grid_distance_calculates_difference_all_zero(
    [[maybe_unused]] void **state) {
  // Arrange:
  vector_t vector = {.x = 0, .y = 0};
  vector_t other = {.x = 0, .y = 0};

  // Act:
  auto result = vector_grid_distance(vector, other);

  // Assert:
  assert_int_equal(result, 0);
}

int run_vector_tests(void) {
  struct CMUnitTest const tests[] = {
      cmocka_unit_test(test_vector_init_sets_x),
      cmocka_unit_test(test_vector_init_sets_y),
      cmocka_unit_test(test_vector_add_correctly_calculates_sum),
      cmocka_unit_test(test_vector_subtract_correctly_calculates_difference),
      cmocka_unit_test(
          test_vector_subtract_correctly_calculates_difference_all_zero),
      cmocka_unit_test(
          test_vector_subtract_correctly_calculates_difference_all_non_zero),
      cmocka_unit_test(test_vector_equals_is_true_for_equal_vectors),
      cmocka_unit_test(test_vector_equals_is_false_for_unequal_vectors),
      cmocka_unit_test(test_vector_grid_distance_calculates_difference),
      cmocka_unit_test(
          test_vector_grid_distance_calculates_difference_all_zero),
  };

  return cmocka_run_group_tests(tests, NULL, NULL);
}
