#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <memory.h>

struct float_as_struct
{
    unsigned int fraction : 23; // fraction
    unsigned int exponent : 8;  // exposant + 0x3FF
    unsigned int sign : 1;      // bit de signe
};

float f(float _in)
{
    float f=_in;
    struct float_as_struct t;

    assert (sizeof (struct float_as_struct) == sizeof (float));

    memcpy (&t, &f, sizeof (float));

    t.sign=1; // Positionnons le bit de signe
    t.exponent=t.exponent+2; // multiplions d par $2^{n}$(n vaut 2 ici)

    memcpy (&f, &t, sizeof (float));

    return f;
};

int main()
{
    printf ("%f\n", f(1.234));
};
