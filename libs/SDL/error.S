//! @file error.S
//!
//! Assembler bindings for SDL2 (SDL_error.h)

//! @fn char const * SDL_GetError(void)
//! @return the last error message
.type SDL_GetError, @function
.extern SDL_GetError