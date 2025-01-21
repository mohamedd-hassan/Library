_str$ = 8			; dimensione = 4
_strlen PROC
	mov	edx, DWORD PTR _str$[esp-4] ; EDX -> puntatore alla stringa
	mov	eax, edx                    ; spostalo in EAX
$LL2@strlen:
	mov	cl, BYTE PTR [eax]          ; CL = *EAX
	inc	eax                         ; EAX++
	test	cl, cl                      ; CL==0?
	jne	SHORT $LL2@strlen           ; no, continua il ciclo
	sub	eax, edx                    ; calcola la differenza tra puntatori
	dec	eax                         ; decrementa EAX
	ret	0
_strlen ENDP
