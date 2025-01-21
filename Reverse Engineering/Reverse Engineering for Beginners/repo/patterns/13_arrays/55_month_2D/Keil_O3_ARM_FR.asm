; R0 = mois
        LDR      r1,|L0.104|
; R1 = pointeur sur la table
        ADD      r0,r0,r0,LSL #2
; R0 = R0+R0<<2 = R0+R0*4 = mois*5
        ADD      r0,r1,r0,LSL #1
; R0 = R1+R0<<2 = pointeur sur la table + mois*5*2 = pointeur sur la table + mois*10
        BX       lr
