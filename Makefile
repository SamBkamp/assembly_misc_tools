file := fibonnaci.asm
target := elf64


build:${file}
	nasm -f ${target} -o test.o ${file}
	ld test.o -o a.out
	rm test.o
