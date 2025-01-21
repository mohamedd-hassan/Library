.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
.LC3:
	.string	"What you entered? Huh?"
f6:
; スタックフレームにFPとLRと保存
	stp	x29, x30, [sp, -32]!
; スタックフレームを設定(FP=SP)
	add	x29, sp, 0
; "Enter X:"文字列へのポインタをロード
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
; "\%d"文字列へのポインタをロード
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; ローカルスタックにある変数xのアドレスを計算
	add	x1, x29, 28
	bl	__isoc99_scanf
; W0にscanf()の戻り値が入っている
; チェックする
	cmp	w0, 1
; BNEはイコールでない場合に分岐する
; だから、W0<>1の場合、L2にジャンプする
	bne	.L2
; W0=1の場合、エラーなし
; ローカルスタックからxの値をロードする
	ldr	w1, [x29,28]
; "You entered \%d...\textbackslash{}n"文字列へのポインタをロードする
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; "What you entered? Huh?"文字列を表示するコードをスキップする
	b	.L3
.L2:
; "What you entered? Huh?"文字列へのポインタをロードする
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	puts
.L3:
; 0をリターン
	mov	w0, 0
; FPとLRを元に戻す:
	ldp	x29, x30, [sp], 32
	ret
