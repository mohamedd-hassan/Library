c$ = 8
toupper	PROC
	mov	BYTE PTR [rsp+8], cl
	movsx	eax, BYTE PTR c$[rsp]
	cmp	eax, 97
	jl	SHORT $LN2@toupper
	movsx	eax, BYTE PTR c$[rsp]
	cmp	eax, 122
	jg	SHORT $LN2@toupper
	movsx	eax, BYTE PTR c$[rsp]
	sub	eax, 32
	jmp	SHORT $LN3@toupper
	jmp	SHORT $LN1@toupper	; артефакт компилятора
$LN2@toupper:
	movzx	eax, BYTE PTR c$[rsp]	; необязательное приведение типов
$LN1@toupper:
$LN3@toupper:				; артефакт компилятора
	ret	0
toupper	ENDP
