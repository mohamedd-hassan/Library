get_from_array PROC
; R0 = idx
        PUSH     {r4,r5,lr}
        LSRS     r1,r0,#1
; R1 = R0>>1 = idx>>1
; R1 est maintenant le numéro du triplet
        LSLS     r2,r1,#1
; \verb|R2 = R1<<1 = (R0>>1)<<1 = R0&(~1) = idx&(~1)|
; l'opération (x>>1)<<1 semble inutile, mais elle sert à effacer le bit le plus bas dans x
; (ou idx)
        LSLS     r5,r0,#31
; R5 = R0<<31 = idx<<31
; ainsi, R5 contiendra 0x80000000 si idx est impair ou zéro s'il est pair
        ADDS     r4,r1,r2
; \verb|R4 = R1+R2 = idx>>1 + idx&(~1) = offset du triplet débute (ou offset de l'octet de gauche)|
; l'expression à l'air compliquée, mais elle équivaut à multiplier par 1,5
        LSRS     r0,r0,#1
; R0 = R0>>1 = idx>>1
; charger un pointeur sur array
        LDR      r3,|array|
; R3 = offset sur la table array
        LSLS     r1,r0,#1
; \verb|R1 = R0<<1 = (idx>>1)<<1 = idx&(~1)|
        ADDS     r0,r0,r1
; \verb|R0 = idx>>1 + idx&(~1) = idx*1.5 = début de l'offset sur le triplet|
        ADDS     r1,r3,r0
; R1 = R3+R0 = offset de array + idx*1.5
; autrement dit, R1 contient maintenant l'adresse absolue du triplet
; charger l'octet du milieu (à l'adresse R1+1):
        LDRB     r2,[r1,#1]
; R2 = octet du milieu
; enfin tester si idx est pair ou impair:
        CMP      r5,#0
; saut si pair:
        BEQ      |L0.92|
; idx est impair, continuer:
        LSLS     r0,r2,#28
; \verb|R0 = R2<<28 = middle_byte<<28|
; charger l'octet de droite en R1+2:
        LDRB     r1,[r1,#2]
; R1 = octet de droite
        LSRS     r0,r0,#20
; R0 = R0>>20 = (R2<<28)>>20
; ceci est la même chose que R2<<8, mais le compilateur Keil génère du code plus complexe
; afin d'effacer ceux après ces 4
        B        |L0.98|
|L0.92|
; idx est pair, continuer:
; charger l'octet de gauche. maintenant R3=array et R4=son adresse
        LDRB     r0,[r3,r4]
; R0 = octet de gauche
        LSLS     r0,r0,#4
; \verb|R0 = left_byte<<4|
; \verb|décaler middle_byte dans R2 de 4 bits à droite:|
        LSRS     r1,r2,#4
; \verb|R1=middle_byte>>4|
|L0.98|
; épilogue de la fonction:
; la valeur courante de R0 est la partie de l'octet de gauche décalée ou l'octet du milieu
; R1 est la partie de l'octet du milieu décalée ou l'octet de droite
; maintenant fusionner les valeurs et laisser le résultat dans R0:
        ORRS     r0,r0,r1
; R0 = R0|R1
        POP      {r4,r5,pc}
        ENDP

