$LC0:
	.ascii	"a=%d; b=%d; c=%d; d=%d; e=%d; f=%d; g=%d; h=%d\012\000"
main:
; 関数プロローグ:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-56
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,52($sp)
; スタックに5番目の引数を渡す:
	li	$2,4			# 0x4
	sw	$2,16($sp)
; スタックに6番目の引数を渡す:
	li	$2,5			# 0x5
	sw	$2,20($sp)
; スタックに7番目の引数を渡す:
	li	$2,6			# 0x6
	sw	$2,24($sp)
; スタックに8番目の引数を渡す:
	li	$2,7			# 0x7
	lw	$25,%call16(printf)($28)
	sw	$2,28($sp)
; \$a0に1番目の引数を渡す: 
	lui	$4,%hi($LC0)
; スタックに9番目の引数を渡す:
	li	$2,8			# 0x8
	sw	$2,32($sp)
	addiu	$4,$4,%lo($LC0)
; \$a1に2番目の引数を渡す:
	li	$5,1			# 0x1
; \$a2に3番目の引数を渡す:
	li	$6,2			# 0x2
; printf()をコールする:
	jalr	$25
; \$a3に4番目の引数を渡す (分岐遅延スロット):
	li	$7,3			# 0x3

; 関数エピローグ:
	lw	$31,52($sp)
; 戻り値に0を設定する:
	move	$2,$0
; リターン
	j	$31
	addiu	$sp,$sp,56 ; branch delay slot
