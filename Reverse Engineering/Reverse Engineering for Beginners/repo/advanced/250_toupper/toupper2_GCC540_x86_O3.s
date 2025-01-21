toupper:
	mov	edx, DWORD PTR [esp+4]
	lea	ecx, [edx-97]
	mov	eax, edx
	xor	eax, 32
	cmp	cl, 25
	cmova	eax, edx
	ret
