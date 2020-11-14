%include "common.inc"

section .data

global eval_table
eval_table:
  dq eval_fun    ; OBJ_TYPE_FUN
  dq eval_data   ; OBJ_TYPE_DATA
  dq eval_thunk  ; OBJ_TYPE_THUNK
  dq eval_ind    ; OBJ_TYPE_IND
  dq eval_globl  ; OBJ_TYPE_GLOBL
  dq eval_ind    ; OBJ_TYPE_GLOBL_IND

section .text

; eval code for indirections
global eval_ind
eval_ind:
  ; get the object being pointed to
  mov rcx, [rax + obj.body + 0]
  mov rax, rcx

  ; enter the pointed-to object
  ; note tail-call-opt type thing; only thing on stack is return addr,
  ; so no need to call and then return, we can just jump straight to
  ; eval
  mov r8d, dword [rax + obj.type]
  jmp [eval_table + r8*8]

; eval code for globals
global eval_globl
eval_globl:
  push rbp
  mov rbp, rsp

  push rax
  call [rax + obj.body + 0]
  pop rax

  ; rcx contains resulting object - create indirection
  mov dword [rax + obj.type], OBJ_TYPE_GLOBL_IND
  mov qword [rax + obj.body + 0], rcx

  pop rbp
  ret

; eval code for thunks
global eval_thunk
eval_thunk:
  push rbp
  mov rbp, rsp

  ; get the function
  mov rbx, [rax + obj.body + 0]

  ; make sure the function is evaluated
  push rax
  mov rax, rbx
  mov r8d, dword [rax + obj.type]
  eval
  pop rax

  ; rcx now contains the "real" function pointer

  mov rbx, rcx

  ; get the argument
  mov rcx, [rax + obj.body + 8]

  push rax

  ; run the function
  mov rax, rcx
  call [rbx + obj.body + 0] ; function entry code
  ; rcx now contains return val
  ; first, eval it in case the function returned another thunk
  mov rax, rcx
  eval
  ; rcx now contains evaluated return val

  pop rax


  ; replace the object with an indirection
  mov dword [rax + obj.type], OBJ_TYPE_IND
  mov [rax + obj.body + 0], rcx

  ; real object ptr already in rcx

  pop rbp
  ret

; eval code for data constructors and functions
global eval_data
global eval_fun
eval_data:
eval_fun:
  ; already evaluated; nothing to do
  mov rcx, rax
  ret

extern gc.alloc
extern obj_add
extern obj_sub
extern obj_mul

; XXX temporary alloc wrapper
; see common.inc for an explanation of some stuff here
global alloc
alloc:
  push rbp
  mov rbp, rsp

  push obj_add ; Push gobals
  push obj_sub
  push obj_mul
  
  push rax ; Push possible pointers for GC
  push rbx

  mov rdi, r12 ; Move arguments to match sysv
  mov rsi, r13
  call gc.alloc
  mov rdx, rax ; Move return value from sysv

  pop rbx
  pop rax
  leave  
  ret
