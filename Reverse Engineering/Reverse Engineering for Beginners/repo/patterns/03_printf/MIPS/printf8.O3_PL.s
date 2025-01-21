$LC0:
	.ascii	"a=%d; b=%d; c=%d; d=%d; e=%d; f=%d; g=%d; h=%d\012\000"
main:
; prolog:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-56
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,52($sp)
; zapisz 5. argument na stosie:
	li	$2,4			# 0x4
	sw	$2,16($sp)
; zapisz 6. argument na stosie:
	li	$2,5			# 0x5
	sw	$2,20($sp)
; zapisz 7. argument na stosie:
	li	$2,6			# 0x6
	sw	$2,24($sp)
; zapisz 8. argument na stosie:
	li	$2,7			# 0x7
	lw	$25,%call16(printf)($28)
	sw	$2,28($sp)
; zapisz 1 argument w \$a0:
	lui	$4,%hi($LC0)
; zapisz 9 argument na stosie:
	li	$2,8			# 0x8
	sw	$2,32($sp)
	addiu	$4,$4,%lo($LC0)
; zapisz 2 argument w \$a1:
	li	$5,1			# 0x1
; zapisz 3 argument w \$a2:
	li	$6,2			# 0x2
; wywołaj printf():
	jalr	$25
; zapisz 4 argument w \$a3 (branch delay slot):
	li	$7,3			# 0x3

; epilog:
	lw	$31,52($sp)
; ustaw wartość zwracaną na 0:
	move	$2,$0
; zwróć wartość
	j	$31
	addiu	$sp,$sp,56 ; branch delay slot
