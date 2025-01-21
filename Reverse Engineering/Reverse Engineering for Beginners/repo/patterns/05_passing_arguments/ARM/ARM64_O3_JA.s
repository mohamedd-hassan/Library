f:
	madd	w0, w0, w1, w2
	ret

main:
; FPとLRをスタックフレームに保存
	stp	x29, x30, [sp, -16]!
	mov	w2, 3
	mov	w1, 2
	add	x29, sp, 0
	mov	w0, 1
	bl	f
	mov	w1, w0
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	printf
; 0をリターン
	mov	w0, 0
; FPとLRを元に戻す
	ldp	x29, x30, [sp], 16
	ret

.LC7:
	.string	"%d\n"
