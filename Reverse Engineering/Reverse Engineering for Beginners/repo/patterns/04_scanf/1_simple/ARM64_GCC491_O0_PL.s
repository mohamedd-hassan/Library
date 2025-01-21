.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
scanf_main:
; odejmij 32 od SP, a następnie zapisz FP i LR w ramce stosu
	stp	x29, x30, [sp, -32]!
; ustaw wskaźnik ramki stosu (FP=SP)
	add	x29, sp, 0
; wczytaj wskaźnik na łańcuch znaków "Enter X:":
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; X0=wskaźnik na łańcuch znaków "Enter X:"
; wypisz go:
	bl	puts
; wczytaj wskaźnik na łańcuch znaków "\%d":
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; znajdź miejsce w ramce stosu na zmienną "x" (X1=FP+28):
	add	x1, x29, 28
; X1=adres zmiennej "x"
; przekaż adres do funkcji scanf() i ją wywołaj:
	bl	__isoc99_scanf
; załaduj 32-bitową wartość zmiennej z ramki stosu:
	ldr	w1, [x29,28]
; W1=x
; wczytaj wskaźnik na łańcuch znaków \verb|"You entered %d...\n"|
; argumenty printf() - łańcuch znaków z X0 i zmienna "x" z X1 (W1 to młodsze 32 bity)
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; zwróć 0
	mov	w0, 0
; przywróć FP i LR, a następnie dodaj 32 do SP:
	ldp	x29, x30, [sp], 32
	ret
