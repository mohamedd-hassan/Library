#include <stdio.h>

char a[3][4];

int main()
{
	int x, y;
	
	// 配列のクリア
	for (x=0; x<3; x++)
		for (y=0; y<4; y++)
			a[x][y]=0;

	// 2番目の行を0..3で満たす
	for (y=0; y<4; y++)
		a[1][y]=y;
};
