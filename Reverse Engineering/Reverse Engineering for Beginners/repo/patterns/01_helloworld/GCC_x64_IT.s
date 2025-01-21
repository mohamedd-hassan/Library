.string	"hello, world\n"
main:
	sub	rsp, 8
	mov	edi, OFFSET FLAT:.LC0 ; "hello, world\textbackslash{}n"
	xor	eax, eax  ; numbero dei registri vettore passati
	call	printf
	xor	eax, eax
	add	rsp, 8
	ret
