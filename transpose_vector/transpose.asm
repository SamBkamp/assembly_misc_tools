section .text
global _start
extern print_vector

%include "../syscall_numbers.asm"

;;vector struct offsets
%define VECTOR_DATA_OFFSET 0
%define VECTOR_WIDTH_OFFSET 8
%define VECTOR_HEIGHT_OFFSET 9
%define VECTOR_STRUCT_SIZE 16   ;account for padding

_start:
        push rbp
        mov rbp, rsp

        sub rsp, VECTOR_STRUCT_SIZE
        mov byte [rbp+VECTOR_WIDTH_OFFSET], 2
        mov byte [rbp+VECTOR_HEIGHT_OFFSET], 2

        sub rsp, 8              ;make space for actual vector data
        mov [rbp+VECTOR_DATA_OFFSET], rsp ;bottom of stack is start of vector pointer

        mov al, 0              ;loop index & data value
fill_loop:
        mov byte [rsp+rax], al
        inc al
        cmp al, 4
        jl fill_loop

        mov rdi, rbp
        call print_vector

        pop rbp

        mov rax, SYSCALL_EXIT
        mov rdi, 0
        syscall
