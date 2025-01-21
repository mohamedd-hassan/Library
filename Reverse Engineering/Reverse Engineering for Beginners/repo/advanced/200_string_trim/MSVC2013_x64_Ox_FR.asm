s:$ = 8
str_trim PROC

; RCX est le premier argument de la fonction et il contient toujours un pointeur sur la chaîne
	mov	rdx, rcx
; ceci est la fonction strlen() inlined juste ici:
; mettre RAX à 0xFFFFFFFFFFFFFFFF (-1)
	or	rax, -1
$LL14@str_trim:
	inc	rax
	cmp	BYTE PTR [rcx+rax], 0
	jne	SHORT $LL14@str_trim
; est-ce que la chaîne en entrée est de longueur zéro? alors sortir:
	test	rax, rax
	je	SHORT $LN15@str_trim
; RAX contient la longueur de la chaîne
	dec	rcx
; RCX = s-1
	mov	r8d, 1
	add	rcx, rax
; RCX = s-1+strlen(s), i.e., ceci est l'adresse du dernier caractère de la chaîne
	sub	r8, rdx
; R8 = 1-s
$LL6@str_trim:
; charger le dernier caractère de la chaîne:
; sauter si son code est 13 ou 10:
	movzx	eax, BYTE PTR [rcx]
	cmp	al, 13
	je	SHORT $LN2@str_trim
	cmp	al, 10
	jne	SHORT $LN15@str_trim
$LN2@str_trim:
; le dernier caractère a un code de 13 ou 10
; écrire zéro à cet endroit:
	mov	BYTE PTR [rcx], 0
; décrémenter l'adresse du dernier caractère,
; donc il pointera sur le caractère précédent celui qui vient d'être effacé:
	dec	rcx
	lea	rax, QWORD PTR [r8+rcx]
; RAX = 1 - s + adresse du dernier caractère courant
; ainsi nous pouvons déterminer si nous avons atteint le premier caractère et
; nous devons arrêter, si c'est le cas
	test	rax, rax
	jne	SHORT $LL6@str_trim
$LN15@str_trim:
	mov	rax, rdx
	ret	0
str_trim ENDP
