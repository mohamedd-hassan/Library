my_memcpy:
; RDI = indirizzo destinazione
; RSI = indirizzo sorgente
; RDX = dimensione del blocco

; inizializza il contatore (i) a 0
	xor	eax, eax
.L2:
; sono stati copiati tutti i byte? allora esci:
	cmp	rax, rdx
	je	.L5
; carica il byte a RSI+i:
	mov	cl, BYTE PTR [rsi+rax]
; salva il byte a RDI+i:
	mov	BYTE PTR [rdi+rax], cl
	inc	rax ; i++
	jmp	.L2
.L5:
	ret
