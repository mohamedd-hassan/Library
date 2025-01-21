#include <stdio.h>

const char* month[]=
{
	"janvier", "fevrier", "mars", "avril",
	"mai", "juin", "juillet", "aout",
	"septembre", "octobre", "novembre", "decembre"
};

int main()
{
	// 4ème mois, 5ème caractère:
	printf ("%c\n", month[3][4]);
};

