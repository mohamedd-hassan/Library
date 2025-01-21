my_max:
; RDI=A
; RSI=B
; compare A and B:
	cmp	rdi, rsi
; prepare B in RAX for return:
	mov	rax, rsi
; if A>=B, put A (RDI) in RAX for return.
; this instruction is idle if otherwise (if A<B), and B is left in RAX
	cmovge	rax, rdi
	ret

my_min:
; RDI=A
; RSI=B
; compare A and B:
	cmp	rdi, rsi
; prepare B in RAX for return:
	mov	rax, rsi
; if A<=B, put A (RDI) in RAX for return.
; this instruction is idle if otherwise (if A>B), and B is left in RAX
	cmovle	rax, rdi
	ret
