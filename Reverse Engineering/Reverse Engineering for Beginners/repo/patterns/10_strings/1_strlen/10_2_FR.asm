_str$ = 8			; size = 4
_strlen PROC
	mov	edx, DWORD PTR _str$[esp-4] ; EDX -> pointeur sur la chaîne
	mov	eax, edx                    ; déplacer dans EAX
$LL2@strlen:
	mov	cl, BYTE PTR [eax]          ; CL = *EAX
	inc	eax                         ; EAX++
	test	cl, cl                      ; CL==0?
	jne	SHORT $LL2@strlen           ; non, continuer la boucle
	sub	eax, edx                    ; calculer la différence entre les pointeurs
	dec	eax                         ; décrémenter EAX
	ret	0
_strlen ENDP
