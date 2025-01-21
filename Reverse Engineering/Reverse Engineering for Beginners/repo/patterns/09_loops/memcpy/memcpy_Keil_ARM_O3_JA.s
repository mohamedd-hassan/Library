my_memcpy PROC
; R0 = コピー先アドレス
; R1 = コピー元アドレス
; R2 = ブロックのサイズ

; カウンタ(i)を0で初期化
        MOV      r3,#0
|L0.4|
; 全バイトをコピーしたか
        CMP      r3,r2
; 以下のブロックは未満の条件を満たす場合のみ実行される
; R2<R3 または i<sizeなら
; R1+iのバイトをロードする:
        LDRBCC   r12,[r1,r3]
; バイトをR0+iに保存する
        STRBCC   r12,[r0,r3]
; i++
        ADDCC    r3,r3,#1
; \emph{conditional block}の最後の命令
; i<sizeならループの開始にジャンプ
; そうでなければ何もしない(i>=sizeなら)
        BCC      |L0.4|
; リターン
        BX       lr
        ENDP
