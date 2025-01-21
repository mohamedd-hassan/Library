	.comm	x,4,4
.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
f5:
; zapisz FP i LR w ramce stosu
	stp	x29, x30, [sp, -16]!
; ustaw wskaźnik ramki stosu (FP=SP)
	add	x29, sp, 0
; wczytaj wskaźnik na łańcuch znaków "Enter X:":
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
; wczytaj wskaźnik na łańcuch znaków "\%d":
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; ustaw adres zmiennej globalnej x:
	adrp	x1, x
	add	x1, x1, :lo12:x
	bl	__isoc99_scanf
; ponownie ustaw adres zmiennej globalnej x:
	adrp	x0, x
	add	x0, x0, :lo12:x
; wczytaj wartość z tego adresu:
	ldr	w1, [x0]
; wczytaj wskaźnik na łańcuch znaków \verb|"You entered %d...\n"|
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; zwróć 0
	mov	w0, 0
; przywróć FP i LR:
	ldp	x29, x30, [sp], 16
	ret
