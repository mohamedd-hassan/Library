$LC0:
	.ascii	"Hello, world!\012\000"
main:
; prolog funkcji
; odłóż RA (\$31) i FP na stos:
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
; ustaw FP (stack frame pointer):
	move	$fp,$sp
; ustaw GP:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
; załaduj adres łańcucha znaków
	lui	$2,%hi($LC0)
	addiu	$4,$2,%lo($LC0)
; załaduj adres funkcji puts() z GP:
	lw	$2,%call16(puts)($28)
	nop
; wywołaj puts():
	move	$25,$2
	jalr	$25
	nop  ; branch delay slot

; przywróć GP ze stosu lokalnego:
	lw	$28,16($fp)
; ustaw rejestr \$2 (\$V0) na zero:
	move	$2,$0
; epilog funkcji.
; przywróć SP:
	move	$sp,$fp
; przywróć RA:
	lw	$31,28($sp)
; przywróć FP:
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
; skok pod adres z RA:
	j	$31
	nop  ; branch delay slot
