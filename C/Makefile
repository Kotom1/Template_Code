CC=gcc
EXE=sftemplate
RSFPATH=../../src
CMLFLAGS=-I${RSFPATH}/build/include -std=c99 
LKFLAGS=-L${RSFPATH}/build/lib -lrsf
OBJ=template.o help.o

all: ${EXE}


${EXE}:${OBJ}
	${CC} $^ -o $@ ${LKFLAGS}

${OBJ}:%.o:%.c
	${CC} -c $^ ${CMLFLAGS}

.PHONY: clean
clean:
	rm ${EXE} ${OBJ}
