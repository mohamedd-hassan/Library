#include <stdio.h>

// x ist jetzt eine globale Variable
int x;

int main() 
{
    printf ("Wert für x:\n");

    scanf ("%d", &x);

    printf ("Sie haben %d... eingegeben\n", x);

    return 0;
};
