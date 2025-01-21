; X0=a1
; X1=a2
; X2=cnt
f:
	cbz	x2, .L1            ; cnt==0? sortir si oui
; calculer le dernier élément du tableau "a1"
	add	x2, x2, x2, lsl 1
; X2=X2+X2<<1=X2+X2*2=X2*3
	mov	x3, 0
	lsl	x2, x2, 2
; X2=X2<<2=X2*4=X2*3*4=X2*12
.L3:
	ldr	w4, [x1],28        ; charger en X1, ajouter 28 à X1 (post-incrémentation)
	str	w4, [x0,x3]        ; stocker en X0+X3=a1+X3
	add	x3, x3, 12         ; décaler X3
	cmp	x3, x2             ; fini?
	bne	.L3
.L1:
	ret
