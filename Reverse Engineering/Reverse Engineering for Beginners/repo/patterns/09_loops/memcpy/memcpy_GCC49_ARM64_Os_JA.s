my_memcpy:
; X0 = コピー先アドレス
; X1 = コピー元アドレス
; X2 = ブロックのサイズ

; カウンタ(i)を0で初期化
	mov	x3, 0
.L2:
; 全バイトをコピーしたら終了する
	cmp	x3, x2
	beq	.L5
; X1+iのバイトをロードする:
	ldrb	w4, [x1,x3]
; バイトをX0+iに保存する
	strb	w4, [x0,x3]
	add	x3, x3, 1 ; i++
	b	.L2
.L5:
	ret
