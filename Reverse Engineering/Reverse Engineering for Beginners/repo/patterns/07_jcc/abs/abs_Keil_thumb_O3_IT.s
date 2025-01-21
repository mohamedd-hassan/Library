my_abs PROC
        CMP      r0,#0
; il valore in input è maggiore o uguale a zero?
; allora salta l'istruzione RSBS
        BGE      |L0.6|
; sottrai a 0 il valore di input:
        RSBS     r0,r0,#0
|L0.6|
        BX       lr
        ENDP
