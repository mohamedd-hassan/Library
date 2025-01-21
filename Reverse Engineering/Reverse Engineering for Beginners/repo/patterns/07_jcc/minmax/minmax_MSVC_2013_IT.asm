_a$ = 8		
_b$ = 12	
_my_min	PROC
	push	ebp
	mov	ebp, esp
	mov	eax, DWORD PTR _a$[ebp]
; confronta A e B:
	cmp	eax, DWORD PTR _b$[ebp]
; se A è maggiore o uguale a B, salta:
	jge	SHORT $LN2@my_min
; altrimenti ricarica A in EAX EAX e salta a exit
	mov	eax, DWORD PTR _a$[ebp]
	jmp	SHORT $LN3@my_min
	jmp	SHORT $LN3@my_min ; questo JMP è rindondante
$LN2@my_min:
; ritorna B
	mov	eax, DWORD PTR _b$[ebp]
$LN3@my_min:
	pop	ebp
	ret	0
_my_min	ENDP

_a$ = 8		
_b$ = 12	
_my_max	PROC
	push	ebp
	mov	ebp, esp
	mov	eax, DWORD PTR _a$[ebp]
; confronta A e B:
	cmp	eax, DWORD PTR _b$[ebp]
; se A è minore o uguale a B, salta:
	jle	SHORT $LN2@my_max
; altrimenti ricarica A in EAX e salta a exit
	mov	eax, DWORD PTR _a$[ebp]
	jmp	SHORT $LN3@my_max
	jmp	SHORT $LN3@my_max ; questo JMP è rindondante
$LN2@my_max:
; ritorna B
	mov	eax, DWORD PTR _b$[ebp]
$LN3@my_max:
	pop	ebp
	ret	0
_my_max	ENDP
