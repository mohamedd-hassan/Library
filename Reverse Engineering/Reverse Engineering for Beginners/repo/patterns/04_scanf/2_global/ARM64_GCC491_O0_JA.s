	.comm	x,4,4
.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
f5:
; FPとLRをスタックフレームに保存する:
	stp	x29, x30, [sp, -16]!
; スタックフレームを設定する(FP=SP)
	add	x29, sp, 0
; "Enter X:"文字列へのポインタをロードする:
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
; "\%d" 文字列へのポインタをロードする:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; xグローバル変数のアドレスを形作る:
	adrp	x1, x
	add	x1, x1, :lo12:x
	bl	__isoc99_scanf
; 再度xグローバル変数のアドレスを形作る:
	adrp	x0, x
	add	x0, x0, :lo12:x
; このアドレスのメモリから値をロードする:
	ldr	w1, [x0]
; \verb|"You entered %d...\n"| 文字列へのポインタをロードする:
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; 0をリターンする
	mov	w0, 0
; FPとLRをリストアする:
	ldp	x29, x30, [sp], 16
	ret
