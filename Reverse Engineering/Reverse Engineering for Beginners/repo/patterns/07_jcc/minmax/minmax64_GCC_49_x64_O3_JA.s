my_max:
; RDI=A
; RSI=B
; AとBを比較
	cmp	rdi, rsi
; Bを戻り値としてRAXにコピー
	mov	rax, rsi
; A>=Bの場合、A(RDI)を戻り値としてRAXにコピー
; それ以外(A<B)では、アイドル命令
	cmovge	rax, rdi
	ret

my_min:
; RDI=A
; RSI=B
; AとBを比較
	cmp	rdi, rsi
; Bを戻り値としてRAXにコピー
	mov	rax, rsi
; A<=Bの場合、A(RDI)を戻り値としてRAXにコピー
; それ以外(A>B)では、アイドル命令
	cmovle	rax, rdi
	ret
