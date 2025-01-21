printing_function:
; printf()の第二引数を準備:
	mov	w1, w0
; "f(\%d)\textbackslash{}n"文字列のアドレスをロード
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; 分岐とリターンの命令ではなく単なる分岐の命令
	b	printf
main:
; ローカルスタックにFPとLRを保存
	stp	x29, x30, [sp, -32]!
; スタックフレームを設定
	add	x29, sp, 0
; X19レジスタの内容をローカルスタックに保存
	str	x19, [sp,16]
; W19レジスタをカウンタとして利用します
; W19に初期値として2を設定します
	mov	w19, 2
.L3:
; printing\_function()の最初の引数を準備します:
	mov	w0, w19
; カウンタレジスタをインクリメント
	add	w19, w19, 1
; W0はインクリメントする前のカウンタの値を保持しています
	bl	printing_function
; 終了？
	cmp	w19, 10
; 終了でなければ、ループボディの開始にジャンプ
	bne	.L3
; 0をリターン
	mov	w0, 0
; X19レジスタの内容をリストア
	ldr	x19, [sp,16]
; FPとLRの値をリストア
	ldp	x29, x30, [sp], 32
	ret
.LC0:
	.string	"f(%d)\n"
