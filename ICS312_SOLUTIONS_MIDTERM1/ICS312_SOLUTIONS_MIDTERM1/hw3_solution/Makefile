
PROGRAM1=hw3_ex1
PROGRAM2=hw3_ex2

CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf

# List of programs to build: program #1 and program #2
default: $(PROGRAM1) $(PROGRAM2)

# linking program #1
$(PROGRAM1): $(PROGRAM1).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM1).o driver.o asm_io.o -o $(PROGRAM1)

# compiling program #1
$(PROGRAM1).o: $(PROGRAM1).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM1).asm -o $(PROGRAM1).o

# linking program #2
$(PROGRAM2): $(PROGRAM2).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM2).o driver.o asm_io.o -o $(PROGRAM2)

# compiling program #2
$(PROGRAM2).o: $(PROGRAM2).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM2).asm -o $(PROGRAM2).o

# compiling asm_io.asm
asm_io.o: asm_io.asm
	$(ASM) $(ASMFLAGS) -d ELF_TYPE asm_io.asm -o asm_io.o

# compiling driver.c
driver.o: driver.c
	$(CC) $(CFLAGS) -c driver.c -o driver.o

# removing all object files and executables
clean:
	/bin/rm -f *.o $(PROGRAM1) $(PROGRAM2)

