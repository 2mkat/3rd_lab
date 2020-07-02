build: main.c factor.o
	gcc -m32 main.c factor.o -o factor -g

factor.o: factor.s
	nasm -g -f elf -o factor.o factor.s
