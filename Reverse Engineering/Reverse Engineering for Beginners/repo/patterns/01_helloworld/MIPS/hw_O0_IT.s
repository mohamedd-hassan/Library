$LC0:
	.ascii	"Hello, world!\012\000"
main:
; prologo funzione.
; Salva il RA (\$31) e FP nello stack:
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
; imposta il FP (stack frame pointer):
	move	$fp,$sp
; imposta il GP:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
; carica l'indirizzo della stringa di testo:
	lui	$2,%hi($LC0)
	addiu	$4,$2,%lo($LC0)
; carica l'indirizzo di puts() usando il GP:
	lw	$2,%call16(puts)($28)
	nop
; chiama puts():
	move	$25,$2
	jalr	$25
	nop  ; branch delay slot

; ripristina il GP dallo stack locale:
	lw	$28,16($fp)
; imposta il registro \$2 (\$V0) a zero:
	move	$2,$0
; epilogo funione.
; ripristina il SP:
	move	$sp,$fp
; ripristina il RA:
	lw	$31,28($sp)
; ripristina il FP:
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
; salta al RA:
	j	$31
	nop  ; branch delay slot
