.SUFFIXES:
test: test.asm.o libgc.a
	ld -o $@ $^
libgc.a: gc.c4.o gc.asm.o
	ar rcs $@ $^
%.c4.o: %.c4
	c4 -c -o $@ $<
%.asm.o: %.asm
	nasm -f elf64 -o $@ $<
	
.PHONY: clean
clean:
	rm -f libgc.a *.o
