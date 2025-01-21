f:
	xor	eax, eax	; la variable rt sera dans le registre EAX
	xor	ecx, ecx	; la variable i sera dans le registre ECX
.L3:
	mov	rsi, rdi	; charger la valeur en entrée
	lea	edx, [rax+1]	; EDX=EAX+1
; ici EDX est la \emph{nouvelle version de rt},
; qui sera écrite dans la variable rt, si le dernier bit est à 1
	shr	rsi, cl		; RSI=RSI>>CL
	and	esi, 1		; ESI=ESI\&1
; est-ce que le dernier bit est 1? Si oui, écrire la \emph{nouvelle version de rt} dans EAX
	cmovne	eax, edx
	add	rcx, 1		; RCX++
	cmp	rcx, 64
	jne	.L3
	rep ret			; AKA fatret
