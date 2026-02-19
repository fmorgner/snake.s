#ifndef __STDC_VERSION__

//! @file events.S
//!
//! Assembler bindings for SDL2 (SDL_events.h)

#define SIZE_SDL_Event 56

#define OFFSET_SDL_Event_type 0

#define SDL_EVENT_QUIT 0x100

//! @fn int SDL_PollEvent(SDL_Event * event);
//! @param event the SDL_Event structure to be filled with the next event from the queue, or NULL.
//! @return 1 if there is a pending event, or 0 if there isn't.
.type SDL_PollEvent, @function
.extern SDL_PollEvent

#endif