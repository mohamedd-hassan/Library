xor	esi, 011223344h	; inutile
add	esi, eax	; inutile
add	eax, ebx
mov	edx, eax	; inutile
shl	edx, 4		; inutile
mul	ecx
xor	esi, ecx	; inutile
