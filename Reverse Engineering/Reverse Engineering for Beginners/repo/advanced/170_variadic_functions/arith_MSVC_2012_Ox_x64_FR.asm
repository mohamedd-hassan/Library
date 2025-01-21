$SG3013	DB	'%d', 0aH, 00H

v$ = 8
arith_mean PROC
	mov	DWORD PTR [rsp+8], ecx   ; 1er argument
	mov	QWORD PTR [rsp+16], rdx  ; 2nd argument
	mov	QWORD PTR [rsp+24], r8   ; 3ème argument
	mov	eax, ecx                 ; sum = 1er argument
	lea	rcx, QWORD PTR v$[rsp+8] ; pointeur sur le 2nd argument
	mov	QWORD PTR [rsp+32], r9   ; 4ème argument
	mov	edx, DWORD PTR [rcx]     ; charger le 2nd argument
	mov	r8d, 1                   ; count=1
	cmp	edx, -1                  ; est-ce que le 2nd argument est -1?
	je	SHORT $LN8@arith_mean    ; sortir si oui
$LL3@arith_mean:
	add	eax, edx                 ; sum = sum + argument chargé
	mov	edx, DWORD PTR [rcx+8]   ; charger l'argument suivant
	lea	rcx, QWORD PTR [rcx+8]   ; décaler le pointeur pour pointer
                                         ; sur l'argument après le suivant
	inc	r8d                      ; count++
	cmp	edx, -1                  ; est-ce que l'argument chargé est -1?
	jne	SHORT $LL3@arith_mean    ; aller au début de la boucle si non
$LN8@arith_mean:
; calculer le quotient
	cdq
	idiv	r8d
	ret	0
arith_mean ENDP

main	PROC
	sub	rsp, 56
	mov	edx, 2
	mov	DWORD PTR [rsp+40], -1
	mov	DWORD PTR [rsp+32], 15
	lea	r9d, QWORD PTR [rdx+8]
	lea	r8d, QWORD PTR [rdx+5]
	lea	ecx, QWORD PTR [rdx-1]
	call	arith_mean
	lea	rcx, OFFSET FLAT:$SG3013
	mov	edx, eax
	call	printf
	xor	eax, eax
	add	rsp, 56
	ret	0
main	ENDP
