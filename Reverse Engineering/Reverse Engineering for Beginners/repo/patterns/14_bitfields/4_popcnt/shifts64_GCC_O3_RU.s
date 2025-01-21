f:
	xor	eax, eax	; переменная rt будет находиться в регистре EAX
	xor	ecx, ecx	; переменная i будет находиться в регистре ECX
.L3:
	mov	rsi, rdi	; загрузить входное значение
	lea	edx, [rax+1]	; EDX=EAX+1
; EDX здесь это \emph{новая версия rt}, 
; которая будет записана в переменную rt, если последний бит был 1
	shr	rsi, cl		; RSI=RSI>>CL
	and	esi, 1		; ESI=ESI\&1
; последний бит был 1? Тогда записываем \emph{новую версию rt} в EAX
	cmovne	eax, edx
	add	rcx, 1		; RCX++
	cmp	rcx, 64
	jne	.L3
	rep ret			; AKA fatret
