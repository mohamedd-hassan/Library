$LC0:
	.ascii	"a=%d; b=%d; c=%d; d=%d; e=%d; f=%d; g=%d; h=%d\012\000"
main:
; prologo funzione:
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
	lui	$2,%hi($LC0)
	addiu	$2,$2,%lo($LC0)
; passa il 5° argomento nello stack:
	li	$3,4			# 0x4
	sw	$3,16($sp)
; passa il 6° argomento nello stack:
	li	$3,5			# 0x5
	sw	$3,20($sp)
; passa il 7° argomento nello stack:
	li	$3,6			# 0x6
	sw	$3,24($sp)
; passa l' 8° argomento nello stack:
	li	$3,7			# 0x7
	sw	$3,28($sp)
; passa il 9° argomento nello stack:
	li	$3,8			# 0x8
	sw	$3,32($sp)
; passa il  1° argomento in \$a0: 
	move	$4,$2
; passa il 2° argomento in \$a1:
	li	$5,1			# 0x1
; passa il 3° argomento in \$a2:
	li	$6,2			# 0x2
; passa il 4° argomento in \$a3:
	li	$7,3			# 0x3
; chiama printf():
	lw	$2,%call16(printf)($28)
	nop
	move	$25,$2
	jalr	$25
	nop
; epilogo funzione:
	lw	$28,40($fp)
; imposta il valore di ritorno a 0:
	move	$2,$0
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
; ritorna
	j	$31
	nop
