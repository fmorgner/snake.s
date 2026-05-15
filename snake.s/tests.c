#include <cmocka.h>

extern int run_vector_tests();
extern int run_snake_tests();

int main()
{
  return run_vector_tests() + run_snake_tests();
}
