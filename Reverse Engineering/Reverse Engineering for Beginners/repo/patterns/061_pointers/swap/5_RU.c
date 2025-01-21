#include <memory.h>
#include <stdio.h>

void swap_bytes (unsigned char* first, unsigned char* second)
{
	unsigned char tmp1;
	unsigned char tmp2;

	tmp1=*first;
	tmp2=*second;

	*first=tmp2;
	*second=tmp1;
};

int main()
{
	// копируем строку в кучу, чтобы у нас была возможность эту самую строку модифицировать
	char *s=strdup("string"); 

	// \verb|меняем 2-й и 3-й символы|
	swap_bytes (s+1, s+2);

	printf ("%s\n", s);
};

