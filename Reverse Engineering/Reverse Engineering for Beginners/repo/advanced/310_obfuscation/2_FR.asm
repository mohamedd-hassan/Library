mov	esi, 1
...	; du code qui ne change pas ESI
dec	esi
...	; du code qui ne change pas ESI
cmp	esi, 0
jz	real_code
; fake code
real_code:
