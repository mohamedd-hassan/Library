f:
	; EDI - 1番目の引数
	; ESI - 2番目の引数
	; EDX - 3番目の引数
	imul	esi, edi
	lea	eax, [rdx+rsi]
	ret

main:
	sub	rsp, 8
	mov	edx, 3
	mov	esi, 2
	mov	edi, 1
	call	f
	mov	edi, OFFSET FLAT:.LC0 ; "\%d\textbackslash{}n"
	mov	esi, eax
	xor	eax, eax  ; 渡されたベクトルレジスタの数
	call	printf
	xor	eax, eax
	add	rsp, 8
	ret
