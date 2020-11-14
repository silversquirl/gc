; CALLING CONVENTION
; rax: argument
; rbx: function object when calling functions
; rcx: return val
; rax - rdx, r8 are scratch registers

; eval takes an object, evaluates to WHNF, and returns the address of
; the object behind any indirections

; alloc does not follow calling convention; it takes a closure type in
; r12, a body size (in words) in r13, and returns in rdx. It does not
; clobber rax or rbx. It automatically fills the allocated object's
; header. The interface for this function is because for a bump-pointer
; allocator, most allocations are trivial so don't need the extra
; registers; as allocations are incredibly common, avoiding the extra
; push/pop ops is probably good.

; When alloc is called, only rax/rbx should contain pointers; the GC
; will check references in these registers and no others. If these
; registers are not pointers, they should be NULL.

%define OBJ_TYPE_FUN 0
%define OBJ_TYPE_DATA 1
%define OBJ_TYPE_THUNK 2
%define OBJ_TYPE_IND 3
%define OBJ_TYPE_GLOBL 4 ; global unevaluated objects
%define OBJ_TYPE_GLOBL_IND 5 ; distinct for GC reasons

%macro eval 0
  mov r8d, dword [rax + obj.type]
  call [eval_table + r8d*8]
%endmacro

struc obj
  .type: resd 1
  .size: resd 1
  .hdr_size:
  .body:
endstruc
