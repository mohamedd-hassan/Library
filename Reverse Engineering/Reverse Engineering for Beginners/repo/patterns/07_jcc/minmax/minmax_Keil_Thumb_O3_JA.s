my_max PROC
; R0=A
; R1=B
; AとBを比較
        CMP      r0,r1
; AがBより大きければ分岐
        BGT      |L0.6|
; それ以外(A<=B)の場合は、R1(B)をリターン
        MOVS     r0,r1
|L0.6|
; リターン
        BX       lr
        ENDP

my_min PROC
; R0=A
; R1=B
; AとBを比較
        CMP      r0,r1
; AがBより小さければ分岐
        BLT      |L0.14|
; それ以外(A>=B)の場合は、R1(B)をリターン
        MOVS     r0,r1
|L0.14|
; リターン
        BX       lr
        ENDP
