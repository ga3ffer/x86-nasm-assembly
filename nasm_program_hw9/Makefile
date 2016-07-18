
PROGRAM1=hw9_ex1
PROGRAM2=hw9_ex2
PROGRAM3=hw9_ex3
CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf

default: $(PROGRAM1) $(PROGRAM2) $(PROGRAM3)

$(PROGRAM1): $(PROGRAM1).o asm_io.o driver_ex1.o 
	$(CC) $(CFLAGS) $(PROGRAM1).o driver_ex1.o asm_io.o -o $(PROGRAM1)

$(PROGRAM1).o: $(PROGRAM1).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM1).asm -o $(PROGRAM1).o

$(PROGRAM2): $(PROGRAM2).o asm_io.o driver_ex2.o
	$(CC) $(CFLAGS) $(PROGRAM2).o driver_ex2.o asm_io.o -o $(PROGRAM2)

$(PROGRAM2).o: $(PROGRAM2).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM2).asm -o $(PROGRAM2).o

$(PROGRAM3): $(PROGRAM3).o asm_io.o driver_ex3.o
	$(CC) $(CFLAGS) $(PROGRAM3).o driver_ex3.o asm_io.o -o $(PROGRAM3)

$(PROGRAM3).o: $(PROGRAM3).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM3).asm -o $(PROGRAM3).o


asm_io.o: asm_io.asm
	$(ASM) $(ASMFLAGS) -d ELF_TYPE asm_io.asm -o asm_io.o

driver_ex1.o: driver_ex1.c
	$(CC) $(CFLAGS) -c driver_ex1.c -o driver_ex1.o

driver_ex2.o: driver_ex2.c
	$(CC) $(CFLAGS) -c driver_ex2.c -o driver_ex2.o

driver_ex3.o: driver_ex3.c
	$(CC) $(CFLAGS) -c driver_ex3.c -o driver_ex3.o
clean:
	/bin/rm -f *.o $(PROGRAM1) $(PROGRAM2) $(PROGRAM3)

