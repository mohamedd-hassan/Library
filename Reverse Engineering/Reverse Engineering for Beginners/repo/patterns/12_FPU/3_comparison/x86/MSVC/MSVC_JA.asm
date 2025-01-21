PUBLIC    _d_max
_TEXT    SEGMENT
_a$ = 8                ; size = 8
_b$ = 16               ; size = 8
_d_max     PROC
    push   ebp
    mov    ebp, esp
    fld    QWORD PTR _b$[ebp]

; 現在のスタック状態: ST(0) = \_b
; \_b (ST(0))と\_aを比較し、レジスタをポップ
    fcomp  QWORD PTR _a$[ebp] 

; スタックは空

    fnstsw ax
    test   ah, 5
    jp     SHORT $LN1@d_max

; a>bの場合のみここに来ます

    fld    QWORD PTR _a$[ebp]
    jmp    SHORT $LN2@d_max
$LN1@d_max:
    fld    QWORD PTR _b$[ebp]
$LN2@d_max:
    pop    ebp
    ret    0
_d_max     ENDP
