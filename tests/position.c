#include "suites.h"

#include "position.S"

#include <cmocka.h>

static void test_position_init_sets_x([[maybe_unused]] void **state) {
  // Arrange:
  position_t position;

  // Act:
  position_init(&position, 1, 2);

  // Assert:
  assert_int_equal(position.x, 1);
}

static void test_position_init_sets_y([[maybe_unused]] void **state) {
  // Arrange:
  position_t position;

  // Act:
  position_init(&position, 1, 2);

  // Assert:
  assert_int_equal(position.y, 2);
}

int run_position_tests(void) {
  struct CMUnitTest const tests[] = {
      cmocka_unit_test(test_position_init_sets_x),
      cmocka_unit_test(test_position_init_sets_y),
  };

  return cmocka_run_group_tests(tests, NULL, NULL);
}
