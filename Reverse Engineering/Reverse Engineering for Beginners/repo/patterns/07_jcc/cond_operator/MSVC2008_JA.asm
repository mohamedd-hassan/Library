$SG746	DB	'it is ten', 00H
$SG747	DB	'it is not ten', 00H

tv65 = -4 ; this will be used as a temporary variable
_a$ = 8	
_f	PROC
	push	ebp
	mov	ebp, esp
	push	ecx
; 入力値と10を比較
	cmp	DWORD PTR _a$[ebp], 10
; 同じでなければ、\$LN3@fにジャンプ
	jne	SHORT $LN3@f
; 文字列へのポインタを一時変数に保存
	mov	DWORD PTR tv65[ebp], OFFSET $SG746 ; 'it is ten'
; exitにジャンプ
	jmp	SHORT $LN4@f
$LN3@f:
; 文字列へのポインタを一時変数に保存
	mov	DWORD PTR tv65[ebp], OFFSET $SG747 ; 'it is not ten'
$LN4@f:
; exitです。文字列へのポインタを一時変数からEAXにコピー
	mov	eax, DWORD PTR tv65[ebp]
	mov	esp, ebp
	pop	ebp
	ret	0
_f	ENDP
