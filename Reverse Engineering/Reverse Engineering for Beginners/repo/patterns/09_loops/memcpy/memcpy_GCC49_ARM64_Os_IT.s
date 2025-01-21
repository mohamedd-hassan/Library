my_memcpy:
; X0 = indirizzo destinazione
; X1 = indirizzo sorgente
; X2 = dimensione del blocco

; inizializza il contaore (i) a 0
	mov	x3, 0
.L2:
; sono stati copiati tutti i byte? allora esci:
	cmp	x3, x2
	beq	.L5
; carica il byte a X1+i:
	ldrb	w4, [x1,x3]
; salva il byte a X0+i:
	strb	w4, [x0,x3]
	add	x3, x3, 1 ; i++
	b	.L2
.L5:
	ret
