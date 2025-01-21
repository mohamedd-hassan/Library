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
	int fill_brush_type; // 0 - не заливать круг
};

void draw_circle(struct ver3 *s) // здесь используется самая последняя версия структуры
{
	// мы полагаем что в SizeOfStruct всегда присутствуют поля coord\_X и coord\_Y
	printf ("Собираемся рисовать круг на %d:%d\n", s->coord_X, s->coord_Y);

	if (s->SizeOfStruct>=sizeof(int)*5)
	{
		// это минимум ver2, поле цвета присутствует
		printf ("Собираемся установить цвет %d\n", s->color);
	}

	if (s->SizeOfStruct>=sizeof(int)*6)
	{
		// это минимум ver3, присутствует поле с типом заливки
		printf ("Мы собираемся залить его используя тип заливки %d\n", s->fill_brush_type);
	}
};

// раннее ПО
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

// следующая версия
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

// самая поздняя, наиболее расширенная версия
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
