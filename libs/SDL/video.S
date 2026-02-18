//! @file video.S
//!
//! Assembler bindings for SDL2 (SDL_video.h)

#define SDL_WINDOW_SHOWN         0x00000004u

#define SDL_WINDOWPOS_UNDEFINED  0x1FFF0000u

//! @fn SDL_Window * SDL_CreateWindow(const char *title, int x, int y, int w, int h, uint32_t flags)
//! @param title the window title
//! @param x the X position of the window, or SDL_WINDOWPOS_UNDEFINED
//! @param y the Y position of the window, or SDL_WINDOWPOS_UNDEFINED
//! @param w the width of the window
//! @param h the height of the window
//! @param flags 0, or one or more SDL_WindowFlags OR'd together.
//! @return a valid window or NULL on error
.type SDL_CreateWindow, @function
.extern SDL_CreateWindow

//! @fn void SDL_DestroyWindow(SDL_Window *window)
//! @param window the window to destroy
.type SDL_DestroyWindow, @function
.extern SDL_DestroyWindow
