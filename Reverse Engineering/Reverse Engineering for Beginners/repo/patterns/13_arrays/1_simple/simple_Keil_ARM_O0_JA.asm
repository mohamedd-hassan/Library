            EXPORT _main
_main
            STMFD   SP!, {R4,LR}
            SUB     SP, SP, #0x50    ; int変数20個分の場所を確保する

; 最初のループ

            MOV     R4, #0           ; i
            B       loc_4A0
loc_494                             
            MOV     R0, R4,LSL#1     ; R0=R4*2
            STR     R0, [SP,R4,LSL#2]; R0にSP+R4<<2 (SP+R4*4と同様)を保存
            ADD     R4, R4, #1       ; i=i+1

loc_4A0                             
            CMP     R4, #20          ; i<20?
            BLT     loc_494          ; 条件を満たすなら、ループボディを再度実行する

; 2番目のループ

            MOV     R4, #0           ; i
            B       loc_4C4
loc_4B0                             
            LDR     R2, [SP,R4,LSL#2]; (printfの第二引数) R2=*(SP+R4<<4) (*(SP+R4*4)と同様)
            MOV     R1, R4           ; (printfの第一引数) R1=i
            ADR     R0, aADD         ; "a[\%d]=\%d\textbackslash{}n"
            BL      __2printf
            ADD     R4, R4, #1       ; i=i+1

loc_4C4                             
            CMP     R4, #20          ; i<20?
            BLT     loc_4B0          ; 条件を満たすなら、ループボディを再度実行する
            MOV     R0, #0           ; 戻り値
            ADD     SP, SP, #0x50    ; 確保していたint変数20個分のチャンクを開放する
            LDMFD   SP!, {R4,PC}
