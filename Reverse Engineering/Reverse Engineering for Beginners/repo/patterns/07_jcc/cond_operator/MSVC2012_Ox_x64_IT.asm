$SG1355	DB	'it is ten', 00H
$SG1356	DB	'it is not ten', 00H

a$ = 8
f	PROC
; carica i puntatore ad entrambe le stringhe
	lea	rdx, OFFSET FLAT:$SG1355 ; 'it is ten'
	lea	rax, OFFSET FLAT:$SG1356 ; 'it is not ten'
; confronta il valore di input con 10
	cmp	ecx, 10
; se è uguale, copia il valore da RDX ("it is ten")
; altrimenti, non fare niente. Il puntatore alla strunga 
; "it is not ten" è già in RAX.
	cmove	rax, rdx
	ret	0
f	ENDP
