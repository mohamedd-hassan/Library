printing_function:
; prepara il secondo argomento di printf():
	mov	w1, w0
; carica l' indirizzo della stringa "f(\%d)\textbackslash{}n"
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; salta solo qui invece di saltare con link e ritorno:
	b	printf
main:
; salva FP e LR nello stack locale:
	stp	x29, x30, [sp, -32]!
; prepara lo stack frame:
	add	x29, sp, 0
; salva il contenuto del registro X19 nello stack locale:
	str	x19, [sp,16]
; useremo il registro W19 come contatore.
; imposta 2 come valore iniziale:
	mov	w19, 2
.L3:
; prepara il primo argomento di printing\_function():
	mov	w0, w19
; incrementa il registro contatore.
	add	w19, w19, 1
; qui W0 ha ancora il valore del contatore prima dell' incremento.
	bl	printing_function
; è finita?
	cmp	w19, 10
; no, salta all' inizio del corpo del ciclo:
	bne	.L3
; ritorna 0
	mov	w0, 0
; ripristina il contenuto del registro X19:
	ldr	x19, [sp,16]
; ripristina i valori di FP e LR:
	ldp	x29, x30, [sp], 32
	ret
.LC0:
	.string	"f(%d)\n"
