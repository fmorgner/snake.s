find_package("SDL2" REQUIRED)

add_library("bindings_SDL2" INTERFACE
  "SDL.S"

  "SDL/error.S"
  "SDL/events.S"
  "SDL/init.S"
  "SDL/rect.S"
  "SDL/render.S"
  "SDL/video.S"
)

target_link_libraries("bindings_SDL2" INTERFACE
  "SDL2::SDL2"
)

add_library("bindings::SDL2" ALIAS "bindings_SDL2")