__real@3f800000 DD 03f800000r	; 1

tv128 = -4
_tmp$ = -4
?float_rand@@YAMXZ PROC
	push	ecx
	call	?my_rand@@YAIXZ
; EAX=valeur pseudo-aléatoire
	and	eax, 8388607	; 007fffffH
	or	eax, 1065353216	; 3f800000H
; EAX=valeur pseudo-aléatoire \& 0x007fffff | 0x3f800000
; la stocker dans la pile locale:
	mov	DWORD PTR _tmp$[esp+4], eax
; la recharger comme un nombre à virgule flottante:
	movss	xmm0, DWORD PTR _tmp$[esp+4]
; soustraire 1.0:
	subss	xmm0, DWORD PTR __real@3f800000
; mettre la valeur dans ST0 en la plaçant dans une variable temporaire...
	movss	DWORD PTR tv128[esp+4], xmm0
; ... et en la rechargeant dans ST0:
	fld	DWORD PTR tv128[esp+4]
	pop	ecx
	ret	0
?float_rand@@YAMXZ ENDP
