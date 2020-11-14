section .text
extern gc.alloc_
global gc.alloc
gc.alloc:
	lea rdx, [rsp-8] ; Pass stack pointer as 3rd arg (-8 so we point to the base pointer)
	jmp gc.alloc_ ; Tail call

extern gc.gc_
global gc.gc
gc.gc:
	lea rdi, [rsp-8] ; Pass stack pointer as 1st arg (-8 so we point to the base pointer)
	jmp gc.gc_ ; Tail call

global sys.brk
sys.brk:
	mov rax, 12 ; SYS_BRK
	syscall
	ret

global sys.write
sys.write:
	mov rax, 1 ; SYS_WRITE
	syscall
	ret

global sys.abort
sys.abort:
	mov rax, 39 ; SYS_GETPID
	syscall
	mov rdi, rax
	mov rsi, 6  ; SIGABRT
	mov rax, 62 ; SYS_KILL
	syscall
	ret
