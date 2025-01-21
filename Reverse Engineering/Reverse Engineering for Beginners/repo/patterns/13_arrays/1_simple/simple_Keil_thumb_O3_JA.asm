_main
          PUSH    {R4,R5,LR}
; int変数20個分+1変数の場所を確保する
          SUB     SP, SP, #0x54   

; 最初のループ
          MOVS    R0, #0      ; i
          MOV     R5, SP      ; 配列要素の先頭へのポインタ

loc_1CE                       
          LSLS    R1, R0, #1  ; R1=i<<1 (i*2と同様)
          LSLS    R2, R0, #2  ; R2=i<<2 (i*4と同様)
          ADDS    R0, R0, #1  ; i=i+1
          CMP     R0, #20     ; i<20?
          STR     R1, [R5,R2] ; R1を*(R5+R2)に保存 (R5+i*4と同じ)
          BLT     loc_1CE     ; 条件を満たすなら、ループボディを再度実行する

; 2番目のループ

          MOVS    R4, #0      ; i=0
loc_1DC                       
          LSLS    R0, R4, #2  ; R0=i<<2 (i*4と同様)
          LDR     R2, [R5,R0] ; *(R5+R0)からロード (R5+i*4と同様)
          MOVS    R1, R4
          ADR     R0, aADD    ; "a[\%d]=\%d\textbackslash{}n"
          BL      __2printf
          ADDS    R4, R4, #1  ; i=i+1
          CMP     R4, #20     ; i<20?
          BLT     loc_1DC     ; 条件を満たすなら、ループボディを再度実行する
          MOVS    R0, #0      ; 戻り値
; 確保していたint変数20個+1分のチャンクを開放する
          ADD     SP, SP, #0x54   
          POP     {R4,R5,PC}
