?f@@YAXXZ PROC			; f
; Line 2
	push	ebp
	mov	ebp, esp
; Line 3
	call	?f@@YAXXZ	; f
; Line 4
	pop	ebp
	ret	0
?f@@YAXXZ ENDP			; f
