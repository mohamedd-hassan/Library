#include <stdlib.h>
#include <stdio.h>

int check_protection()
{
	// do something
	return 0;
	// or return 1;
};

int main()
{
	if (check_protection()==0)
	{
		printf ("no protection installed\n");
		exit(0);
	};

	// ...and then, at some very important point...
	if (*(((unsigned char*)check_protection)+0) != 0x55)
	{
		printf ("1st byte has been altered\n");
		// do something mean, add watermark, etc
	};
	if (*(((unsigned char*)check_protection)+1) != 0x89)
	{
		printf ("2nd byte has been altered\n");
		// do something mean, add watermark, etc
	};
	if (*(((unsigned char*)check_protection)+2) != 0xe5)
	{
		printf ("3rd byte has been altered\n");
		// do something mean, add watermark, etc
	};
};

