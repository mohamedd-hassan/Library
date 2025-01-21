str_trim:
	stp	x29, x30, [sp, -32]!
	add	x29, sp, 0
	str	x19, [sp,16]
	mov	x19, x0
; X19 contiendra toujours la valeur de "s"
	bl	strlen
; X0=str\_len
	cbz	x0, .L9        ; sauter en L9 (sortir) si str\_len==0
	sub	x1, x0, #1
; X1=X0-1=str\_len-1
	add	x3, x19, x1
; X3=X19+X1=s+str\_len-1
	ldrb	w2, [x19,x1]   ; charger l'octet à l'adresse X19+X1=s+str\_len-1
; W2=octet chargé
	cbz	w2, .L9        ; est-ce zéro? sauter alors à la sortie
	cmp	w2, 10         ; \verb|est-ce '\n'?|
	bne	.L15
.L12:
; corps de la boucle principale. Le caractère chargé est toujours 10 ou 13 à ce moment!
	sub	x2, x1, x0
; X2=X1-X0=str\_len-1-str\_len=-1
	add	x2, x3, x2
; X2=X3+X2=s+str\_len-1+(-1)=s+str\_len-2
	strb	wzr, [x2,1]    ; stocker l'octet zéro à l'adresse s+str\_len-2+1=s+str\_len-1
	cbz	x1, .L9        ; str\_len-1==0? sauter à la sortie si oui
	sub	x1, x1, #1     ; str\_len--
	ldrb	w2, [x19,x1]   ; charger le caractère suivant à l'adresse X19+X1=s+str\_len-1
	cmp	w2, 10         ; \verb|est-ce '\n'?|
	cbz	w2, .L9        ; sauter à la sortie, si c'est zéro
	beq	.L12           ; \verb|sauter au début du corps de la boucle, si c'est '\n'|
.L15:
	cmp	w2, 13         ; \verb|est-ce '\r'?|
	beq	.L12           ; oui, sauter au début du corps de la boucle
.L9:
; renvoyer "s"
	mov	x0, x19
	ldr	x19, [sp,16]
	ldp	x29, x30, [sp], 32
	ret
