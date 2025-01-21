my_max PROC
; R0=A
; R1=B
; confronta A e B:
        CMP      r0,r1
; se A è maggiore di B salta:
        BGT      |L0.6|
; altrimenti (A<=B) ritorna R1 (B):
        MOVS     r0,r1
|L0.6|
; ritorna
        BX       lr
        ENDP

my_min PROC
; R0=A
; R1=B
; confronta A e B:
        CMP      r0,r1
; se A è minore di B, salta:
        BLT      |L0.14|
; altrimenti (A>=B) ritorna R1 (B):
        MOVS     r0,r1
|L0.14|
; ritorna
        BX       lr
        ENDP
