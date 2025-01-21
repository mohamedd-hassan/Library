#include <stdio.h>

void f(int *a1, int *a2, size_t cnt)
{
	size_t i;

	// copier d'un tableau a l'autre selon un schema bizarre
	for (i=0; i<cnt; i++)
		a1[i*3]=a2[i*7];
};
