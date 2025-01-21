my_max:
	mov	edx, DWORD PTR [esp+4]
	mov	eax, DWORD PTR [esp+8]
; EDX=A
; EAX=B
; AとBを比較
	cmp	edx, eax
; A>=Bなら、Aの値をEAXにロード
; それ以外(A<B)の場合は、アイドル命令
	cmovge	eax, edx
	ret

my_min:
	mov	edx, DWORD PTR [esp+4]
	mov	eax, DWORD PTR [esp+8]
; EDX=A
; EAX=B
; AとBを比較
	cmp	edx, eax
; A<=Bなら、Aの値をEAXにロード
; それ以外(A>B)の場合は、アイドル命令
	cmovle	eax, edx
	ret
