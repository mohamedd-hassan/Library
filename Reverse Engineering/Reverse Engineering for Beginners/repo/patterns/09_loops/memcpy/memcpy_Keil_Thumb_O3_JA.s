my_memcpy PROC
; R0 = コピー先アドレス
; R1 = コピー元アドレス
; R2 = ブロックのサイズ

        PUSH     {r4,lr}
; カウンタ(i)を0で初期化
        MOVS     r3,#0
; 関数の終わりで条件がチェックされ、ジャンプする
        B        |L0.12|
|L0.6|
; R1+iのバイトをロードする:
        LDRB     r4,[r1,r3]
; バイトをR0+iに保存する
        STRB     r4,[r0,r3]
; i++
        ADDS     r3,r3,#1
|L0.12|
; i<size？
        CMP      r3,r2
; もしそうならループ開始にジャンプする
        BCC      |L0.6|
        POP      {r4,pc}
        ENDP
