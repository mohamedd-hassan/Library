#include <stdio.h>
#include <stdlib.h>

struct color
{
	int R;
	int G;
	int B;
};

struct color* create_color (int R, int G, int B)
{
	struct color* rt=(struct color*)malloc(sizeof(struct color));

	rt->R=R;
	rt->G=G;
	rt->B=B;
	// must be "return rt;" here
};

int main()
{
	struct color* a=create_color(1,2,3);
	printf ("%d %d %d\n", a->R, a->G, a->B);
};

