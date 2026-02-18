.set _FUNCTION_IS_IN_FUNCTION_DEFINITION, 0
.set _FUNCTION_LOCALS_ALLOCATED, 0

.macro _function_local_variable scope, name, size
  .if _FUNCTION_IS_IN_FUNCTION_DEFINITION == 0
    .error "Cannot define a local variable outside of a function."
  .else
    .set _FRAME_OFFSET, _FRAME_OFFSET + \size
    .equ \scope\()_name, -_FRAME_OFFSET
  .endif
.endm

.macro _function_allocate_local_variables scope
  .if _FUNCTION_IS_IN_FUNCTION_DEFINITION == 0
    .error "Cannot allocate local variables outside of a function."
  .elseif _FUNCTION_LOCALS_ALLOCATED == 1
    .error "Local variables have already been allocated."
  .else
    .set _FUNCTION_LOCALS_ALLOCATED, 1
    .equ \scope\()_FRAME_SIZE, (_FRAME_OFFSET + 15) & -16
    .if \scope\()_FRAME_SIZE > 0
      sub $\scope\()_FRAME_SIZE, %rsp
    .endif
  .endif
.endm

.macro _function_load_local scope, name, register
  .if _FUNCTION_IS_IN_FUNCTION_DEFINITION == 0
    .error "Cannot load a local variable outside of a function."
  .elseif _FUNCTION_LOCALS_ALLOCATED == 0
    .error "Local variables have not been allocated."
  .else
    mov \scope\()_name(%rbp), \register
  .endif
.endm

.macro _function_store_local scope, register, name
  .if _FUNCTION_IS_IN_FUNCTION_DEFINITION == 0
    .error "Cannot store a local variable outside of a function."
  .elseif _FUNCTION_LOCALS_ALLOCATED == 0
    .error "Local variables have not been allocated."
  .else
    mov \register, \scope\()_name(%rbp)
  .endif
.endm

.macro function_begin name
  .if _FUNCTION_IS_IN_FUNCTION_DEFINITION == 1
    .error "Cannot define a function inside of another function."
  .endif

  .set _FUNCTION_IS_IN_FUNCTION_DEFINITION, 1
  .set _FUNCTION_LOCALS_ALLOCATED, 0

  .macro define_local var_name, var_size
    _function_local_variable \name, \var_name, \var_size
  .endm

  .macro allocate_locals
    _function_allocate_local_variables \name
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
    .if _FRAME_OFFSET > 0
      .if _FUNCTION_LOCALS_ALLOCATED == 0
        .error "Local variables were never been allocated."
      .endif
    .endif

    .Lexit_\name:
      leave
      .cfi_def_cfa %rsp, 8
      ret
      .cfi_endproc
      .size \name, .-\name
      .set _FUNCTION_IS_IN_FUNCTION_DEFINITION, 0
      .set _FUNCTION_LOCALS_ALLOCATED, 0
      .purgem allocate_locals
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
    .set _FRAME_OFFSET, 0
.endm
