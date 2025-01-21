$LC0:
	.ascii	"Enter X:\000"
$LC1:
	.ascii	"%d\000"
$LC2:
	.ascii	"You entered %d...\012\000"
main:
; 関数プロローグ:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-40
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,36($sp)
; puts()を呼び出す:
	lw	$25,%call16(puts)($28)
	lui	$4,%hi($LC0)
	jalr	$25
	addiu	$4,$4,%lo($LC0) ; branch delay slot
; scanf()を呼び出す:
	lw	$28,16($sp)
	lui	$4,%hi($LC1)
	lw	$25,%call16(__isoc99_scanf)($28)
; scanf()の2番目の引数に \$a1=\$sp+24 を設定する:
	addiu	$5,$sp,24
	jalr	$25
	addiu	$4,$4,%lo($LC1) ; branch delay slot

; printf()を呼び出す:
	lw	$28,16($sp)
; printf()の2番目の引数を設定する, 
; アドレス\$sp+24にwordをロードする:
	lw	$5,24($sp)
	lw	$25,%call16(printf)($28)
	lui	$4,%hi($LC2)
	jalr	$25
	addiu	$4,$4,%lo($LC2) ; branch delay slot

; 関数エピローグ:
	lw	$31,36($sp)
; 戻り値に0を設定する:
	move	$2,$0
; return:
	j	$31
	addiu	$sp,$sp,40      ; branch delay slot
