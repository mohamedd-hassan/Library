; RDI=adresse du tableau
; RSI=a
; RDX=b

get_by_coordinates1:
; étendre le signe sur 64-bit des valeurs 32-bit en entrée "a" et "b"
	movsx	rsi, esi
	movsx	rdx, edx
	lea	rax, [rdi+rsi*4]
; RAX=RDI+RSI*4=adresse du tableau+a*4
	movzx	eax, BYTE PTR [rax+rdx]
; AL=charger l'octet à l'adresse RAX+RDX=adresse du tableau+a*4+b
	ret

get_by_coordinates2:
	lea	eax, [rdx+rsi*4]
; RAX=RDX+RSI*4=b+a*4
	cdqe
	movzx	eax, BYTE PTR [rdi+rax]
; AL=charger l'octet à l'adresse RDI+RAX=adresse du tableau+b+a*4
	ret

get_by_coordinates3:
	sal	esi, 2
; ESI=a<<2=a*4
; étendre le signe sur 64-bit des valeurs 32-bit en entrée "a*4" et "b"
	movsx	rdx, edx
	movsx	rsi, esi
	add	rdi, rsi
; RDI=RDI+RSI=adresse du tableau+a*4
	movzx	eax, BYTE PTR [rdi+rdx]
; AL=charger l'octet à l'adresse RDI+RAX=adresse du tableau+a*4+b
	ret
