_s1$ = 8	; taille = 4
_outbuf$ = 12	; taille = 4
_strcpy_test PROC
	mov	eax, DWORD PTR _s1$[esp-4]
	mov	edx, DWORD PTR _outbuf$[esp-4]
	sub	edx, eax
	npad	6 ; aligner le label suivant
$LL3@strcpy_tes:
	mov	cl, BYTE PTR [eax]
	mov	BYTE PTR [edx+eax], cl
	inc	eax
	test	cl, cl
	jne	SHORT $LL3@strcpy_tes
	ret	0
_strcpy_test ENDP
