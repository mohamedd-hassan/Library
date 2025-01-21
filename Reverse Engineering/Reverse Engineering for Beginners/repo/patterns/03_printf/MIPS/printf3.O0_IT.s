$LC0:
	.ascii	"a=%d; b=%d; c=%d\000"
main:
; prologo funzione:
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
; carica l'indirizzo della stringa di testo:
	lui	$2,%hi($LC0)
	addiu	$2,$2,%lo($LC0)
; imposta il 1° argomento di printf():
	move	$4,$2
; imposta il 2° argomento di printf():
	li	$5,1			# 0x1
; imposta il 3° argomento di printf():
	li	$6,2			# 0x2
; imposta il 4° argomento di printf():
	li	$7,3			# 0x3
; prendi l'indirizzo di printf():
	lw	$2,%call16(printf)($28)
	nop
; chiama printf():
	move	$25,$2
	jalr	$25
	nop

; epilogo funzione:
	lw	$28,16($fp)
; imposta il valore di ritorno a 0:
	move	$2,$0
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
; ritorna
	j	$31
	nop
