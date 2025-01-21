; R0 = mois
        MOVS     r1,#0xa
; R1 = 10
        MULS     r0,r1,r0
; R0 = R1*R0 = 10*mois
        LDR      r1,|L0.68|
; R1 = pointer sur la table
        ADDS     r0,r0,r1
; R0 = R0+R1 = 10*mois + pointer sur la table
        BX       lr
