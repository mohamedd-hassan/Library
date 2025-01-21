.LC0:
	.string	"it is ten"
.LC1:
	.string	"it is not ten"
f:
.LFB0:
; confronta il valode di input con 10
	cmp	DWORD PTR [esp+4], 10
	mov	edx, OFFSET FLAT:.LC1 ; "it is not ten"
	mov	eax, OFFSET FLAT:.LC0 ; "it is ten"
; se il rislutato del confronto non è uguale, copia il valore di EDX in EAX
; altrimenti, non fare nulla
	cmovne	eax, edx
	ret
