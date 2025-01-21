month$ = 8
get_month2 PROC
	mov	DWORD PTR [rsp+8], ecx
	movsxd	rax, DWORD PTR month$[rsp]
; RAX = 符号拡張された入力値を64ビット値に
	imul	rax, rax, 10
; RAX = RAX*10
	lea	rcx, OFFSET FLAT:month2
; RCX = テーブルへのポインタ
	add	rcx, rax
; RCX = RCX+RAX = テーブルへのポインタ +month*10
	mov	rax, rcx
; RAX = テーブルへのポインタ +month*10
	mov	ecx, 1
; RCX = 1
	imul	rcx, rcx, 0
; RCX = 1*0 = 0
	add	rax, rcx
; RAX = テーブルへのポインタ +month*10 + 0 = テーブルへのポインタ +month*10
	ret	0
get_month2 ENDP

