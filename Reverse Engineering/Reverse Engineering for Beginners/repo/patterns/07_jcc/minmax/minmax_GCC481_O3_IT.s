my_max:
	mov	edx, DWORD PTR [esp+4]
	mov	eax, DWORD PTR [esp+8]
; EDX=A
; EAX=B
; confronta A e B:
	cmp	edx, eax
; se A>=B, carica il valore di A in EAX
; altrimenti questa istruzione è inutile (se A<B)
	cmovge	eax, edx
	ret

my_min:
	mov	edx, DWORD PTR [esp+4]
	mov	eax, DWORD PTR [esp+8]
; EDX=A
; EAX=B
; confronta A e B:
	cmp	edx, eax
; se A<=B, carica il valore di A in EAX
; altrimenti questa istruzione è inutile (se A>B)
	cmovle	eax, edx
	ret
