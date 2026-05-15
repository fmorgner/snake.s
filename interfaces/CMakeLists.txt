find_package("SDL2" REQUIRED)

add_library("interfaces_SDL2" INTERFACE)
add_library("interfaces::SDL2" ALIAS "interfaces_SDL2")

target_sources("interfaces_SDL2" INTERFACE
  "SDL.S"
  "SDL/error.S"
  "SDL/events.S"
  "SDL/init.S"
  "SDL/rect.S"
  "SDL/render.S"
  "SDL/timer.S"
  "SDL/video.S"
)

target_link_libraries("interfaces_SDL2" INTERFACE
  "SDL2::SDL2"
)

target_include_directories("interfaces_SDL2" INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}"
)

add_library("interfaces_libc" INTERFACE)
add_library("interfaces::libc" ALIAS "interfaces_libc")

target_sources("interfaces_libc" INTERFACE
  "libc.S"
  "libc/stdio.S"
)

target_link_libraries("interfaces_libc" INTERFACE
  "c"
)

target_include_directories("interfaces_SDL2" INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}"
)
