	.comm	x,4,4
.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
f5:
; salva FP e LR nello stack frame:
	stp	x29, x30, [sp, -16]!
; imposta lo stack frame (FP=SP)
	add	x29, sp, 0
; imposta il puntatore alla stringa "Enter X:":
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
; imposta il puntatore alla stringa "\%d":
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; forma l'indirizzo della variabile globale x:
	adrp	x1, x
	add	x1, x1, :lo12:x
	bl	__isoc99_scanf
; forma di nuovo l'indirizzo della variabile globale x:
	adrp	x0, x
	add	x0, x0, :lo12:x
; carica il valore dalla memoria a questo indirizzo:
	ldr	w1, [x0]
; imposta il puntatore alla stringa \verb|"You entered %d...\n":|
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; ritorna 0
	mov	w0, 0
; ripristina FP e LR:
	ldp	x29, x30, [sp], 16
	ret
