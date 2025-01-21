#include <stdio.h>

const char* month[]=
{
	"January", "February", "March", "April",
	"May", "June", "July", "August",
	"September", "October", "November", "December"
};

int main()
{
	// 4-й месяц, 5-й символ:
	printf ("%c\n", month[3][4]);
};

