put_to_array PROC
        PUSH     {r4,r5,lr}
; R0 = idx
; R1 = val
        LSRS     r2,r0,#1
; R2 = R0>>1 = idx>>1
        LSLS     r3,r2,#1
; \verb|R3 = R2<<1 = (idx>>1)<<1 = idx&(~1)|
        LSLS     r4,r0,#31
; R4 = R0<<31 = idx<<31
        ADDS     r3,r2,r3
; \verb|R3 = R2+R3 = idx>>1 + idx&(~1) = idx*1.5|
        LSRS     r0,r0,#1
; R0 = R0>>1 = idx>>1
        LDR      r2,|array|
; R2 = adresse de array
        LSLS     r5,r0,#1
; \verb|R5 = R0<<1 = (idx>>1)<<1 = idx&(~1)|
        ADDS     r0,r0,r5
; \verb|R0 = R0+R5 = idx>>1 + idx&(~1) = idx*1.5|
        ADDS     r0,r2,r0
; R0 = R2+R0 = array + idx*1.5, autrement dit, c'est l'adresse du triplet
; enfin tester le plus petit bit décalé dans idx:
        CMP      r4,#0
; saut si idx est pair:
        BEQ      |L0.40|
; idx est impair, continuer:
; charger l'octet du milieu en R0+1:
        LDRB     r3,[r0,#1]
; \verb|R3 = middle_byte|
        LSRS     r2,r1,#8
; R2 = R1>>8 = val>>8
        LSRS     r3,r3,#4
; \verb|R3 = R3>>4 = middle_byte>>4|
        LSLS     r3,r3,#4
; \verb|R3 = R3<<4 = (middle_byte>>4)<<4|
; \verb|ces deux opérations de décalage sont utilisées pour supprimer les 4 bits bas dans middle_byte|
; fusionner les 4 bits haut dans l'octet du milieu (dans R3) avec val>>8 (dans R2):
        ORRS     r3,r3,r2
; R3 = octet du milieu mis à jour
; le stocker dans R0+1
        STRB     r3,[r0,#1]
; \verb|stocker les 8 bits bas de val (val&0xFF) dans R0+2:|
        STRB     r1,[r0,#2]
        POP      {r4,r5,pc}
|L0.40|
; idx est pair, continuer:
        LSRS     r4,r1,#4
; R4 = R1>>4 = val>>4
; stocker val>>4 en R2+R3 (adresse de l'octet de gauche ou début du triplet):
        STRB     r4,[r2,r3]
; charger l'octet du milieu en R0+1:
        LDRB     r3,[r0,#1]
; R3 = octet du milieu
        LSLS     r2,r1,#4
; R2 = R1<<4 = val<<4
        LSLS     r1,r3,#28
; \verb|R1 = R3<<28 = middle_byte<<28|
        LSRS     r1,r1,#28
; \verb|R1 = R1>>28 = (middle_byte<<28)>>28|
; ces deux opérations de décalage sont utilisées pour supprimer tous les bits dans
; le registre exceptés les 4 les plus bas
; fusionner les 4 bits bas (dans R1) et val<<4 (dans R2):
        ORRS     r1,r1,r2
; le stocker en R0+1:
        STRB     r1,[r0,#1]
        POP      {r4,r5,pc}
        ENDP

