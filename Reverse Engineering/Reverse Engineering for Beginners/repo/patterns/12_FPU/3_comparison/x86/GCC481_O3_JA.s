	fld	QWORD PTR [esp+4]	; load "a"
	fld	QWORD PTR [esp+12]	; load "b"
	; ST0=b, ST1=a
	fxch	st(1)
	; ST0=a, ST1=b
	; "a"と"b"を比較
	fucomi	st, st(1)
	; a<=bなら、ST1 (ここでは"b") をST0にコピー
	; "a"をST0に残す
	fcmovbe	st, st(1)
	; ST1の値を破棄する
	fstp	st(1)
	ret
