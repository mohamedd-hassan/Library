#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <memory.h>

struct float_as_struct
{
    unsigned int fraction : 23; // 端数部分
    unsigned int exponent : 8;  // 指数 + 0x3FF
    unsigned int sign : 1;      // 符号ビット
};

float f(float _in)
{
    float f=_in;
    struct float_as_struct t;

    assert (sizeof (struct float_as_struct) == sizeof (float));

    memcpy (&t, &f, sizeof (float));

    t.sign=1; // 負号を設定
    t.exponent=t.exponent+2; // dに $2^{n}$(nはここでは2)を乗算

    memcpy (&f, &t, sizeof (float));

    return f;
};

int main()
{
    printf ("%f\n", f(1.234));
};
