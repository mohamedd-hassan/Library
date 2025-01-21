f:
; check condition (1):
	cmp	edi, esi
	jge	.L9
	push	rbp
	push	rbx
	mov	ebp, esi
	mov	ebx, edi
	sub	rsp, 8
.L5:
	mov	edx, ebx
	xor	eax, eax
	mov	esi, OFFSET FLAT:.LC0 ; "\%d\textbackslash n"
	mov	edi, 1
	add	ebx, 1
	call	__printf_chk
; check condition (2):
	cmp	ebp, ebx
	jne	.L5
	add	rsp, 8
	pop	rbx
	pop	rbp
.L9:
	rep ret
