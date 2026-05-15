#ifndef SNAKE_HELPERS_FUNCTION_S
#define SNAKE_HELPERS_FUNCTION_S
#ifndef __STDC_VERSION__

.set .L_FUNCTION_IS_IN_FUNCTION_DEFINITION, 0
.set .L_FUNCTION_LOCALS_ALLOCATED, 0

.macro _function_require_function
  .if .L_FUNCTION_IS_IN_FUNCTION_DEFINITION == 0
    .error "No active function definition."
  .endif
.endm

.macro _function_require_no_function
  .if .L_FUNCTION_IS_IN_FUNCTION_DEFINITION == 1
    .error "A function is already being defined."
  .endif
.endm

.macro _function_require_locals
  _function_require_function
  .if .L_FUNCTION_LOCALS_ALLOCATED == 0
    .error "Local variables have not been allocated."
  .endif
.endm

.macro _function_require_no_locals
  _function_require_function
  .if .L_FUNCTION_LOCALS_ALLOCATED == 1
    .error "Local variables have already been allocated."
  .endif
.endm

.macro _function_local_variable scope, name, size
  _function_require_function
  .set .L\scope\()_FRAME_OFFSET, .L\scope\()_FRAME_OFFSET + \size
  .equ .L\scope\()_\name\(), -.L\scope\()_FRAME_OFFSET
.endm

.macro _function_allocate_local_variables scope
  _function_require_no_locals
  .set .L_FUNCTION_LOCALS_ALLOCATED, 1
  .equ .L\scope\()_FRAME_SIZE, (.L\scope\()_FRAME_OFFSET + 15) & -16
  .if .L\scope\()_FRAME_SIZE > 0
    sub $.L\scope\()_FRAME_SIZE, %rsp
  .endif
.endm

.macro _function_load_local scope, name, register
  _function_require_locals
  mov .L\scope\()_\name\()(%rbp), \register
.endm

.macro _function_store_local scope, register, name
  _function_require_locals
  mov \register, .L\scope\()_\name\()(%rbp)
.endm

.macro _function_address_of_local scope, name, register
  _function_require_locals
  lea .L\scope\()_\name\()(%rbp), \register
.endm



.macro function_begin name
  _function_require_no_function

  .set .L_FUNCTION_IS_IN_FUNCTION_DEFINITION, 1
  .set .L_FUNCTION_LOCALS_ALLOCATED, 0

  .macro define_local var_name, var_size
    _function_local_variable \name, \var_name, \var_size
  .endm

  .macro allocate_locals
    _function_allocate_local_variables \name
  .endm

  .macro address_of_local var_name, register
    _function_address_of_local \name, \var_name, \register
  .endm

  .macro load_local var_name, register
    _function_load_local \name, \var_name, \register
  .endm

  .macro store_local register, var_name
    _function_store_local \name, \register, \var_name
  .endm

  .macro function_exit
    jmp .Lexit_\name
  .endm

  .macro function_end
    .if .L\name\()_FRAME_OFFSET > 0
      _function_require_locals
    .endif

    .Lexit_\name:
      leave
      .cfi_def_cfa %rsp, 8
      ret
      .cfi_endproc
      .size \name, .-\name
      .set .L_FUNCTION_IS_IN_FUNCTION_DEFINITION, 0
      .set .L_FUNCTION_LOCALS_ALLOCATED, 0
      .purgem allocate_locals
      .purgem address_of_local
      .purgem function_end
      .purgem function_exit
      .purgem load_local
      .purgem define_local
      .purgem store_local
  .endm

  .globl \name
  .type \name, @function
  \name:
    .cfi_startproc
    push %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    mov %rsp, %rbp
    .cfi_def_cfa_register %rbp
    .set .L\name\()_FRAME_OFFSET, 0
.endm

#endif
#endif
