; R0 = month
        LDR      r1,|L0.104|
; R1 = テーブルへのポインタ
        ADD      r0,r0,r0,LSL #2
; R0 = R0+R0<<2 = R0+R0*4 = month*5
        ADD      r0,r1,r0,LSL #1
; R0 = R1+R0<<2 = テーブルへのポインタ + month*5*2 = テーブルへのポインタ + month*10
        BX       lr
