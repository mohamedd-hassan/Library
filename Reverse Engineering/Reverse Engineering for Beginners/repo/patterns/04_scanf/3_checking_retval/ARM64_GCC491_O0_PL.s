.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
.LC3:
	.string	"What you entered? Huh?"
f6:
; zapisz FP i LR w ramce stosu:
	stp	x29, x30, [sp, -32]!
; ustaw wskaźnik ramki stosu (FP=SP)
	add	x29, sp, 0
; załaduj wskaźnik na łańcuch znaków "Enter X:":
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
; załaduj wskaźnik na łańcuch znaków "\%d":
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; oblicz adres zmiennej x na stosie lokalnym:
	add	x1, x29, 28
	bl	__isoc99_scanf
; scanf() zwraca wynik przez rejestr W0
; sprawdź go:
	cmp	w0, 1
; BNE oznacza Branch if Not Equal
; jeśli W0<>1, skocz do L2
	bne	.L2
; w tym miejscu W0=1, co oznacza brak błędu
; załaduj wartość x ze stosu lokalnego
	ldr	w1, [x29,28]
; załaduj wskaźnik na łańcuch znaków "You entered \%d...\textbackslash{}n":
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; przeskocz przez kod wyświetlający "What you entered? Huh?":
	b	.L3
.L2:
; załaduj wskaźnik na łańcuch znaków "What you entered? Huh?":
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	puts
.L3:
; zwróc 0
	mov	w0, 0
; przywróć FP i LR:
	ldp	x29, x30, [sp], 32
	ret
