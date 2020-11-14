%include "runtime.inc"

extern obj_add, obj_sub, obj_mul

global fn_0

section .text

fn_1:
  push rbp
  mov rbp, rsp
  push rax
  pop rcx
  push rax
  push rbx
  mov rax, rcx
  eval
  pop rbx
  pop rax
  push rcx
  pop rcx
  mov rdx, qword [rcx + obj.body + 0]
  cmp rdx, 0
  je .sw0c0
  cmp rdx, 1
  je .sw0c1
  jmp .sw0d
  .sw0c0:
  mov r12, OBJ_TYPE_DATA
  mov r13, 1
  call alloc
  push rdx
  mov rcx, qword [rsp + 0]
  mov qword [rcx + obj.body + 0], 0
  mov rcx, qword [rsp + 0]
  mov qword [rbp + -16], rcx
  add rsp, 0
  jmp .sw0end
  .sw0c1:
  mov r12, OBJ_TYPE_DATA
  mov r13, 1
  call alloc
  push rdx
  mov rcx, qword [rsp + 0]
  mov qword [rcx + obj.body + 0], 1
  mov rcx, qword [rsp + 0]
  mov qword [rbp + -16], rcx
  add rsp, 0
  jmp .sw0end
  .sw0d:
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  push obj_add
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  push qword [rbx + obj.body + 8]
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  push obj_sub
  push rax
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov r12, OBJ_TYPE_DATA
  mov r13, 1
  call alloc
  push rdx
  mov rcx, qword [rsp + 0]
  mov qword [rcx + obj.body + 0], 1
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  push qword [rbx + obj.body + 8]
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  push obj_sub
  push rax
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov r12, OBJ_TYPE_DATA
  mov r13, 1
  call alloc
  push rdx
  mov rcx, qword [rsp + 0]
  mov qword [rcx + obj.body + 0], 2
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  .sw0end:
  pop rcx
  pop rbp
  ret

fn_0:
  push rbp
  mov rbp, rsp
  mov r12, OBJ_TYPE_IND
  mov r13, 1
  call alloc
  push rdx
  mov r12, OBJ_TYPE_FUN
  mov r13, 2
  call alloc
  push rdx
  mov qword [rdx + obj.body + 0], fn_1
  push qword [rbp + -8]
  mov rcx, qword [rsp + 8]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 8
  mov rcx, qword [rbp + -8]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 0], rdx
  add rsp, 8
  mov r12, OBJ_TYPE_THUNK
  mov r13, 2
  call alloc
  push rdx
  push qword [rbp + -8]
  push rax
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 8]
  mov qword [rcx + obj.body + 0], rdx
  mov rcx, qword [rsp + 16]
  mov rdx, qword [rsp + 0]
  mov qword [rcx + obj.body + 8], rdx
  add rsp, 16
  mov rcx, qword [rsp + 0]
  mov qword [rbp + -8], rcx
  add rsp, 8
  pop rcx
  pop rbp
  ret
