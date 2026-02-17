section .text
global _start

%include "syscall_numbers.asm"

%define num1_offset 0           ;base pointer offset for number 1 (2 byte value)
%define num2_offset 2           ;base pointer offset for number 2 (2 byte value)
_start:
        push rbp
        mov rbp, rsp
        sub rsp, 0x02

        call print_dec_number
        mov ax, 0
        
        mov dx, 0  ;init first fib numbers
        mov rbx, 0
        mov ax, 1
_loop:
        call print_dec_number
        mov cx, ax
        add ax, dx
        mov dx, cx

        inc rbx
        cmp rbx, 20
        jl _loop

_exit:
        add rsp, 2
        pop rbp
        mov rax, SYSCALL_EXIT
        mov rdi, 0
        syscall

;;                 ax
;;print_dec_number(uint16_t n)
print_dec_number:
        push rax
        push rcx
        push rdx
        push rbp
        mov rbp, rsp

;;start with a newline
        sub rsp, 1
        mov byte [rsp], 0x0a

_print_dec_number_loop:
        ;do the divide
        mov dx, 0
        mov cx, 10
        div cx

        ;dividened to our string
        sub rsp, 1              ;make space on stack
        add dx, 0x30
        mov byte [rsp], dl

        test ax, ax
        jnz _print_dec_number_loop

        ;string length is rsp minus rbp
        mov rsi, rbp
        sub rsi, rsp
        mov rax, rsp
        call print_string

        mov rsp, rbp
        pop rbp
        pop rdx
        pop rcx
        pop rax
        ret

;;             rax        rsi
;;print_string(char *buf, int length)
print_string:
        push rbp
        push rsi
        push rax
        push rdi

        mov rdx, rsi
        mov rsi, rax
        mov rax, SYSCALL_WRITE
        mov rdi, 2
        syscall

_print_string_exit:
        pop rdi
        pop rax
        pop rsi
        pop rbp
        ret

;;           dl
;;print_char(uint8_t char)
print_char:
        push rax
        push rdi
        push rsi
        push rdx

        mov rax, SYSCALL_WRITE
        mov rdi, 2
        mov rsi, rsp
        mov rdx, 2
        syscall

        pop rdx
        pop rsi
        pop rdi
        pop rax
        ret
