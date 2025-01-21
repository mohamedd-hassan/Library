$SG746	DB	'it is ten', 00H
$SG747	DB	'it is not ten', 00H

tv65 = -4 ; questa verrà utilizzata come variabile temporanea
_a$ = 8	
_f	PROC
	push	ebp
	mov	ebp, esp
	push	ecx
; confronta il valore in input con 10
	cmp	DWORD PTR _a$[ebp], 10
; se non è uguale, salta a \$LN3@f
	jne	SHORT $LN3@f
; salva il puntatore alla stringa nella variabile temporanea:
	mov	DWORD PTR tv65[ebp], OFFSET $SG746 ; 'it is ten'
; salta a exit
	jmp	SHORT $LN4@f
$LN3@f:
; salva il puntatore alla stringa nella variabile temporanea:
	mov	DWORD PTR tv65[ebp], OFFSET $SG747 ; 'it is not ten'
$LN4@f:
; questa è l' exit. 
; copia il puntatore alla stringa dalla variabile temporanea in EAX.
	mov	eax, DWORD PTR tv65[ebp]
	mov	esp, ebp
	pop	ebp
	ret	0
_f	ENDP
