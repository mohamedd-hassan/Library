_fmt$ = 8
_die	PROC
	; charger le 1er argument (format-string)
	mov	ecx, DWORD PTR _fmt$[esp-4]
	; obtenir un pointeur sur le 2nd argument
	lea	eax, DWORD PTR _fmt$[esp]
	push	eax 		; passer un pointeur
	push	ecx
	call	_vprintf
	add	esp, 8
	push	0
	call	_exit
$LN3@die:
	int	3
_die	ENDP
