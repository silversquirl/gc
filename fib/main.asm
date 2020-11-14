%include "runtime.inc"

section .data

digits: db '0123456789'

intobj:
  dd OBJ_TYPE_DATA
  dd 1
  .intval: dq 0

section .bss

strbuf: resb 32

section .text

extern fn_0

global _start
_start:
  ; check argc == 2
  cmp qword [rsp], 2
  jne .err

  ; get second arg
  mov rsi, [rsp + 16]

  ; parse as number
  xor rax, rax

  .parse:
    xor rbx, rbx
    mov bl, [rsi]
    test rbx, rbx
    jz .parse_done
    sub rbx, 48
    cmp rbx, 10
    jae .err

    mov rcx, 10
    mul rcx

    add rax, rbx

    inc rsi

    jmp .parse
  .parse_done:

  ; rax is now parsed value

  mov [intobj.intval], rax

  ; and now it's the arg object
  mov rax, intobj

  ; init base ptr to zero to indicate first stack frame
  xor rbp, rbp
  ; zero fn object - ensures segfault if referenced
  xor rbx, rbx
  ; call code!
  call fn_0
  ; rcx = return val
  ; make sure it's evaluated
  mov rax, rcx
  eval
  ; rcx is now the evaluated object and not an indirection
  ; fetch value
  mov rax, [rcx + obj.body + 0]

  ; convert to string
  mov rdi, strbuf

  lea r9, digits

  mov r10, 10

  mov r11, 0

  .next_char:
    xor rdx, rdx
    div r10

    mov r8, [r9 + rdx]
    mov [rdi], r8

    inc r11
    inc rdi
    test rax, rax
  jnz .next_char

  mov byte [rdi], 0xa

  dec rdi
  mov rcx, strbuf

  .reverse:
    mov dl, [rdi]
    xchg dl, [rcx]
    mov [rdi], dl
    dec rdi
    inc rcx
    cmp rcx, rdi
  jb .reverse

  mov rdx, r11
  inc rdx

  mov rsi, strbuf
  ; rdx = output length
  ; rsi = output buf

  ; print
  mov rax, 1
  mov rdi, 1
  syscall
  ; exit
  mov rax, 60
  xor rdi, rdi
  syscall

.err:
  ; exit with code 1
  mov rax, 60
  mov rdi, 1
  syscall
