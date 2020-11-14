%include "runtime.inc"

section .data

global obj_add
obj_add:
  dd OBJ_TYPE_GLOBL
  dd 1
  dq mk_add

global obj_sub
obj_sub:
  dd OBJ_TYPE_GLOBL
  dd 1
  dq mk_sub

global obj_mul
obj_mul:
  dd OBJ_TYPE_GLOBL
  dd 1
  dq mk_mul

section .text

; Add {{{

mk_add:
  push rbp
  mov rbp, rsp

  mov r12, OBJ_TYPE_FUN
  mov r13, 1
  call alloc
  mov qword [rdx + obj.body + 0], fn_add0

  mov rcx, rdx
  pop rbp
  ret

fn_add0:
  push rbp
  mov rbp, rsp

  mov r12, OBJ_TYPE_FUN
  mov r13, 2
  call alloc
  mov qword [rdx + obj.body + 0], fn_add1
  mov qword [rdx + obj.body + 8], rax

  mov rcx, rdx
  pop rbp
  ret

fn_add1:
  push rbp
  mov rbp, rsp

  ; alloc constr, push to stack
  mov r12, OBJ_TYPE_DATA
  mov r13, 1
  call alloc
  push rdx

  mov rcx, qword [rbx + obj.body + 8]
  ; args in rcx, rax
  ; eval them
  push rbx
  push rcx
  eval
  pop rax
  push rcx
  eval
  pop rax
  pop rbx
  ; same way round!

  mov rdx, [rcx + obj.body + 0]
  mov rcx, [rax + obj.body + 0]
  ; values in rcx, rdx
  add rdx, rcx

  ; set the value
  pop rcx
  mov qword [rcx + obj.body + 0], rdx

  pop rbp
  ret

; }}}

; Sub {{{

mk_sub:
  push rbp
  mov rbp, rsp

  mov r12, OBJ_TYPE_FUN
  mov r13, 1
  call alloc
  mov qword [rdx + obj.body + 0], fn_sub0

  mov rcx, rdx
  pop rbp
  ret

fn_sub0:
  push rbp
  mov rbp, rsp

  mov r12, OBJ_TYPE_FUN
  mov r13, 2
  call alloc
  mov qword [rdx + obj.body + 0], fn_sub1
  mov qword [rdx + obj.body + 8], rax

  mov rcx, rdx
  pop rbp
  ret

fn_sub1:
  push rbp
  mov rbp, rsp

  ; alloc constr, push to stack
  mov r12, OBJ_TYPE_DATA
  mov r13, 1
  call alloc
  push rdx

  mov rcx, qword [rbx + obj.body + 8]
  ; args in rcx, rax
  ; eval them
  push rbx
  push rcx
  eval
  pop rax
  push rcx
  eval
  pop rax
  pop rbx
  ; same way round!
  mov rdx, [rcx + obj.body + 0]
  mov rcx, [rax + obj.body + 0]
  ; values in rcx, rdx
  sub rdx, rcx

  ; set the value
  pop rcx
  mov qword [rcx + obj.body + 0], rdx

  pop rbp
  ret

; }}}

; Mul {{{

mk_mul:
  push rbp
  mov rbp, rsp

  mov r12, OBJ_TYPE_FUN
  mov r13, 1
  call alloc
  mov qword [rdx + obj.body + 0], fn_mul0

  mov rcx, rdx
  pop rbp
  ret

fn_mul0:
  push rbp
  mov rbp, rsp

  mov r12, OBJ_TYPE_FUN
  mov r13, 2
  call alloc
  mov qword [rdx + obj.body + 0], fn_mul1
  mov qword [rdx + obj.body + 8], rax

  mov rcx, rdx
  pop rbp
  ret

fn_mul1:
  push rbp
  mov rbp, rsp

  ; alloc constr, push to stack
  mov r12, OBJ_TYPE_DATA
  mov r13, 1
  call alloc
  mov dword [rdx + obj.type], OBJ_TYPE_DATA
  mov dword [rdx + obj.size], 1
  push rdx

  mov rcx, qword [rbx + obj.body + 8]
  ; args in rcx, rax
  ; eval them
  push rbx
  push rcx
  eval
  pop rax
  push rcx
  eval
  pop rax
  pop rbx
  ; same way round!
  mov rdx, [rcx + obj.body + 0]
  mov rcx, [rax + obj.body + 0]
  ; values in rcx, rdx
  ; mul is dumb
  push rax
  mov rax, rdx
  mul rcx
  mov rdx, rax
  pop rax

  ; set the value
  pop rcx
  mov qword [rcx + obj.body + 0], rdx

  pop rbp
  ret


; }}}
