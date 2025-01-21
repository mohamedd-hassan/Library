CONST    SEGMENT
__real@4010666666666666 DQ 04010666666666666r    ; 4.1
CONST    ENDS
CONST    SEGMENT
__real@40091eb851eb851f DQ 040091eb851eb851fr    ; 3.14
CONST    ENDS
_TEXT    SEGMENT
_a$ = 8           ; size = 8
_b$ = 16          ; size = 8
_f  PROC
    push   ebp
    mov    ebp, esp
    fld    QWORD PTR _a$[ebp]

; 現在のスタック状態: ST(0) = \_a

    fdiv   QWORD PTR __real@40091eb851eb851f

; 現在のスタック状態: ST(0) = \_aを3.14で割った結果

    fld    QWORD PTR _b$[ebp]

; 現在のスタック状態: ST(0) = \_b;
; ST(1) = \_aを3.14で割った結果

    fmul   QWORD PTR __real@4010666666666666

; 現在のスタック状態: 
; ST(0) = \_b * 4.1の結果; 
; ST(1) = \_aを3.14で割った結果

    faddp  ST(1), ST(0)

; 現在のスタック状態: ST(0) = 加算の結果

    pop    ebp
    ret    0
_f  ENDP
