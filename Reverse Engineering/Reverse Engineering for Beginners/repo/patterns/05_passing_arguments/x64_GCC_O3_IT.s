f:
	; EDI - 1° argomento
	; ESI - 2° argomento
	; EDX - 3° argomento
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
	xor	eax, eax  ; numero dei registri vettore passati
	call	printf
	xor	eax, eax
	add	rsp, 8
	ret
