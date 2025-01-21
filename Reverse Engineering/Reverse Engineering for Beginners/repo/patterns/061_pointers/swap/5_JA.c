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
	// 文字列をヒープにコピーするので、変更することができます
	char *s=strdup("string"); 

	// 2番目と3番目の文字をスワップする
	swap_bytes (s+1, s+2);

	printf ("%s\n", s);
};

