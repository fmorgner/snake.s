cmake_minimum_required(VERSION "4.2.0")

project("snake.s"
  DESCRIPTION "The assembly snake!"
  VERSION "1.0.0"
  LANGUAGES ASM
)

find_package("SDL2" REQUIRED)

add_executable("snake.s"
  "src/main.S"
)

target_link_libraries("snake.s" PRIVATE
  "SDL2::SDL2"
)

install(TARGETS "snake.s")
