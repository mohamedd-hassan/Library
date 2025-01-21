#include <stdio.h>

struct ver1
{
	size_t SizeOfStruct;
	int coord_X;
	int coord_Y;
	int radius;
};

struct ver2
{
	size_t SizeOfStruct;
	int coord_X;
	int coord_Y;
	int radius;
	int color;
};

struct ver3
{
	size_t SizeOfStruct;
	int coord_X;
	int coord_Y;
	int radius;
	int color;
	int fill_brush_type; // 0 - do not fill circle
};

void draw_circle(struct ver3 *s) // latest struct version is used here
{
	// \verb|we presume SizeOfStruct, coord_X and coord_Y fields are always present|
	printf ("We are going to draw a circle at %d:%d\n", s->coord_X, s->coord_Y);

	if (s->SizeOfStruct>=sizeof(int)*5)
	{
		// this is at least ver2, color field is present
		printf ("We are going to set color %d\n", s->color);
	}

	if (s->SizeOfStruct>=sizeof(int)*6)
	{
		// \verb|this is at least ver3, fill_brush_type field is present|
		printf ("We are going to fill it using brush type %d\n", s->fill_brush_type);
	}
};

// early software version
void call_as_ver1()
{
	struct ver1 s;
	s.SizeOfStruct=sizeof(s);
	s.coord_X=123;
	s.coord_Y=456;
	s.radius=10;
	printf ("** %s()\n", __FUNCTION__);
	draw_circle(&s);
};

// next software version
void call_as_ver2()
{
	struct ver2 s;
	s.SizeOfStruct=sizeof(s);
	s.coord_X=123;
	s.coord_Y=456;
	s.radius=10;
	s.color=1;
	printf ("** %s()\n", __FUNCTION__);
	draw_circle(&s);
};

// latest, the most extended version
void call_as_ver3()
{
	struct ver3 s;
	s.SizeOfStruct=sizeof(s);
	s.coord_X=123;
	s.coord_Y=456;
	s.radius=10;
	s.color=1;
	s.fill_brush_type=3;
	printf ("** %s()\n", __FUNCTION__);
	draw_circle(&s);
};

int main()
{
	call_as_ver1();
	call_as_ver2();
	call_as_ver3();
};
