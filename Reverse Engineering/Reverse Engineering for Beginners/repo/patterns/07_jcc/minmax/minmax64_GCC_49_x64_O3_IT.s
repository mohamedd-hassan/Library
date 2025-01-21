my_max:
; RDI=A
; RSI=B
; confronta A e B:
	cmp	rdi, rsi
; carica B in RAX per ritornarlo:
	mov	rax, rsi
; se A>=B, carica  A (RDI) in RAX per ritornarlo.
; altrimenti questa istruzione è inutile (se A<B)
	cmovge	rax, rdi
	ret

my_min:
; RDI=A
; RSI=B
; confronta A e B:
	cmp	rdi, rsi
; carica B in RAX per ritornarlo:
	mov	rax, rsi
; se  A<=B, carica A (RDI) in RAX per ritornarlon.
; altrimenti questa istruzione è inutile (se A>B)
	cmovle	rax, rdi
	ret
