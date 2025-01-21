$LC0:
	.ascii	"a=%d; b=%d; c=%d\000"
main:
; prolog:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-32
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,28($sp)
; załaduj adres funkcji printf():
	lw	$25,%call16(printf)($28)
; załaduj adres łańcucha znaków i ustaw jako 1. argument funkcji printf():
	lui	$4,%hi($LC0)
	addiu	$4,$4,%lo($LC0)
; ustaw 2. argument funkcji printf():
	li	$5,1			# 0x1
; ustaw 3. argument funkcji printf():
	li	$6,2			# 0x2
; wywołaj printf():
	jalr	$25
; ustaw 4. argument funkcji printf() (branch delay slot):
	li	$7,3			# 0x3

; epilog:
	lw	$31,28($sp)
; ustaw wartość zwracaną na 0:
	move	$2,$0
; zwróć wartość:
	j	$31
	addiu	$sp,$sp,32 ; branch delay slot
