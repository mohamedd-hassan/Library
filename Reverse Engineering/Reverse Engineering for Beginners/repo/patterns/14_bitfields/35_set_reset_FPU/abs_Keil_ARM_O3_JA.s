my_abs PROC
; ビットをクリア
        BIC      r0,r0,#0x80000000
        BX       lr
        ENDP

set_sign PROC
; ORを実行
        ORR      r0,r0,#0x80000000
        BX       lr
        ENDP

negate PROC
; XORを実行
        EOR      r0,r0,#0x80000000
        BX       lr
        ENDP
