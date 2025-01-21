f14:
; valore di input in W0
	sub	w0, w0, #1
	cmp	w0, 21
; salta se è minore o uguale (unsigned):
	bls	.L9
.L2:
; stampa "default":
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	b	puts
.L9:
; carica l' indirizzo della jumptable in X1:
	adrp	x1, .L4
	add	x1, x1, :lo12:.L4
; W0=input\_value-1
; carica un byte dalla tabella:
	ldrb	w0, [x1,w0,uxtw]
; carica l'indirizzo della label Lrtx:
	adr	x1, .Lrtx4
; moltiplica l' elemento della tabella per 4(con uno shift di 2 bit a sinistra) e aggiungi (o sottrai) all indirizzo di Lrtx:
	add	x0, x1, w0, sxtb #2
; salta all' indirizzo calcolato:
	br	x0
; questa label sta puntando nel segmento di codice (text):
.Lrtx4:
	.section	.rodata
; tutto dopo lo statement ".section" è allocato nel segmento read-only data (rodata):
.L4:
	.byte	(.L3 - .Lrtx4) / 4     ; caso 1
	.byte	(.L3 - .Lrtx4) / 4     ; caso 2
	.byte	(.L5 - .Lrtx4) / 4     ; caso 3
	.byte	(.L5 - .Lrtx4) / 4     ; caso 4
	.byte	(.L5 - .Lrtx4) / 4     ; caso 5
	.byte	(.L5 - .Lrtx4) / 4     ; caso 6
	.byte	(.L3 - .Lrtx4) / 4     ; caso 7
	.byte	(.L6 - .Lrtx4) / 4     ; caso 8
	.byte	(.L6 - .Lrtx4) / 4     ; caso 9
	.byte	(.L3 - .Lrtx4) / 4     ; caso 10
	.byte	(.L2 - .Lrtx4) / 4     ; caso 11
	.byte	(.L2 - .Lrtx4) / 4     ; caso 12
	.byte	(.L2 - .Lrtx4) / 4     ; caso 13
	.byte	(.L2 - .Lrtx4) / 4     ; caso 14
	.byte	(.L2 - .Lrtx4) / 4     ; caso 15
	.byte	(.L2 - .Lrtx4) / 4     ; caso 16
	.byte	(.L2 - .Lrtx4) / 4     ; caso 17
	.byte	(.L2 - .Lrtx4) / 4     ; caso 18
	.byte	(.L2 - .Lrtx4) / 4     ; caso 19
	.byte	(.L6 - .Lrtx4) / 4     ; caso 20
	.byte	(.L6 - .Lrtx4) / 4     ; caso 21
	.byte	(.L7 - .Lrtx4) / 4     ; caso 22
	.text
; tutto dopo lo statement ".text" è allocato nel segmento di codice (text):
.L7:
; stampa "22"
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	b	puts
.L6:
; stampa "8, 9, 21"
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	b	puts
.L5:
; stampa "3, 4, 5"
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	b	puts
.L3:
; stampa "1, 2, 7, 10"
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	b	puts
.LC0:
	.string	"1, 2, 7, 10"
.LC1:
	.string	"3, 4, 5"
.LC2:
	.string	"8, 9, 21"
.LC3:
	.string	"22"
.LC4:
	.string	"default"
