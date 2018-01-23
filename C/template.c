#include <stdio.h>

/* Using the head file of madagascar for standard input and ouput */
#include <rsf.h>

#include "help.h"

int main(int argc, char **argv)
{
	if (argc == 1) {
	  help();
	}

	sf_file vel_in, vel_out;
	float ratio;
	float **vel;
	int nx, nz;
	float dz;

	sf_init (argc, argv);


	vel_in = sf_input("in");
	vel_out = sf_output("out");

	if(!sf_getfloat("ratio",&ratio)) sf_error("ratio is needed!");
	
	if(!sf_histint(vel_in,"n1",&nz)) sf_error("Input file error: n1= is not found!");
	if(!sf_histint(vel_in,"n2",&nx)) sf_error("Input file error: n2= is not found!");
	if(!sf_histfloat(vel_in,"d1",&dz)) sf_error("Input file error: d1= is not found!");

	vel = sf_floatalloc2(nz,nx);

	sf_floatread(vel[0],nz*nx,vel_in);

	for (int ix=0; ix<nx; ix++)
	  for (int iz=0; iz<nz; iz++)
	    vel[ix][iz] *= ratio*iz*dz;

	sf_floatwrite(vel[0],nz*nx,vel_out);

	free(*vel); free(vel);

	exit(0);
}
