cmake_minimum_required(VERSION "4.2.0")

project("snake.s"
  DESCRIPTION "The assembly snake!"
  VERSION "1.0.0"
  LANGUAGES ASM
)

add_subdirectory("libs")

add_executable("snake.s"
  "src/error.S"
  "src/main.S"
)

target_link_libraries("snake.s" PRIVATE
  "bindings::SDL2"
)

install(TARGETS "snake.s")
