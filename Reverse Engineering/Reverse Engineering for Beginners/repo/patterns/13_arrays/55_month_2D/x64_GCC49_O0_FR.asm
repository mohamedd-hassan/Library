get_month2:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR [rbp-4], edi
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
; RDX = valeur entrée avec signe étendu
	mov	rax, rdx
; RAX = mois
	sal	rax, 2
; RAX = mois<<2 = mois*4
	add	rax, rdx
; RAX = RAX+RDX = mois*4+mois = mois*5
	add	rax, rax
; RAX = RAX*2 = mois*5*2 = mois*10
	add	rax, OFFSET FLAT:month2
; RAX = mois*10 + pointeur sur la table
	pop	rbp
	ret
