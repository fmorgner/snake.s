#include "suites.h"

#include <cmocka.h>

int main() {
  return run_position_tests() + run_vector_tests() + run_snake_tests();
}
