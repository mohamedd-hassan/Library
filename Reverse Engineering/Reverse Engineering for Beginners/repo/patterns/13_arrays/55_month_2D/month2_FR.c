#include <stdio.h>
#include <assert.h>

const char month2[12][10]=
{
	{ 'j','a','n','v','i','e','r',  0,  0,  0 },
	{ 'f','e','b','v','r','i','e','r',  0,  0 },
	{ 'm','a','s',  0,  0,  0,  0,  0,  0,  0 },
	{ 'a','v','r','i','l',  0,  0,  0,  0,  0 },
	{ 'm','a','i',  0,  0,  0,  0,  0,  0,  0 },
	{ 'j','u','i','n',  0,  0,  0,  0,  0,  0 },
	{ 'j','u','i','l','l','e','t',  0,  0,  0 },
	{ 'a','o','u','t',  0,  0,  0,  0,  0,  0 },
	{ 's','e','p','t','e','m','b','r','e',  0 },
	{ 'o','c','t','o','b','r','e',  0,  0,  0 },
	{ 'n','o','v','e','m','b','r','e',  0,  0 },
	{ 'd','e','c','e','m','b','r','e',  0,  0 }
};

// dans l'intervalle 0..11
const char* get_month2 (int month)
{
	return &month2[month][0];
};
