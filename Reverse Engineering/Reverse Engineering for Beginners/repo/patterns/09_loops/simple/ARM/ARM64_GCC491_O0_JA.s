.LC0:
	.string	"f(%d)\n"
printing_function:
; ローカルスタックにFPとLRを保存します
	stp	x29, x30, [sp, -32]!
; スタックフレームを設定します
	add	x29, sp, 0
; W0レジスタの内容を保存します
	str	w0, [x29,28]
; \verb|"f(%d)\n"|文字列のアドレスをロードします
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; ローカルスタックから入力値をリロードしてW1レジスタに書き込みます
	ldr	w1, [x29,28]
; printf()を呼び出します
	bl	printf
; FPとLRの値をリストアします
	ldp	x29, x30, [sp], 32
	ret
main:
; ローカルスタックにFPとLRを保存します
	stp	x29, x30, [sp, -32]!
; スタックフレームを設定します
	add	x29, sp, 0
; カウンタを初期化
	mov	w0, 2
; ローカルスタック上にアロケートされたところに保存
	str	w0, [x29,28]
; ループボディをスキップし、ループ条件チェック命令にジャンプします
	b	.L3
.L4:
; W0にカウンタ値をロードします
; printing\_function()への第一引数になります
	ldr	w0, [x29,28]
; printing\_function()を呼び出します
	bl	printing_function
; カウンタ値をインクリメント
	ldr	w0, [x29,28]
	add	w0, w0, 1
	str	w0, [x29,28]
.L3:
; ループ条件のチェック
; カウンタ値のロード
	ldr	w0, [x29,28]
; 9かどうか
	cmp	w0, 9
; 9以下か？そうならループボディの開始にジャンプ
; そうでなければ何もしない
	ble	.L4
; 0をリターン
	mov	w0, 0
; FPとLR値をリストア
	ldp	x29, x30, [sp], 32
	ret
