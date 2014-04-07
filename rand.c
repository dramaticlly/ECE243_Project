#include <stdio.h>
#include <stdlib.h>

int random()
{
	int seed;
	seed = rand() % 26 + 1; // seed is in the range of 1 to 26 
	return seed;
}
