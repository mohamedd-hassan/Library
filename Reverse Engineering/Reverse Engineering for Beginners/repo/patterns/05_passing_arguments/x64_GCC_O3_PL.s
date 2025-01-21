f:
	; EDI - 1 argument
	; ESI - 2 argument
	; EDX - 3 argument
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
	xor	eax, eax  ; liczba rejestrów wektorowych z argumentami
	call	printf
	xor	eax, eax
	add	rsp, 8
	ret
