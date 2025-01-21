$LC0:
	.ascii	"a=%d; b=%d; c=%d\000"
main:
; prologo funzione:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-32
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,28($sp)
; carica l'indirizzo di printf():
	lw	$25,%call16(printf)($28)
; carica l'indirizzo della stringa di testo e imposta il 1° argomento di printf():
	lui	$4,%hi($LC0)
	addiu	$4,$4,%lo($LC0)
; imposta il 2° argomento di printf():
	li	$5,1			# 0x1
; imposta il 3° argomento di printf():
	li	$6,2			# 0x2
; chiama printf():
	jalr	$25
; imposta il 4° argomento di printf() (branch delay slot):
	li	$7,3			# 0x3

; epilogo funzione:
	lw	$31,28($sp)
; imposta il valore di ritorno a 0:
	move	$2,$0
; ritorna
	j	$31
	addiu	$sp,$sp,32 ; branch delay slot
