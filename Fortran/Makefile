#
#  Copyright (C) 2010 Center for Subsurface Imaging and Fluid Modeling (CSIM),
#  King Abdullah University of Science and Technology, All rights reserved.
#
#  Sponsors of CSIM are granted a non-exclusive, irrevocable royalty free
#  world-wide license to use this software and associated documentation files
#  (the "Software"), in their business, including the rights to modify and
#  distribute the Software to their affiliates, partners, clients or consultants
#  as necessary in the conduct of the sponsors business, all without accounting
#  to the King Abdullah University of Science and Technology, subject to the
#  following conditions:
#
#  The above copyright notice and this permission notice shall be included
#  in all copies or substantial portions of the Software.
#
#  Warranty Disclaimer:
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#  DEALINGS IN THE SOFTWARE.
#

#
#  file:     Makefile
#  version:  1.0
#  author:   Chaiwoot Boonyasiriwat
#  email:    chaiwoot@kaust.edu.sa
#  date:     March 6, 2010
#  purpose:  for compiling source codes
#
FFTROOT= /home/daiwe/utilities/fftw-3.3.1
INCLUDE = $(FFTROOT)/include
LIB = $(FFTROOT)/lib
DIR_OBJ=.obj
DIR_MOD=.mod
FCC = mpif90
F90FLAGS =-O3 -w -c -funroll-loops -J$(DIR_MOD)
LDFLAGS  =-O3 -w
#F90FLAGS =-O4 -c -lm -openmp -fpp
#LDFLAGS  =-O4 -lm -openmp -fpp
#F90FLAGS =-O4 -c -lm -fpp
#LDFLAGS  =-O4 -lm -fpp


OBJS = $(DIR_OBJ)/parser.o    \
       $(DIR_OBJ)/tydef.o    \
       $(DIR_OBJ)/global.o    \
       $(DIR_OBJ)/mmi_mpi.o    \
       $(DIR_OBJ)/string.o    \
       $(DIR_OBJ)/io.o           \

all: dir template

dir:
	@-test -d $(DIR_MOD) || mkdir $(DIR_MOD)
	@-test -d $(DIR_OBJ) || mkdir $(DIR_OBJ)

$(DIR_OBJ)/%.o: %.f90
	$(FCC) -o $@ $< $(F90FLAGS)

template: $(OBJS) $(DIR_OBJ)/template.o
	$(FCC) -o $@ $^ $(LDFLAGS)

clean:
	rm -f *~ *.o  template *.mod core $(DIR_OBJ)/*.o $(DIR_MOD)/*.mod;

