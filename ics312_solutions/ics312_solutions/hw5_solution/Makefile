
PROGRAM1=hw5_ex1
PROGRAM2=hw5_ex2
PROGRAM3=hw5_ex3
PROGRAM4=hw5_ex4

CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf

# List of programs to build: program #1, program #2, and program #3
default: $(PROGRAM1) $(PROGRAM2) $(PROGRAM3) $(PROGRAM4)

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

# linking program #3
$(PROGRAM3): $(PROGRAM3).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM3).o driver.o asm_io.o -o $(PROGRAM3)

# compiling program #3
$(PROGRAM3).o: $(PROGRAM3).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM3).asm -o $(PROGRAM3).o

# linking program #4
$(PROGRAM4): $(PROGRAM4).o driver.o asm_io.o
	$(CC) $(CFLAGS) $(PROGRAM4).o driver.o asm_io.o -o $(PROGRAM4)

# compiling program #4
$(PROGRAM4).o: $(PROGRAM4).asm
	$(ASM) $(ASMFLAGS) $(PROGRAM4).asm -o $(PROGRAM4).o

# compiling asm_io.asm
asm_io.o: asm_io.asm
	$(ASM) $(ASMFLAGS) -d ELF_TYPE asm_io.asm -o asm_io.o

# compiling driver.c
driver.o: driver.c
	$(CC) $(CFLAGS) -c driver.c -o driver.o

# removing all object files and executables
clean:
	/bin/rm -f *.o $(PROGRAM1) $(PROGRAM2) $(PROGRAM3) $(PROGRAM4)

