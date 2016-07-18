PROGRAM=hw7_ex3
CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf

default: $(PROGRAM) run

run: $(PROGRAM)
	@./$(PROGRAM)

$(PROGRAM): $(PROGRAM).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM).o driver.o asm_io.o -o $(PROGRAM)

$(PROGRAM).o: $(PROGRAM).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM).asm -o $(PROGRAM).o

asm_io.o: asm_io.asm
	$(ASM) $(ASMFLAGS) -d ELF_TYPE asm_io.asm -o asm_io.o

driver.o: driver.c
	$(CC) $(CFLAGS) -c driver.c -o driver.o

clean:
	/bin/rm -f *.o $(PROGRAM)

