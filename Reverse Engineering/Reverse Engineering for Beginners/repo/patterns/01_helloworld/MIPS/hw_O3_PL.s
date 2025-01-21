$LC0:
; \textbackslash{}000 to bajt zero w systemie ósemkowym:
	.ascii	"Hello, world!\012\000"
main:
; prolog funkcji
; ustaw GP:
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-32
	addiu	$28,$28,%lo(__gnu_local_gp)
; odłóż RA na stos lokalny:
	sw	$31,28($sp)
; załaduj adres funkcji puts() z GP do \$25:
	lw	$25,%call16(puts)($28)
; załaduj adres łańcucha znaków do \$4 (\$a0):
	lui	$4,%hi($LC0)
; skocz do puts(), zapisując adres powrotu do rejestru powrotu:
	jalr	$25
	addiu	$4,$4,%lo($LC0) ; branch delay slot
; przywróć RA:
	lw	$31,28($sp)
; skopiuj 0 z \$zero do \$v0:
	move	$2,$0
; zwróć sterowanie, skacząc pod adres w RA:
	j	$31
; epilog funkcji:
	addiu	$sp,$sp,32 ; branch delay slot + posprzątaj stos lokalny

