cmake_minimum_required(VERSION "4.2.0")

project("snake.s"
  DESCRIPTION "The assembly snake!"
  VERSION "1.0.0"
  LANGUAGES ASM
)

#[============================================================================[
# Modules
#]============================================================================]

include("CTest")

#[============================================================================[
# Options
#]============================================================================]

option(SNAKE_ENABLE_SSE2_MATH "Enable SSE2 math instructions" OFF)

#[============================================================================[
# External Library Interfaces
#]============================================================================]

add_subdirectory("libs")

#[============================================================================[
# Core Library
#]============================================================================]

add_library("snake.core"
  "src/error.S"
  "src/position.S"
  "src/snake.S"
  "src/vector.S"
)

target_include_directories("snake.core" PUBLIC
  "src"
)

target_link_libraries("snake.core" PUBLIC
  "bindings::SDL2"
)

target_compile_definitions("snake.core" PUBLIC
  SNAKE_SSE2_MATH=$<BOOL:${SNAKE_ENABLE_SSE2_MATH}>
)

#[============================================================================[
# Game Application
#]============================================================================]

add_executable("snake.s" "src/main.S")

target_link_libraries("snake.s" PRIVATE "snake.core")

install(TARGETS "snake.s")

#[============================================================================[
# Tests
#]============================================================================]

if(BUILD_TESTING)
  add_subdirectory("tests")
endif()
