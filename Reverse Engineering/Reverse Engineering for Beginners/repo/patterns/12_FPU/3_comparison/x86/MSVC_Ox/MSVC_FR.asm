_a$ = 8                ; size = 8
_b$ = 16               ; size = 8
_d_max    PROC
    fld    QWORD PTR _b$[esp-4]
    fld    QWORD PTR _a$[esp-4]

; état courant de la pile: ST(0) = \_a, ST(1) = \_b

    fcom    ST(1) ; comparer \_a et ST(1) = (\_b)
    fnstsw  ax
    test    ah, 65 ; 00000041H
    jne     SHORT $LN5@d_max
; copier ST(0) dans ST(1) et dépiler le registre,
; laisser (\_a) au sommet
    fstp    ST(1)

; état courant de la pile: ST(0) = \_a

    ret    0
$LN5@d_max:
; copier ST(0) dans ST(0) et dépiler le registre,
; laisser (\_b) au sommet
    fstp    ST(0)

; état courant de la pile: ST(0) = \_b

    ret    0
_d_max    ENDP
