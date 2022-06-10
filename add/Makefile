
NAME 	:= bin/main
SRC 	:= $(wildcard src/*.s)
OBJ 	:= ${SRC:.s=.o}

.PHONY: all clean



all: $(OBJ)
	ld $(OBJ) -g -o $(NAME)
$(OBJ): $(SRC)
	cp $(SRC) $(SRC).bak
	sed -i 's@//@;@' $(SRC).bak
	nasm  -g -f elf64 src/*.bak -o $(OBJ) 
test:
	bin/main
.PHONY: clean
clean:
	rm src/*.o
	rm src/*.bak
