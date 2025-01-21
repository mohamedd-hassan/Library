i$ = 8
my_abs	PROC
; ECX = input
	test	ecx, ecx
; 入力値の符号をチェックする
; 符号が正の場合はNEG命令をスキップする
	jns	SHORT $LN2@my_abs
; 値を反転する
	neg	ecx
$LN2@my_abs:
; EAXに結果を準備
	mov	eax, ecx
	ret	0
my_abs	ENDP
