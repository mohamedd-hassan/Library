; W0 = month
	sxtw	x0, w0
; X0 = 符号拡張された入力値
	adrp	x1, .LANCHOR1
	add	x1, x1, :lo12:.LANCHOR1
; X1 = テーブルへのポインタ
	add	x0, x0, x0, lsl 2
; X0 = X0+X0<<2 = X0+X0*4 = X0*5
	add	x0, x1, x0, lsl 1
; X0 = X1+X0<<1 = X1+X0*2 = テーブルへのポインタ + X0*10
	ret
