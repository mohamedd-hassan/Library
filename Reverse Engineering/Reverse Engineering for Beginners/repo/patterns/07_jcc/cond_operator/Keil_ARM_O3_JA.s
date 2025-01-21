f PROC
; 入力値と10を比較
        CMP      r0,#0xa
; 結果が同じか比較し同じなら、"it is ten"文字列へのポインタをR0にコピー
        ADREQ    r0,|L0.16| ; "it is ten"
; 結果が同じか比較し異なるなら、"it is not ten"文字列へのポインタをR0にコピー
        ADRNE    r0,|L0.28| ; "it is not ten"
        BX       lr
        ENDP

|L0.16|
        DCB      "it is ten",0
|L0.28|
        DCB      "it is not ten",0
