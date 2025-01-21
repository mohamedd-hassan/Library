month$ = 8
get_month2 PROC
	mov	DWORD PTR [rsp+8], ecx
	movsxd	rax, DWORD PTR month$[rsp]
; RAX = étendre le signe de la valeur entrée sur 64-bit
	imul	rax, rax, 10
; RAX = RAX*10
	lea	rcx, OFFSET FLAT:month2
; RCX = pointeur sur la table
	add	rcx, rax
; RCX = RCX+RAX = pointeur sur la table+mois*10
	mov	rax, rcx
; RAX = pointeur sur la table+mois*10
	mov	ecx, 1
; RCX = 1
	imul	rcx, rcx, 0
; RCX = 1*0 = 0
	add	rax, rcx
; RAX = pointeur sur la table+mois*10 + 0 = pointeur sur la table+mois*10
	ret	0
get_month2 ENDP

