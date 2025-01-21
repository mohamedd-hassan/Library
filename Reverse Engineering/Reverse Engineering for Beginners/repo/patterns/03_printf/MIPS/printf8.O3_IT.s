$LC0:
	.ascii	"a=%d; b=%d; c=%d; d=%d; e=%d; f=%d; g=%d; h=%d\012\000"
main:
; prologo funzione:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-56
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,52($sp)
; passa il 5° argomento nello stack:
	li	$2,4			# 0x4
	sw	$2,16($sp)
; passa il 6° argomento nello stack:
	li	$2,5			# 0x5
	sw	$2,20($sp)
; passa il 7° argomento nello stack:
	li	$2,6			# 0x6
	sw	$2,24($sp)
; passa l' 8° argomento nello stack:
	li	$2,7			# 0x7
	lw	$25,%call16(printf)($28)
	sw	$2,28($sp)
; passa il 1° argomento in \$a0: 
	lui	$4,%hi($LC0)
; passa il 9° argomento nello stack:
	li	$2,8			# 0x8
	sw	$2,32($sp)
	addiu	$4,$4,%lo($LC0)
; passa il 2° argomento in \$a1:
	li	$5,1			# 0x1
; passa 3° argomento in \$a2:
	li	$6,2			# 0x2
; chiama printf():
	jalr	$25
; passa il 4° argomento in \$a3 (branch delay slot):
	li	$7,3			# 0x3

; epilogo funzione:
	lw	$31,52($sp)
; imposta il valore di ritorno a 0:
	move	$2,$0
; ritorna
	j	$31
	addiu	$sp,$sp,56 ; branch delay slot
