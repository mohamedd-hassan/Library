f PROC
; confronta il valore in input con 10
        CMP      r0,#0xa
; se il risultato del confronto è uguale, copia il puntatore alla stringa "it is ten" in R0
        ADREQ    r0,|L0.16| ; "it is ten"
; se il risultato del confronto è diverso, copia il puntatore alla stringa 
; "it is not ten" in R0
        ADRNE    r0,|L0.28| ; "it is not ten"
        BX       lr
        ENDP

|L0.16|
        DCB      "it is ten",0
|L0.28|
        DCB      "it is not ten",0
