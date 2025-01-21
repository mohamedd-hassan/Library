.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
.LC3:
	.string	"What you entered? Huh?"
f6:
; salva FP e LR nello stack frame:
	stp	x29, x30, [sp, -32]!
; imposta lo stack frame (FP=SP)
	add	x29, sp, 0
; imposta il puntatore alla stringa "Enter X:":
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
; imposta il puntatore alla stringa "\%d":
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; calcola l'indirizzo della variabile x nello stack locale
	add	x1, x29, 28
	bl	__isoc99_scanf
; il risultato di scanf() viene messo in W0.
; controlla:
	cmp	w0, 1
; BNE è Branch if Not Equal 
; quindi se W0<>1, avverrà il salto a L2
	bne	.L2
; in questo momento W0=1, che significa niente errore
; carica il valore di x dallo stack locale
	ldr	w1, [x29,28]
; imposta il puntatore alla stringa "You entered \%d...\textbackslash{}n":
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; salta il codice, il quale stampa la stringa "What you entered? Huh?"
	b	.L3
.L2:
; imposta il puntatore alla stringa "What you entered? Huh?":
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	puts
.L3:
; ritorna 0
	mov	w0, 0
; ripristina FP e LR:
	ldp	x29, x30, [sp], 32
	ret
