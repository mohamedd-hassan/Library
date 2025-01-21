my_max:
; X0=A
; X1=B
; AとBを比較
	cmp	x0, x1
; X0>=X1 または A>=B (Greater or Equal)の場合、X0(A)を選択する
; A<Bの場合、X1 (B)を選択する
	csel	x0, x0, x1, ge
	ret

my_min:
; X0=A
; X1=B
; AとBを比較
	cmp	x0, x1
; X0<=X1 または A<=B (Less or Equal)の場合、X0(A)を選択する
; A>Bの場合、X1 (B)を選択する
	csel	x0, x0, x1, le
	ret
