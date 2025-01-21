my_abs PROC
        CMP      r0,#0
; esegui l'istruzione "Reverse Subtract" solo se 
; il valore di input è minore di 0:
        RSBLT    r0,r0,#0
        BX       lr
        ENDP
