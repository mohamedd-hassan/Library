#include <stdio.h>

char a[3][4];

int main()
{
	int x, y;
	
	// 配列のクリア
	for (x=0; x<3; x++)
		for (y=0; y<4; y++)
			a[x][y]=0;

	// 3番目のカラムを0..2で満たす
	for (x=0; x<3; x++)
		a[x][2]=x;
};
