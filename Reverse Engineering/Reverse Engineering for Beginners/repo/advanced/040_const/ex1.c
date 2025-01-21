const a=123;

void f(int *i)
{
	*i=11; // crash
};

int main()
{
	f(&a);
	return a;
};

