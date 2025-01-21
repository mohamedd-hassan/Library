$LC0:
	.ascii	"a=%d; b=%d; c=%d\000"
main:
; prolog:
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
; załaduj adres łańcucha znaków:
	lui	$2,%hi($LC0)
	addiu	$2,$2,%lo($LC0)
; ustaw 1. argument funkcji printf():
	move	$4,$2
; ustaw 2. argument funkcji printf():
	li	$5,1			# 0x1
; ustaw 3. argument funkcji printf():
	li	$6,2			# 0x2
; ustaw 4. argument funkcji printf():
	li	$7,3			# 0x3
; pobierz adres funkcji printf():
	lw	$2,%call16(printf)($28)
	nop
; wywołaj printf():
	move	$25,$2
	jalr	$25
	nop

; epilog:
	lw	$28,16($fp)
; ustaw wartość zwracaną na 0:
	move	$2,$0
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
; zwróć wartość:
	j	$31
	nop
