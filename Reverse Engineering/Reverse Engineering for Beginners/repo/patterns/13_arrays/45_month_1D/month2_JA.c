#include <stdio.h>

const char* month[]=
{
	"January", "February", "March", "April",
	"May", "June", "July", "August",
	"September", "October", "November", "December"
};

int main()
{
	// 4番目の月、5番目のcharacter
	printf ("%c\n", month[3][4]);
};

