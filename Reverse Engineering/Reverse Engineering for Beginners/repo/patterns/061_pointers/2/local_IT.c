void main()
{
	int sum, product; // ora le veriabili sono locali nella funzione

	f1(123, 456, &sum, &product);
	printf ("sum=%d, product=%d\n", sum, product);
};
