.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
scanf_main:
; sottrai 32 dallo SP, poi salva il FP ed il LR nello stack frame:
	stp	x29, x30, [sp, -32]!
; imposta lo stack frame (FP=SP)
	add	x29, sp, 0
; imposta il puntatore alla stringa "Enter X:":
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; X0=puntatore alla stringa "Enter X:"
; stampalo:
	bl	puts
; imposta il puntatore alla stringa "\%d":
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; trova uno spazio nello stack frame per la variabile "x" (X1=FP+28):
	add	x1, x29, 28
; X1=indirizzo della variabile "x"
; passa l'indirizzo alla scanf() e chiamala:
	bl	__isoc99_scanf
; carica 32-bit dalla variabile nello stack frame:
	ldr	w1, [x29,28]
; W1=x
; imposta il puntatore alla stringa \verb|"You entered %d...\n"|
; printf() prenderà la stringa di testo da X0 alla variabile "x" da X1 (o W1)
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; ritorna 0
	mov	w0, 0
; ripristina FP e LR, poi aggiungi 32 allo SP:
	ldp	x29, x30, [sp], 32
	ret
