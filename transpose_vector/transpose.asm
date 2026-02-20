section .text
global _start
extern printf

%include "../syscall_numbers.asm"

_start:
        push rbp                ;also kinda for 16 byte alignment
        mov rax, 0x0a4141
        push rax
        mov rdi, rsp
        mov eax, 0              ;zero al, no vec reg used
        call printf


        mov rax, SYSCALL_EXIT
        mov rdi, 0
        syscall
