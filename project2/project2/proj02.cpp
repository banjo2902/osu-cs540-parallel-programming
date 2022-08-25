#include <stdio.h>
#include <omp.h>
#include <math.h>

using namespace std;


#ifndef NUMT
#define NUMT 2
#endif

#ifndef NUMNODES
#define NUMNODES 4
#endif


// The code to evaluate the height at a given <i>iu</i> and <i>iv</i> is:

const float N = 2.5f;
const float R = 1.2f;



float
Height( int iu, int iv )	// iu,iv = 0 .. NUMNODES-1
{
	float x = -1.  +  2.*(float)iu /(float)(NUMNODES-1);	// -1. to +1.
	float y = -1.  +  2.*(float)iv /(float)(NUMNODES-1);	// -1. to +1.

	float xn = pow( fabs(x), (double)N );
	float yn = pow( fabs(y), (double)N );
	float rn = pow( fabs(R), (double)N );
	float r = rn - xn - yn;
	if( r <= 0. )
	        return 0.;
	float height = pow( r, 1./(double)N );
	return height;
}


// The main Program

#define XMIN     -1.
#define XMAX      1.
#define YMIN     -1.
#define YMAX      1.

float Height( int, int );	// function prototype

int main( int argc, char *argv[ ] )
{
	#ifndef _OPENMP
        printf("No OpenMP support!\n" );
        return 1;
	#endif

	omp_set_num_threads( NUMT );

	// the area of a single full-sized tile:
	// (not all tiles are full-sized, though)

	float fullTileArea = (  ( ( XMAX - XMIN )/(float)(NUMNODES-1) )  *
				( ( YMAX - YMIN )/(float)(NUMNODES-1) )  );

	// sum up the weighted heights into the variable "volume"
	// using an OpenMP for-loop and a reduction:

	float volume = 0;

	double time1 = omp_get_wtime( );

	#pragma omp parallel for collapse(2) default(none) shared(fullTileArea) reduction(+:volume)
	for( int iv = 0; iv < NUMNODES; iv++ )
	{
		for( int iu = 0; iu < NUMNODES; iu++ )
		{
			float z = Height( iu, iv );

			if((iu == 0 || iu == NUMNODES - 1) || (iv == 0 || iv == NUMNODES - 1))
			{
				if((iu == 0 || iu == NUMNODES - 1) && (iv == 0 || iv == NUMNODES - 1))
					volume += fullTileArea / 4. * z;

				else
					volume += fullTileArea / 2. * z;
			}

			else
				volume += fullTileArea * z;
		}
	}

	double time2 = omp_get_wtime( );

	//printf("Threads: %2d ; Nodes on each side edge: %4d ; Volume: %.4f ; Mega heights / sec: %6.3lf\n", NUMT, NUMNODES, volume, (double)(NUMNODES * NUMNODES) / (time2 - time1) / 1000000.);
    printf("%2d, %4d, %.4f, %6.3lf\n", NUMT, NUMNODES, volume, (double)(NUMNODES * NUMNODES) / (time2 - time1) / 1000000.);
}
