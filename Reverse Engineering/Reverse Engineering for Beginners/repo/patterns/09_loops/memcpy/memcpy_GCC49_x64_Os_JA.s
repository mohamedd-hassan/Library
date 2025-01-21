my_memcpy:
; RDI = コピー先アドレス
; RSI = コピー元アドレス
; RDX = ブロックのサイズ

; カウンタ(i)を0で初期化
	xor	eax, eax
.L2:
; 全バイトをコピーしたら終了する
	cmp	rax, rdx
	je	.L5
; RSI+iのバイトをロードする:
	mov	cl, BYTE PTR [rsi+rax]
; バイトをRDI+iに保存する
	mov	BYTE PTR [rdi+rax], cl
	inc	rax ; i++
	jmp	.L2
.L5:
	ret
