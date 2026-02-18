# DevNote 0000: x86-64 System V ABI (Linux)

This reference documents the System V AMD64 ABI used by Linux.

## 1. General Purpose Registers (GPR)

| Register | Role               | Preservation | Notes                                                |
| :------- | :----------------- | :----------- | :--------------------------------------------------- |
| `rax`    | Return Value (1st) | Caller       | Also used for syscall numbers.                       |
| `rbx`    | Base / General     | **Callee**   |                                                      |
| `rcx`    | Argument 4         | Caller       | Used by `loop` instructions.                         |
| `rdx`    | Argument 3         | Caller       | Return value (2nd) for 128-bit types.                |
| `rsi`    | Argument 2         | Caller       |                                                      |
| `rdi`    | Argument 1         | Caller       |                                                      |
| `rbp`    | Frame Pointer      | **Callee**   | Optional if using stack-pointer relative addressing. |
| `rsp`    | Stack Pointer      | **Callee**   | Must be preserved (balanced).                        |
| `r8`     | Argument 5         | Caller       |                                                      |
| `r9`     | Argument 6         | Caller       |                                                      |
| `r10`    | Temporary          | Caller       | Used as Arg 4 in **syscalls**.                       |
| `r11`    | Temporary          | Caller       | Clobbered by `syscall` instruction.                  |
| `r12`    | General            | **Callee**   |                                                      |
| `r13`    | General            | **Callee**   |                                                      |
| `r14`    | General            | **Callee**   |                                                      |
| `r15`    | General            | **Callee**   |                                                      |

## 2. Function Calling Convention

### Parameters
1.  **Integers & Pointers**: Passed in registers `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`.
2.  **Floating Point**: Passed in `xmm0` through `xmm7`.
3.  **Stack Arguments**: Additional arguments are pushed onto the stack in **reverse order** (right-to-left).

### Return Values
*   **Integers/Pointers**: `rax`.
*   **Floating Point**: `xmm0`.

### Stack Alignment
The stack pointer (`rsp`) must be **16-byte aligned** before making a `call`.
*   When a function is called, the return address is pushed, misaligning the stack by 8 bytes.
*   Prologue usually pushes `rbp` (another 8 bytes), re-aligning it to 16 bytes.

### The Red Zone
The 128 bytes below the stack pointer (`rsp - 128` to `rsp`) is reserved for the current function. Leaf functions (functions that call no other functions) can use this space without adjusting `rsp`.

## 3. Kernel System Calls

The convention for making syscalls differs slightly from function calls.

*   **Instruction**: `syscall`
*   **Syscall Number**: `rax`
*   **Return Value**: `rax` (Values between -4095 and -1 indicate error).
*   **Clobbered**: `rcx`, `r11` (and `rax` for return).

**Syscall Arguments:**

| Arg | Register  | Note                                     |
| :-- | :-------- | :--------------------------------------- |
| 1   | `rdi`     | Same as function call                    |
| 2   | `rsi`     | Same as function call                    |
| 3   | `rdx`     | Same as function call                    |
| 4   | **`r10`** | **Different** (Function calls use `rcx`) |
| 5   | `r8`      | Same as function call                    |
| 6   | `r9`      | Same as function call                    |