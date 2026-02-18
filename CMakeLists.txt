cmake_minimum_required(VERSION "4.2.0")

project("snake.s"
  DESCRIPTION "The assembly snake!"
  VERSION "1.0.0"
  LANGUAGES ASM
)

find_package("SDL2" REQUIRED)

add_library("SDL2_bindings" INTERFACE
  "libs/SDL.S"
  "libs/SDL/init.S"
  "libs/SDL/render.S"
  "libs/SDL/video.S"
)

target_include_directories("SDL2_bindings" INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/libs"
)

add_executable("snake.s"
  "src/error.S"
  "src/main.S"
)

target_link_libraries("snake.s" PRIVATE
  "SDL2::SDL2"
  "SDL2_bindings"
)

install(TARGETS "snake.s")
