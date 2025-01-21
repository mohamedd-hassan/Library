str_trim:
	push	rbx
	mov	rbx, rdi
; RBX sera toujours "s"
	call	strlen
; tester si str\_len==0 et sortir si c'est la cas
	test	rax, rax
	je	.L9
	lea	rdx, [rax-1]
; RDX contiendra toujours la valeur str\_len-1, pas str\_len
; donc RDX est plutôt comme une variable sur l'index du buffer
	lea	rsi, [rbx+rdx]      ; RSI=s+str\_len-1
	movzx	ecx, BYTE PTR [rsi] ; charger le caractère
	test	cl, cl
	je	.L9                 ; sortir si c'est zéro
	cmp	cl, 10
	je	.L4
	cmp	cl, 13              ; \verb|sortir si ce n'est ni '\n' ni '\r'|
	jne	.L9
.L4:
; ceci est une instruction bizarre, nous voulons RSI=s-1 ici.
; c'est possible de l'obtenir avec MOV RSI, EBX / DEC RSI
; mais ce sont deux instructions au lieu d'une
	sub	rsi, rax
; RSI = s+str\_len-1-str\_len = s-1
; la boucle principale commence
.L12:
	test	rdx, rdx
; stocker zéro à l'adresse s-1+str\_len-1+1 = s-1+str\_len = s+str\_len-1
	mov	BYTE PTR [rsi+1+rdx], 0
; tester si str\_len-1==0. sortir si oui.
	je	.L9
	sub	rdx, 1                   ; équivalent à str\_len--
; charger le caractère suivant à l'adresse s+str\_len-1
	movzx	ecx, BYTE PTR [rbx+rdx]
	test	cl, cl                   ; est-ce zéro? sortir si oui
	je	.L9
	cmp	cl, 10                   ; \verb|est-ce '\n'?|
	je	.L12
	cmp	cl, 13                   ; \verb|est-ce '\r'?|
	je	.L12
.L9:
; renvoyer "s"
	mov	rax, rbx
	pop	rbx
	ret
