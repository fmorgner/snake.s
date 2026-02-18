#include "helpers/function.S"
#include "SDL/init.S"
#include "SDL/render.S"
#include "SDL/video.S"

#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 600

// integer-params:  RDI, RSI, RDX, RCX, R8, R9
// caller-saved:    RAX, RCX, RDX, RSI, RDI, R8-R11
// callee-saved:    RBX, RSP, RBP, R12-R15

.section .rodata
  failed_to_create_renderer:    .string "Renderer could not be created\nSDL_error: %s\n"
  failed_to_create_window:      .string "Window could not be created\nSDL_error: %s\n"
  failed_to_initialize_sdl:     .string "SDL could not be initialized\nSDL_error: %s\n"

  succeeded_to_create_renderer: .string "Renderer created successfully!\n"
  succeeded_to_create_window:   .string "Window created successfully!\n"
  succeeded_to_initialize_sdl:  .string "SDL2 initialized successfully!\n"

  window_title:                 .string "snake.s"

.section .text

  function_begin main

    define_local window_handle, 8
    define_local renderer_handle, 8
    allocate_locals

    // initialize SDL
    mov $SDL_INIT_VIDEO, %rdi
    call SDL_Init@PLT

    // check if initialization was successful
    test %rax, %rax
    jae 1f
      lea failed_to_initialize_sdl(%rip), %rdi
      call _print_sdl_error@PLT
      mov $1, %rax
      function_exit
  1:
    lea succeeded_to_initialize_sdl(%rip), %rdi
    xor %rax, %rax
    call printf@PLT

    // create a window
    lea window_title(%rip), %rdi
    mov $SDL_WINDOWPOS_UNDEFINED, %rsi
    mov $SDL_WINDOWPOS_UNDEFINED, %rdx
    mov $SCREEN_WIDTH, %rcx
    mov $SCREEN_HEIGHT, %r8
    mov $SDL_WINDOW_SHOWN, %r9
    call SDL_CreateWindow@PLT
    store_local %rax, window_handle

    // check if window creation was successful
    test %rax, %rax
    jne 1f
      lea failed_to_create_window(%rip), %rdi
      call _print_sdl_error@PLT
      mov $1, %rax
      function_exit
  1:
    lea succeeded_to_create_window(%rip), %rdi
    xor %rax, %rax
    call printf@PLT

    // create a renderer
    load_local window_handle, %rdi
    mov $-1, %rsi
    mov $SDL_RENDERER_ACCELERATED, %rdx
    call SDL_CreateRenderer@PLT
    store_local %rax, renderer_handle

    // check if renderer creation was successful
    test %rax, %rax
    jne 1f
      lea failed_to_create_renderer(%rip), %rdi
      call _print_sdl_error@PLT
      jmp .Ldestroy_window
  1:
    lea succeeded_to_create_renderer(%rip), %rdi
    xor %rax, %rax
    call printf@PLT

  .Ldestroy_renderer:
    // destroy the renderer
    load_local renderer_handle, %rdi
    call SDL_DestroyRenderer

  .Ldestroy_window:
    // destroy the window
    load_local window_handle, %rdi
    call SDL_DestroyWindow@PLT

    call SDL_Quit@PLT

    xor %rax, %rax

  function_end

