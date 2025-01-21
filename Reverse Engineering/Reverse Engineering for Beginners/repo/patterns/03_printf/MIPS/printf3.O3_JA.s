$LC0:
	.ascii	"a=%d; b=%d; c=%d\000"
main:
; 関数プロローグ:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-32
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,28($sp)
; printf()のアドレスをロードする:
	lw	$25,%call16(printf)($28)
; テキスト文字列のアドレスをロードし、printf()の1番目の引数を設定する:
	lui	$4,%hi($LC0)
	addiu	$4,$4,%lo($LC0)
; printf()の2番目の引数を設定する:
	li	$5,1			# 0x1
; printf()の3番目の引数を設定する:
	li	$6,2			# 0x2
; printf()をコールする:
	jalr	$25
; printf()の4番目の引数を設定する (分岐遅延スロット):
	li	$7,3			# 0x3

; 関数エピローグ:
	lw	$31,28($sp)
; 戻り値に0を設定する:
	move	$2,$0
; リターン
	j	$31
	addiu	$sp,$sp,32 ; branch delay slot
