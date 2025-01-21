my_memcpy PROC
; R0 = indirizzo destinazione
; R1 = indirizzo sorgente
; R2 = dimensione del blocco

; inizializza il contatore (i) a 0
        MOV      r3,#0
|L0.4|
; sono stati copiati tutti i byte?
        CMP      r3,r2
; il seguente blocco è eseguito solo se la condizione è \emph{minore di},
; i.e., se R2<R3 o i<size.
; carica il byte a R1+i:
        LDRBCC   r12,[r1,r3]
; salva il byte a R0+i:
        STRBCC   r12,[r0,r3]
; i++
        ADDCC    r3,r3,#1
; l' ultima istruzione del \emph{blocco condizionale}.
; salta all' inizio del ciclo se i<size
; non fare niente altrimenti (i.e., if i>=size)
        BCC      |L0.4|
; ritorna
        BX       lr
        ENDP
