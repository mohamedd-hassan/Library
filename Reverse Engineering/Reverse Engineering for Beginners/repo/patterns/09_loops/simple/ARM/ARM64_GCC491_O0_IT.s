.LC0:
	.string	"f(%d)\n"
printing_function:
; salva FP e LR nello stack locale:
	stp	x29, x30, [sp, -32]!
; prepara lo stack frame:
	add	x29, sp, 0
; salva il contenuto del registro W0:
	str	w0, [x29,28]
; \verb|carica l'indirizzo della stringa "f(%d)\n"|
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; ricarica il valore di input dallo stack locale nel registro W1:
	ldr	w1, [x29,28]
; chiama printf()
	bl	printf
; ripristina i valori di FP e LR:
	ldp	x29, x30, [sp], 32
	ret
main:
; salva FP e LR nello stack locale:
	stp	x29, x30, [sp, -32]!
; prepara lo stack frame:
	add	x29, sp, 0
; inizializza il contatore
	mov	w0, 2
; salvalo nello spazio allocato per lui nello stack locale:
	str	w0, [x29,28]
; sorvola il corpo del ciclo e salta all' istruzione di controllo della condizione di ciclo:
	b	.L3
.L4:
; carica il valore del contatore in W0.
; sarà il primo argomento di printing\_function():
	ldr	w0, [x29,28]
; chiama printing\_function():
	bl	printing_function
; incrementa il valore del contatore:
	ldr	w0, [x29,28]
	add	w0, w0, 1
	str	w0, [x29,28]
.L3:
; controllo della condizione di ciclo.
; carica il valore del contatore:
	ldr	w0, [x29,28]
; vale 9?
	cmp	w0, 9
; minore o uguale? allora salta all' inizio del corpo del ciclo:
; altrimenti, non fare nulla.
	ble	.L4
; ritorna 0
	mov	w0, 0
; ripristina i valori di FP e LR:
	ldp	x29, x30, [sp], 32
	ret
