; RCX = pointeur sur la chaîne en entrée
; RAX = longueur actuelle de la chaîne
	or	rax, -1
label:
	inc	rax
	cmp	BYTE PTR [rcx+rax], 0
	jne	SHORT label
; RAX = longueur de la chaîne
