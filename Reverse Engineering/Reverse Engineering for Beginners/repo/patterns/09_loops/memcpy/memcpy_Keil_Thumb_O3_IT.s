my_memcpy PROC
; R0 = indirizzo destinazione
; R1 = indirizzo sorgente
; R2 = dimensione del blocco

        PUSH     {r4,lr}
; inizializza il contatore (i) a 0
        MOVS     r3,#0
; condizione controllata alla fine della funzione, quindi salta li:
        B        |L0.12|
|L0.6|
; carica il byte a R1+i:
        LDRB     r4,[r1,r3]
; salva il byte a R0+i:
        STRB     r4,[r0,r3]
; i++
        ADDS     r3,r3,#1
|L0.12|
; i<size?
        CMP      r3,r2
; se è così, salta all' inizio del ciclo:
        BCC      |L0.6|
        POP      {r4,pc}
        ENDP
