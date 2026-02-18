//! @file init.S
//!
//! Assembler bindings for SDL2 (SDL.h)

#define SDL_INIT_TIMER           0x00000001u
#define SDL_INIT_AUDIO           0x00000010u
#define SDL_INIT_VIDEO           0x00000020u
#define SDL_INIT_JOYSTICK        0x00000200u
#define SDL_INIT_HAPTIC          0x00001000u
#define SDL_INIT_GAMECONTROLLER  0x00002000u
#define SDL_INIT_EVENTS          0x00004000u
#define SDL_INIT_SENSOR          0x00008000u
#define SDL_INIT_NOPARACHUTE     0x00100000u
#define SDL_INIT_EVERYTHIN       (SDL_INIT_TIMER | \
                                  SDL_INIT_AUDIO | \
                                  SDL_INIT_VIDEO | \
                                  SDL_INIT_EVENTS | \
                                  SDL_INIT_JOYSTICK | \
                                  SDL_INIT_HAPTIC | \
                                  SDL_INIT_GAMECONTROLLER | \
                                  SDL_INIT_SENSOR)

//! @fn int SDL_Init(UInt32 flags)
//! @param flags subsystem initialization flags
//! @return 0 on success, a negative error code on failure
.type SDL_Init, @function
.extern SDL_Init

//! @fn void SDL_Quit(void)
.type SDL_Quit, @function
.extern SDL_Quit