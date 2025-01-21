my_abs PROC
        CMP      r0,#0
; 入力値が0より小さい場合にのみ "逆引"命令を実行する
        RSBLT    r0,r0,#0
        BX       lr
        ENDP
