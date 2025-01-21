#include <stdio.h>

void printer(struct test *t)
{
	printf ("%d\n", t->field1);
	printf ("%d\n", t->field2);
};

