_a$ = 8		
_b$ = 12	
_my_min	PROC
	push	ebp
	mov	ebp, esp
	mov	eax, DWORD PTR _a$[ebp]
; AとBを比較
	cmp	eax, DWORD PTR _b$[ebp]
; AがB以上の場合にジャンプする
	jge	SHORT $LN2@my_min
; それ以外ではAをEAXにリロードして終了する
	mov	eax, DWORD PTR _a$[ebp]
	jmp	SHORT $LN3@my_min
	jmp	SHORT $LN3@my_min ; これは冗長なJMP命令
$LN2@my_min:
; Bをリターン
	mov	eax, DWORD PTR _b$[ebp]
$LN3@my_min:
	pop	ebp
	ret	0
_my_min	ENDP

_a$ = 8		
_b$ = 12	
_my_max	PROC
	push	ebp
	mov	ebp, esp
	mov	eax, DWORD PTR _a$[ebp]
; AとBを比較
	cmp	eax, DWORD PTR _b$[ebp]
; AがB以下の場合ジャンプする
	jle	SHORT $LN2@my_max
; それ以外ではAをEAXにリロードして終了する
	mov	eax, DWORD PTR _a$[ebp]
	jmp	SHORT $LN3@my_max
	jmp	SHORT $LN3@my_max ; これは冗長なJMP命令
$LN2@my_max:
; Bをリターン
	mov	eax, DWORD PTR _b$[ebp]
$LN3@my_max:
	pop	ebp
	ret	0
_my_max	ENDP
