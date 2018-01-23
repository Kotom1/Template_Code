CC=gcc
CXX=g++

RSFPATH=../../src

CXXMLFLAGS=-I${RSFPATH}/build/include 
CMLFLAGS=-I${RSFPATH}/build/include -std=c99 

LKFLAGS=-L${RSFPATH}/build/lib -lrsf

EXE=sftemplate
CXXOBJ=template.cxo
COBJ=help.co

all: ${EXE}

${EXE}: ${COBJ} ${CXXOBJ}
	${CXX} $^ -o $@ ${LKFLAGS}

${CXXOBJ}:%.cxo:%.cc
	${CXX} -c $^ -o $@ ${CXXMLFLAGS}

${COBJ}:%.co:%.c
	${CC} -c $^ -o $@ ${CMLFLAGS}

.PHONY: clean
clean:
	rm ${EXE} ${COBJ} ${CXXOBJ}
