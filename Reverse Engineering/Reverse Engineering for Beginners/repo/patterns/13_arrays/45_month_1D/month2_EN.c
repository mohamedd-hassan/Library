#include <stdio.h>

const char* month[]=
{
	"January", "February", "March", "April",
	"May", "June", "July", "August",
	"September", "October", "November", "December"
};

int main()
{
	// 4th month, 5th character:
	printf ("%c\n", month[3][4]);
};

