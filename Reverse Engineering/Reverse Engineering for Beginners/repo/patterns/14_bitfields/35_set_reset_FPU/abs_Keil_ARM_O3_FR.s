my_abs PROC
; effacer bit:
        BIC      r0,r0,#0x80000000
        BX       lr
        ENDP

set_sign PROC
; faire OR:
        ORR      r0,r0,#0x80000000
        BX       lr
        ENDP

negate PROC
; faire XOR:
        EOR      r0,r0,#0x80000000
        BX       lr
        ENDP
