//! @file render.S
//!
//! Assembler bindings for SDL2 (SDL_render.h)

#define SDL_RENDERER_ACCELERATED 0x00000002u
#define SDL_RENDERER_PRESENTVSYNC 0x00000004u


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

//! @fn int SDL_RenderClear(SDL_Renderer * renderer);
//! @param renderer the rendering context.
//! @return 0 on success, or a negative value on error.
.type SDL_RenderClear, @function
.extern SDL_RenderClear

//! @fn int SDL_RenderFillRect(SDL_Renderer * renderer, const SDL_Rect * rect);
//! @param renderer the rendering context.
//! @param rect the rectangle to fill
//! @return 0 on success, or a negative value on error.
.type SDL_RenderFillRect, @function
.extern SDL_RenderFillRect

//! @fn void SDL_RenderPresent(SDL_Renderer * renderer);
//! @param renderer the rendering context
.type SDL_RenderPresent, @function
.extern SDL_RenderPresent

//! @fn int SDL_SetRenderDrawColor(SDL_Renderer * renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
//! @param renderer the rendering context.
//! @param r the red value used to draw on the rendering target.
//! @param g the green value used to draw on the rendering target.
//! @param b the blue value used to draw on the rendering target.
//! @param a the alpha value used to draw on the rendering target.
//! @return 0 on success, or a negative value on error.
.type SDL_SetRenderDrawColor, @function
.extern SDL_SetRenderDrawColor