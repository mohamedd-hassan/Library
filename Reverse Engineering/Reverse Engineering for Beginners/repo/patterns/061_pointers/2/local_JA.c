void main()
{
	int sum, product; // 変数は関数ローカルにあります

	f1(123, 456, &sum, &product);
	printf ("sum=%d, product=%d\n", sum, product);
};
