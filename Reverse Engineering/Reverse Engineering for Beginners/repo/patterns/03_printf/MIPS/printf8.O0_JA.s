$LC0:
	.ascii	"a=%d; b=%d; c=%d; d=%d; e=%d; f=%d; g=%d; h=%d\012\000"
main:
; 関数プロローグ:
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
	lui	$2,%hi($LC0)
	addiu	$2,$2,%lo($LC0)
; スタックに5番目の引数を渡す:
	li	$3,4			# 0x4
	sw	$3,16($sp)
; スタックに6番目の引数を渡す:
	li	$3,5			# 0x5
	sw	$3,20($sp)
; スタックに7番目の引数を渡す:
	li	$3,6			# 0x6
	sw	$3,24($sp)
; スタックに8番目の引数を渡す:
	li	$3,7			# 0x7
	sw	$3,28($sp)
; スタックに9番目の引数を渡す:
	li	$3,8			# 0x8
	sw	$3,32($sp)
; \$a0に1番目の引数を渡す: 
	move	$4,$2
; \$a1に2番目の引数を渡す:
	li	$5,1			# 0x1
; \$a2に3番目の引数を渡す:
	li	$6,2			# 0x2
; \$a3に4番目の引数を渡す:
	li	$7,3			# 0x3
; printf()をコールする:
	lw	$2,%call16(printf)($28)
	nop
	move	$25,$2
	jalr	$25
	nop
; 関数エピローグ:
	lw	$28,40($fp)
; 戻り値に0を設定する:
	move	$2,$0
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
; リターン
	j	$31
	nop
