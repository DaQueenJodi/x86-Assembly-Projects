
NAME 	:= bin/main
SRC 	:= $(wildcard src/*.s)
OBJ 	:= ${SRC:.s=.o}

.PHONY: all clean



all: $(OBJ)
	ld $(OBJ) -g -o $(NAME)
$(OBJ): $(SRC)
	nasm  -g -f elf64 src/*.s -o $(OBJ)

.PHONY: clean
clean:
	rm src/*.o
