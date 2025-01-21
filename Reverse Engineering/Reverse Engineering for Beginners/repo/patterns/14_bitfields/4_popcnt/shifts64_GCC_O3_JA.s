f:
	xor	eax, eax	; 変数rtはEAXレジスタに存在
	xor	ecx, ecx	; 変数iはECXレジスタに存在
.L3:
	mov	rsi, rdi	; 入力値をロード
	lea	edx, [rax+1]	; EDX=EAX+1
; ここのEDXは \emph{rtの新たなバージョン}で、
; ラストビットが1の場合に、変数rtに書き込まれる
	shr	rsi, cl		; RSI=RSI>>CL
	and	esi, 1		; ESI=ESI\&1
; ラストビットが1か？そうなら、\emph{rtの新たなバージョン} をEAXに書き込む
	cmovne	eax, edx
	add	rcx, 1		; RCX++
	cmp	rcx, 64
	jne	.L3
	rep ret			; fatretの別名
