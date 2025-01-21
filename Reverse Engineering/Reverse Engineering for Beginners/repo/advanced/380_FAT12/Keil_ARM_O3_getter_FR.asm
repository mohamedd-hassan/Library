get_from_array PROC
; R0 = idx
        LSR      r1,r0,#1
; R1 = R0>>1 = idx>>1
; tester le bit le plus bas dans idx et mettre les flags:
        TST      r0,#1
        ADD      r2,r1,r1,LSL #1
; R2 = R1+R1<<1 = R1+R1*2 = R1*3
; grâce au suffixe de décalage, une seule instruction en mode ARM peut multiplier par 3
        LDR      r1,|array|
; R1 = adresse de array
        LSR      r0,r0,#1
; R0 = R0>>1 = idx>>1
        ADD      r0,r0,r0,LSL #1
; R0 = R0+R0<<1 = R0+R0*2 = R0*3 = (idx>>1)*3 = idx*1.5
        ADD      r0,r0,r1
; R0 = R0+R1 = array + idx*1.5, ceci est l'adresse absolue du triplet
; charger l'octet du milieu en R0+1:
        LDRB     r3,[r0,#1]
; R3 = octet du milieu

; les 3 instructions suivantes sont exécutées si l'index est impair, autrement elles sont sautées:
; charger l'octet de droite en R0+2:
        LDRBNE   r0,[r0,#2]
; R0 = octet de droite
        ANDNE    r1,r3,#0xf
; \verb|R1 = R3&0xF = middle_byte&0xF|
        ORRNE    r0,r0,r1,LSL #8
; R0 = R0|(R1<<8) = right\_byte | (middle\_byte\&0xF)<<8
; ceci est le résultat renvoyé

; les 3 instructions suivantes sont exécutées si l'index est pair, autrement elles sont sautées:
; charger en R1+R2 = array + (idx>>1)*3 = array + idx*1.5
        LDRBEQ   r0,[r1,r2]
; R0 = octet de gauche
        LSLEQ    r0,r0,#4
; \verb|R0 = R0<<4 = left_byte << 4|
        ORREQ    r0,r0,r3,LSR #4
; R0 = R0 | R3>>4 = left\_byte << 4 | middle\_byte >> 4
; ceci est le résultat renvoyé
        BX       lr
        ENDP
