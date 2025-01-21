#include <stdio.h>

char flip (char c)
{
	if((c>='a' && c<='z') || (c>='A' && c<='Z'))
		return c^0x20;
	else
		return c;
}

int main()
{
	// affichera "hELLO, WORLD!"
	for (char *s="Hello, world!"; *s; s++)
		printf ("%c", flip(*s));
};

