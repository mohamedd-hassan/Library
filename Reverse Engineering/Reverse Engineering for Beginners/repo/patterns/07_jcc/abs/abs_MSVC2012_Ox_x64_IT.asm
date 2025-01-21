i$ = 8
my_abs	PROC
; ECX = input
	test	ecx, ecx
; controllo del segno del valore in input
; salta l'istruzione NEG se il segno è positivo
	jns	SHORT $LN2@my_abs
; valore negato
	neg	ecx
$LN2@my_abs:
; prepara il risultato in EAX:
	mov	eax, ecx
	ret	0
my_abs	ENDP
