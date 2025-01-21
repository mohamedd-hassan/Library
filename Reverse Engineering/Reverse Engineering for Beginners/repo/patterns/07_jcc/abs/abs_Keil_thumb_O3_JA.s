my_abs PROC
        CMP      r0,#0
; 入力値はゼロに等しいかゼロより大きいか
; RSBS命令をスキップする
        BGE      |L0.6|
; 入力値を0から減算する
        RSBS     r0,r0,#0
|L0.6|
        BX       lr
        ENDP
