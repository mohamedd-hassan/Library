$LC0:
	.ascii	"a=%d; b=%d; c=%d\000"
main:
; 関数プロローグ:
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
; テキスト文字列のアドレスをロードする:
	lui	$2,%hi($LC0)
	addiu	$2,$2,%lo($LC0)
; printf()の1番目の引数を設定する:
	move	$4,$2
; printf()の2番目の引数を設定する:
	li	$5,1			# 0x1
; printf()の3番目の引数を設定する:
	li	$6,2			# 0x2
; printf()の4番目の引数を設定する:
	li	$7,3			# 0x3
; printf()のアドレスを取得する:
	lw	$2,%call16(printf)($28)
	nop
; printf()をコールする:
	move	$25,$2
	jalr	$25
	nop

; 関数エピローグ:
	lw	$28,16($fp)
; 戻り値に0を設定する:
	move	$2,$0
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
; リターン
	j	$31
	nop
