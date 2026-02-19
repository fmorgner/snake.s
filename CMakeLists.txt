cmake_minimum_required(VERSION "4.2.0")

project("snake.s"
  DESCRIPTION "The assembly snake!"
  VERSION "1.0.0"
  LANGUAGES ASM
)

option(SNAKE_BUILD_TESTS "Build the snake.s tests" ON)

add_subdirectory("libs")

add_library("snake.core"
  "src/error.S"
  "src/snake.S"
)

target_include_directories("snake.core" PUBLIC
  "src"
)

target_link_libraries("snake.core" PUBLIC
  "bindings::SDL2"
)

add_executable("snake.s" "src/main.S")

target_link_libraries("snake.s" PRIVATE "snake.core")

install(TARGETS "snake.s")

if(SNAKE_BUILD_TESTS)
  add_subdirectory("tests")
endif()