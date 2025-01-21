my_max PROC
; R0=A
; R1=B
; confronta A e B:
        CMP      r0,r1
; restituisci B al posto di A inserendo B in R0
; questa istruzione si attiva solo se A<=B (quindi, LE - Less or Equal)
; se l' istruzione non si attiva (cioè se A>B), 
; A è ancora nel registro R0
        MOVLE    r0,r1
        BX       lr
        ENDP

my_min PROC
; R0=A
; R1=B
; confronta A e B:
        CMP      r0,r1
; ritorna B al posto di A inserendo B in R0
; questa istruzione si attiva solo se A>=B (quindi, GE - Greater or Equal)
; se l'istruzione non si attiva (cioè A<B), 
; il valore A è ancora nel registro R0
        MOVGE    r0,r1
        BX       lr
        ENDP
