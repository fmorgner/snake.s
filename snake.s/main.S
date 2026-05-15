#include <snake.s/function.S>

#include <interfaces/SDL/events.S>
#include <interfaces/SDL/init.S>
#include <interfaces/SDL/rect.S>
#include <interfaces/SDL/render.S>
#include <interfaces/SDL/video.S>

#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 600

// integer-params:  RDI, RSI, RDX, RCX, R8, R9
// caller-saved:    RAX, RCX, RDI, RSI, RDX, R8-R11
// callee-saved:    RBX, RSP, RBP, R12-R15

.section .rodata
  failed_to_create_renderer:    .string "Renderer could not be created"
  failed_to_create_window:      .string "Window could not be created"
  failed_to_initialize_sdl:     .string "SDL could not be initialized"

  succeeded_to_create_renderer: .string "Renderer created successfully!\n"
  succeeded_to_create_window:   .string "Window created successfully!\n"
  succeeded_to_initialize_sdl:  .string "SDL2 initialized successfully!\n"

  window_title:                 .string "snake.s"

.section .text

  function_begin main

    push %r12
    push %r13

    define_local window_handle, 8
    define_local renderer_handle, 8
    define_local rect, SIZE_SDL_Rect
    define_local event, SIZE_SDL_Event
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
      jmp .Lquit_sdl
  1:
    lea succeeded_to_create_window(%rip), %rdi
    xor %rax, %rax
    call printf@PLT

    // create a renderer
    load_local window_handle, %rdi
    mov $-1, %rsi
    mov $(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC), %rdx
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

    // initialize a simple square, located at the screen's center
    mov $(SCREEN_HEIGHT / 2), %r8d
    mov $(SCREEN_WIDTH / 2), %r9d

    address_of_local rect, %rdi
    mov %r8d, OFFSET_SDL_Rect_w(%rdi)
    mov %r8d, OFFSET_SDL_Rect_h(%rdi)
    mov %r9d, %r10d
    shr $1, %r8d
    sub %r8d, %r10d
    mov %r10d, OFFSET_SDL_Rect_x(%rdi)
    mov %r8d, OFFSET_SDL_Rect_y(%rdi)

    //! @var bool quit_requested
    xor %r12, %r12

    // main loop
  .Lloop:

    address_of_local event, %rdi
    mov %rdi, %r13
    call SDL_PollEvent@PLT
    mov (%r13), %r8d

    // user requested to quit
    cmp $SDL_EVENT_QUIT, %r8d
    je .Lloop_end

    // use white color
    load_local renderer_handle, %rdi
    mov %rdi, %r13
    mov $0xff, %rsi
    mov %rsi, %rdx
    mov %rsi, %rcx
    mov %rsi, %r8
    call SDL_SetRenderDrawColor@PLT
    test %rax, %rax

    // clear the screen
    mov %r13, %rdi
    call SDL_RenderClear@PLT

    // use red color
    mov %r13, %rdi
    mov $0xff, %rsi
    mov $0x00, %rdx
    mov $0x00, %rcx
    mov %rsi, %r8
    call SDL_SetRenderDrawColor@PLT

    // draw the square
    mov %r13, %rdi
    address_of_local rect, %rsi
    call SDL_RenderFillRect@PLT

    // update the screen
    mov %r13, %rdi
    call SDL_RenderPresent@PLT

    jmp .Lloop
  .Lloop_end:

  .Ldestroy_renderer:
    // destroy the renderer
    load_local renderer_handle, %rdi
    call SDL_DestroyRenderer@PLT

  .Ldestroy_window:
    // destroy the window
    load_local window_handle, %rdi
    call SDL_DestroyWindow@PLT

  .Lquit_sdl:
    call SDL_Quit@PLT

    xor %rax, %rax
    pop %r13
    pop %r12
  function_end

