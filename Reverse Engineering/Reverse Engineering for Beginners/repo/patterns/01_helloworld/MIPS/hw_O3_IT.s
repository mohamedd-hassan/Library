$LC0:
; \textbackslash{}000 è zero byte in base ottale:
	.ascii	"Hello, world!\012\000"
main:
; prologo funzione.
; imposta il GP:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-32
	addiu	$28,$28,%lo(__gnu_local_gp)
; salva il RA nello stack locale:
	sw	$31,28($sp)
; carica l'indirizzo della funzione puts() dal GP a \$25:
	lw	$25,%call16(puts)($28)
; carica l'indirizzo della sringa di testo in \$4 (\$a0):
	lui	$4,%hi($LC0)
; salta a puts(), salvando l'indirizzo di ritorno nel link register:
	jalr	$25
	addiu	$4,$4,%lo($LC0) ; branch delay slot
; ripristina il RA:
	lw	$31,28($sp)
; copia 0 da \$zero a \$v0:
	move	$2,$0
; ritorna saltando al RA:
	j	$31
; epilogo della funzione:
	addiu	$sp,$sp,32 ; branch delay slot + liberazione dello stack locale

