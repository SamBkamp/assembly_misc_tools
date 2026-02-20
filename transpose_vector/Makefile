C_SRC := print_vec.c
ASM_SRC := transpose.asm
LINK_LIBC := -lc
NO_EXEC_STACK := -z noexecstack
OUTPUT_FILE := transpose

transpose:transpose.o print_vec.o
	ld $^ ${LINK_LIBC} ${NO_EXEC_STACK} -no-pie -o ${OUTPUT_FILE}

print_vec.o:print_vec.c
	gcc -c ${C_SRC} -fno-pie -no-pie

transpose.o:transpose.asm
	nasm -f elf64 transpose.asm
