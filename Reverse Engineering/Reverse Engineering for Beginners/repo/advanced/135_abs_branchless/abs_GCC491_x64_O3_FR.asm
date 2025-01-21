my_abs:
	mov	edx, edi
	mov	eax, edi
	sar	edx, 31
; EDX contient ici 0xFFFFFFFF si le signe de la valeur en entrée est moins
; EDX contient 0 si le signe de la valeur en entrée est plus (0 inclus)
; les deux instructions suivantes ont un effet seulement si EDX contient 0xFFFFFFFF
; et aucun si EDX contient 0
	xor	eax, edx
	sub	eax, edx
	ret
