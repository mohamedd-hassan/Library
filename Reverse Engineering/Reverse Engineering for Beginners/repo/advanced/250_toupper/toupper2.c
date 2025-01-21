char toupper (char c)
{
	if(c>='a' && c<='z')
		return c^0x20;
	else
		return c;
}

