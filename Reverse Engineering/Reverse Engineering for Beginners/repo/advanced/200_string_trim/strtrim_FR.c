#include <stdio.h>
#include <string.h>

char* str_trim (char *s)
{
	char c;
	size_t str_len;

        // \verb|fonctionne tant que \r ou \n se trouve en fin de la chaîne|
        // s'arrête si un autre caractère s'y trouve ou si la chaîne est vide
        // (au début ou au cours de notre opération)
	for (str_len=strlen(s); str_len>0 && (c=s[str_len-1]); str_len--)
	{
		if (c=='\r' || c=='\n')
			s[str_len-1]=0;
		else
			break;
	};
	return s;
};

int main()
{
	// test

        // strdup() est utilisé pour copier du texte de chaîne dans le segment de données,
        // car autrement ça va crasher sur Linux,
        // où les chaîne de texte sont allouées dans le segment de données constantes,
        // et n'est pas modifiable.

	printf ("[%s]\n", str_trim (strdup("")));
	printf ("[%s]\n", str_trim (strdup("\n")));
	printf ("[%s]\n", str_trim (strdup("\r")));
	printf ("[%s]\n", str_trim (strdup("\n\r")));
	printf ("[%s]\n", str_trim (strdup("\r\n")));
	printf ("[%s]\n", str_trim (strdup("test1\r\n")));
	printf ("[%s]\n", str_trim (strdup("test2\n\r")));
	printf ("[%s]\n", str_trim (strdup("test3\n\r\n\r")));
	printf ("[%s]\n", str_trim (strdup("test4\n")));
	printf ("[%s]\n", str_trim (strdup("test5\r")));
	printf ("[%s]\n", str_trim (strdup("test6\r\r\r")));
};
