void main()
{
	int sum, product; // теперь эти переменные для этой ф-ции --- локальные

	f1(123, 456, &sum, &product);
	printf ("sum=%d, product=%d\n", sum, product);
};
