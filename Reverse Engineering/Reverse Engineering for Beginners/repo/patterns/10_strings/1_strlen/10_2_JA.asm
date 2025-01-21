_str$ = 8			; size = 4
_strlen PROC
	mov	edx, DWORD PTR _str$[esp-4] ; 文字列へのポインタをEDXに置く
	mov	eax, edx                    ; EAXにコピー
$LL2@strlen:
	mov	cl, BYTE PTR [eax]          ; CL = *EAX
	inc	eax                         ; EAX++
	test	cl, cl                      ; CL==0か
	jne	SHORT $LL2@strlen           ; そうでなければ、ループを継続する
	sub	eax, edx                    ; ポインタの差分を計算する
	dec	eax                         ; EAXをデクリメントする
	ret	0
_strlen ENDP
