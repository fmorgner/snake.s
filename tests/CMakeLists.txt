enable_language(C)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED YES)
set(CMAKE_C_EXTENSIONS OFF)

include("FetchContent")

FetchContent_Declare("CMocka"
  URL "https://gitlab.com/cmocka/cmocka/-/archive/cmocka-2.0.0/cmocka-cmocka-2.0.0.zip"
  URL_HASH "SHA256=c2a53cc0a45e8be734f657e48daa687f077def759ea30adcd46bdb842a8fb269"
)

set(BUILD_SHARED_LIBS OFF)
set(WITH_EXAMPLES OFF)

FetchContent_MakeAvailable("CMocka")

enable_testing()

add_executable("snake.tests"
  "main.c"
  "snake.c"
)

target_compile_features("snake.tests" PUBLIC
  "c_std_23"
)

target_compile_options("snake.tests" PUBLIC
  "-Wall"
  "-Wextra"
  "-Werror"
  "-pedantic-errors"
)

target_link_libraries("snake.tests" PUBLIC
  "snake.core"
  "cmocka"
)

add_test(NAME "snake.tests" COMMAND "snake.tests")