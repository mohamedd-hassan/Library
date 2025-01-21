put_to_array PROC
; R0 = idx
; R1 = val
        LSR      r2,r0,#1
; R2 = R0>>1 = idx>>1
; tester le bit le plus bas de idx et mettre les flags:
        TST      r0,#1
        LDR      r12,|array|
; R12 = adresse de array
        LSR      r0,r0,#1
; R0 = R0>>1 = idx>>1
        ADD      r0,r0,r0,LSL #1
; R0 = R0+R0<<1 = R0+R0*2 = R0*3 = (idx>>1)*3 = idx/2*3 = idx*1.5
        ADD      r3,r2,r2,LSL #1
; R3 = R2+R2<<1 = R2+R2*2 = R2*3 = (idx>>1)*3 = idx/2*3 = idx*1.5
        ADD      r0,r0,r12
; R0 = R0+R12 = idx*1.5 + array
; sauter si idx est pair:
        BEQ      |L0.56|
; idx is odd, go on:
; idx est impair, continuer:
; charger l'octet du milieu en R0+1:
        LDRB     r3,[r0,#1]
; R3 = octet du milieu
        AND      r3,r3,#0xf0
; \verb|R3 = R3&0xF0 = middle_byte&0xF0|
        ORR      r2,r3,r1,LSR #8
; \verb!R2 = R3 | R1>>8 = middle_byte&0xF0 | val>>8!
; \verb!stocker middle_byte&0xF0 | val>>8 en R0+1 (à la place de l'octet du milieu):!
	STRB     r2,[r0,#1]
; \verb|stocker es 8 bits bas de val (ou val&0xFF) en R0+2 (à la place de l'octet de droite):|
        STRB     r1,[r0,#2]
        BX       lr
|L0.56|
; idx est pair, continuer:
        LSR      r2,r1,#4
; R2 = R1>>4 = val>>4
; stocker val>>4 en R12+R3 ou array + idx*1.5 (place de l'octet de gauche):
        STRB     r2,[r12,r3]
; charger l'octet en R0+1 (octet du milieu):
        LDRB     r2,[r0,#1]
; \verb|R2 = middle_byte|
; supprimer les 4 bits hauts de l'octet du milieu:
        AND      r2,r2,#0xf
; \verb|R2 = R2&0xF = middle_byte&0xF|
; mettre à jour l'octet du milieu:
        ORR      r1,r2,r1,LSL #4
; \verb!R1 = R2 | R1<<4 = middle_byte&0xF | val<<4!
; stocker l'octet mis à jour en R0+1:
        STRB     r1,[r0,#1]
        BX       lr
ENDP

