//! @file sdl.S
//!
//! Assembler bindings for SDL2

#define SDL_INIT_TIMER           0x00000001u
#define SDL_INIT_AUDIO           0x00000010u
#define SDL_INIT_VIDEO           0x00000020u
#define SDL_INIT_JOYSTICK        0x00000200u
#define SDL_INIT_HAPTIC          0x00001000u
#define SDL_INIT_GAMECONTROLLER  0x00002000u

#define SDL_RENDERER_ACCELERATED 0x00000002u

#define SDL_WINDOW_SHOWN         0x00000004u

#define SDL_WINDOWPOS_UNDEFINED  0x1FFF0000u

// int SDL_Init(uint32_t flags)
.type SDL_Init, @function
.extern SDL_Init

// SDL_Renderer * SDL_CreateRenderer(SDL_Window * window, int index, Uint32 flags);
.type SDL_CreateRenderer, @function
.extern SDL_CreateRenderer

// SDL_Window * SDL_CreateWindow(const char *title, int x, int y, int w, int h, uint32_t flags)
.type SDL_CreateWindow, @function
.extern SDL_CreateWindow

// void SDL_DestroyWindow(SDL_Window *window)
.type SDL_DestroyWindow, @function
.extern SDL_DestroyWindow

// void SDL_Quit(void)
.type SDL_Quit, @function
.extern SDL_Quit