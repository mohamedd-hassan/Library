#include <stdio.h>

const char* month1[]=
{
	"janvier", "fevrier", "mars", "avril",
	"mai", "juin", "juillet", "aout",
	"septembre", "octobre", "novembre", "decembre"
};

// dans l'intervalle 0..11
const char* get_month1 (int month)
{
	return month1[month];
};
