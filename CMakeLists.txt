cmake_minimum_required(VERSION "4.2.0")

project("snake.s"
  DESCRIPTION "The assembly snake!"
  VERSION "1.0.0"
  LANGUAGES ASM
)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED YES)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_VERIFY_INTERFACE_HEADER_SETS YES)
set(CMAKE_VERIFY_PRIVATE_HEADER_SETS YES)

#[============================================================================[
# Modules
#]============================================================================]

include("CTest")

#[============================================================================[
# Options
#]============================================================================]

option(SNAKE_ENABLE_SSE2_MATH "Enable SSE2 math instructions" OFF)

#[============================================================================[
# Dependencies
#]============================================================================]

include("FetchContent")

FetchContent_Declare("CMocka"
  URL "https://gitlab.com/cmocka/cmocka/-/archive/cmocka-2.0.0/cmocka-cmocka-2.0.0.zip"
  URL_HASH "SHA256=c2a53cc0a45e8be734f657e48daa687f077def759ea30adcd46bdb842a8fb269"
)

#[============================================================================[
# External Library Interfaces
#]============================================================================]

add_subdirectory("interfaces")

#[============================================================================[
# Core Library
#]============================================================================]

add_library("snake.core")
add_library("snake::core" ALIAS "snake.core")

target_sources("snake.core" PRIVATE
  "snake.s/error.S"
  "snake.s/function.S"
  "snake.s/snake.S"
  "snake.s/vector.S"
)

target_sources("snake.core" PUBLIC
  FILE_SET HEADERS
  FILES
  "snake.s/snake.h"
  "snake.s/vector.h"
)

target_include_directories("snake.core" PUBLIC
  "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_compile_options("snake.core" PUBLIC
  "-Wall"
  "-Wextra"
  "-Werror"
  "-pedantic-errors"
)

target_compile_definitions("snake.core" PUBLIC
  SNAKE_SSE2_MATH=$<BOOL:${SNAKE_ENABLE_SSE2_MATH}>
)

target_link_libraries("snake.core" PUBLIC
  "bindings::SDL2"
)

#[============================================================================[
# Game Application
#]============================================================================]

add_executable("snake.s")
add_executable("snake::app" ALIAS "snake.s")

target_sources("snake.s" PRIVATE
  "snake.s/main.S"
)

target_link_libraries("snake.s" PRIVATE
  "snake::core"
)

install(TARGETS "snake.s")

#[============================================================================[
# Tests
#]============================================================================]

if(BUILD_TESTING)
  enable_language(C)

  set(BUILD_SHARED_LIBS OFF)
  set(WITH_EXAMPLES OFF)

  FetchContent_MakeAvailable("CMocka")

  add_executable("snake.tests")
  add_executable("snake::tests" ALIAS "snake.tests")

  target_sources("snake.tests" PRIVATE
    "snake.s/tests.c"
    "snake.s/snake.tests.c"
    "snake.s/vector.tests.c"
  )

  target_link_libraries("snake.tests" PRIVATE
    "snake::core"
    "cmocka"
  )

  add_test(NAME "snake.tests" COMMAND "snake.tests")
endif()
