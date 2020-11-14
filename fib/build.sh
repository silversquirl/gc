#!/bin/sh
for f in *.asm; do
	nasm -g -f elf64 "$f"
done
ld *.o ../libgc.a
