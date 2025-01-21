fmt$ = 48
die	PROC
	; sauver les 4 premiers arguments dans le Shadow Space
	mov	QWORD PTR [rsp+8], rcx
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+24], r8
	mov	QWORD PTR [rsp+32], r9
	sub	rsp, 40
	lea	rdx, QWORD PTR fmt$[rsp+8] ; passer un pointeur sur le 1er argument
	; ici RCX pointe toujours sur le 1er argument (format-string) de die()
	; donc vprintf() va prendre son argument dans RCX
	call	vprintf
	xor	ecx, ecx
	call	exit
	int	3
die	ENDP
