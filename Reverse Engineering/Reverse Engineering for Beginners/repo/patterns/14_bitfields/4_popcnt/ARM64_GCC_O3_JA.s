f:
	mov	w2, 0		; rt=0
	mov	x5, 1
	mov	w1, w2
.L2:
	lsl	x4, x5, x1	; w4 = w5<<w1 = 1<<i
	add	w3, w2, 1	; new\_rt=rt+1
	tst	x4, x0		; \verb|(1<<i) & a|
	add	w1, w1, 1	; i++
; TSTの結果は非ゼロか？
; そうならw2=w3 または rt=new\_rt. 
; そうでなければ w2=w2 または rt=rt (アイドル演算)
	csel	w2, w3, w2, ne
	cmp	w1, 64		; i<64?
	bne	.L2		; はい
	mov	w0, w2		; rtをリターン
	ret
