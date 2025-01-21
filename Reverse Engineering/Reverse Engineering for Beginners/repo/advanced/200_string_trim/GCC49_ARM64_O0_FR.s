str_trim:
	stp	x29, x30, [sp, -48]!
	add	x29, sp, 0
	str	x0, [x29,24] ; copier l'argument en entrée dans la pile locale
	ldr	x0, [x29,24] ; s
	bl	strlen
	str	x0, [x29,40] ; la variable str\_len est dans la pile locale
	b	.L2
; la boucle principale commence
.L5:
	ldrb	w0, [x29,39]
; W0=c
	cmp	w0, 13       ; \verb|est-ce '\r'?|
	beq	.L3
	ldrb	w0, [x29,39]
; W0=c
	cmp	w0, 10       ; \verb|est-ce '\n'?|
	bne	.L4          ; sauter à la sortie si non
.L3:
	ldr	x0, [x29,40]
; X0=str\_len
	sub	x0, x0, #1
; X0=str\_len-1
	ldr	x1, [x29,24]
; X1=s
	add	x0, x1, x0
; X0=s+str\_len-1
	strb	wzr, [x0]    ; écrire l'octet à s+str\_len-1
; décrémenter str\_len:
	ldr	x0, [x29,40]
; X0=str\_len
	sub	x0, x0, #1
; X0=str\_len-1
	str	x0, [x29,40]
; sauver X0 (or str\_len-1) dans la pile locale
.L2:
	ldr	x0, [x29,40]
; str\_len==0?
	cmp	x0, xzr
; sauter alors à la sortie
	beq	.L4
	ldr	x0, [x29,40]
; X0=str\_len
	sub	x0, x0, #1
; X0=str\_len-1
	ldr	x1, [x29,24]
; X1=s
	add	x0, x1, x0
; X0=s+str\_len-1
; charger l'octet à l'adresse s+str\_len-1 dans W0
	ldrb	w0, [x0]
	strb	w0, [x29,39] ; stocker l'octet chargé dans "c"
	ldrb	w0, [x29,39] ; le recharger
; est-ce l'octet zéro?
	cmp	w0, wzr
; sauter à la sortie, si c'est zéro ou en L5 sinon
	bne	.L5
.L4:
; renvoyer s
	ldr	x0, [x29,24]
	ldp	x29, x30, [sp], 48
	ret
