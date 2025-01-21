my_max:
; X0=A
; X1=B
; confronta A e B:
	cmp	x0, x1
; seleziona X0 (A) a X0 se X0>=X1 o A>=B (Greater or Equal) 
; seleziona X1 (B) a X0 se A<B
	csel	x0, x0, x1, ge
	ret

my_min:
; X0=A
; X1=B
; confronta A e B:
	cmp	x0, x1
; seleziona X0 (A) a X0 se X0<=X1 o A<=B (Less or Equal)
; seleziona X1 (B) a X0 se A>B
	csel	x0, x0, x1, le
	ret
