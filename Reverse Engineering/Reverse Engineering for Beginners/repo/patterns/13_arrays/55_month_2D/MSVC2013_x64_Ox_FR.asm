month2	DB	04aH
	DB	061H
	DB	06eH
	DB	075H
	DB	061H
	DB	072H
	DB	079H
	DB	00H
	DB	00H
	DB	00H
...

get_month2 PROC
; étendre le signe de l'argument en entrée sur 64-bit
	movsxd	rax, ecx
	lea	rcx, QWORD PTR [rax+rax*4]
; RCX=mois+mois*4=mois*5
	lea	rax, OFFSET FLAT:month2
; RAX=pointeur sur la table
	lea	rax, QWORD PTR [rax+rcx*2]
; RAX=pointeur sur la table + RCX*2=pointeur sur la table + mois*5*2=pointeur sur la table + mois*10
	ret	0
get_month2 ENDP
