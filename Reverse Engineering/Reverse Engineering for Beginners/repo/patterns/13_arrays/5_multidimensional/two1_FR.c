#include <stdio.h>

char a[3][4];

int main()
{
	int x, y;

	// effacer le tableau
	for (x=0; x<3; x++)
		for (y=0; y<4; y++)
			a[x][y]=0;

	// remplir la 2ème ligne avec 0..3
	for (y=0; y<4; y++)
		a[1][y]=y;
};
