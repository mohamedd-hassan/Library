.string	"hello, world\n"
main:
	sub	rsp, 8
	mov	edi, OFFSET FLAT:.LC0 ; "hello, world\textbackslash{}n"
	xor	eax, eax  ; liczba użytych rejestrów wektorowych \XMM{0}-\XMM{7}
	call	printf
	xor	eax, eax
	add	rsp, 8
	ret
