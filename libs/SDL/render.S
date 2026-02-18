//! @file render.S
//!
//! Assembler bindings for SDL2 (SDL_render.h)

#define SDL_RENDERER_ACCELERATED 0x00000002u

//! @fn SDL_Renderer * SDL_CreateRenderer(SDL_Window * window, int index, Uint32 flags);
//! @param the window where rendering is displayed.
//! @param index the index of the rendering driver to initialize, or -1 to initialize the first one supporting the requested flags
//! @param flags 0, or one or more SDL_RendererFlags OR'd together.
//! @return a valid rendering context or NULL on error.
.type SDL_CreateRenderer, @function
.extern SDL_CreateRenderer

//! @fn void SDL_DestroyRenderer(SDL_Renderer * renderer);
//! @param renderer the renderer to destroy
.type SDL_DestroyRenderer, @function
.extern SDL_DestroyRenderer