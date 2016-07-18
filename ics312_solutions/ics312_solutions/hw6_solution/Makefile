
PROGRAM1=hw6_ex1
PROGRAM2=hw6_ex2
PROGRAM3=hw6_ex3
PROGRAM4=hw6_ex4
CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf

default: $(PROGRAM1) $(PROGRAM2) $(PROGRAM3) $(PROGRAM4)

$(PROGRAM1): $(PROGRAM1).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM1).o driver.o asm_io.o -o $(PROGRAM1)

$(PROGRAM1).o: $(PROGRAM1).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM1).asm -o $(PROGRAM1).o

$(PROGRAM2): $(PROGRAM2).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM2).o driver.o asm_io.o -o $(PROGRAM2)

$(PROGRAM2).o: $(PROGRAM2).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM2).asm -o $(PROGRAM2).o

$(PROGRAM3): $(PROGRAM3).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM3).o driver.o asm_io.o -o $(PROGRAM3)

$(PROGRAM3).o: $(PROGRAM3).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM3).asm -o $(PROGRAM3).o

$(PROGRAM4): $(PROGRAM4).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM4).o driver.o asm_io.o -o $(PROGRAM4)

$(PROGRAM4).o: $(PROGRAM4).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM4).asm -o $(PROGRAM4).o

asm_io.o: asm_io.asm
	$(ASM) $(ASMFLAGS) -d ELF_TYPE asm_io.asm -o asm_io.o

driver.o: driver.c
	$(CC) $(CFLAGS) -c driver.c -o driver.o

clean:
	/bin/rm -f *.o $(PROGRAM1) $(PROGRAM2) $(PROGRAM3) $(PROGRAM4)

