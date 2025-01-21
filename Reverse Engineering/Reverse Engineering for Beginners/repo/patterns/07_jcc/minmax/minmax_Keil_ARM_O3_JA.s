my_max PROC
; R0=A
; R1=B
; AとBを比較
        CMP      r0,r1
; BをR0に入れて、AではなくBをリターン
; A<=Bのときにのみ、この命令は実行されます (つまり、 LE - Less or Equal)
; 命令が実行されない場合(A>Bのとき)、AはR0レジスタにあります。
        MOVLE    r0,r1
        BX       lr
        ENDP

my_min PROC
; R0=A
; R1=B
; AとBを比較
        CMP      r0,r1
; BをR0に入れて、AではなくBをリターン
; A>=Bのときにのみ、この命令は実行されます (つまり、 GE - Greater or Equal)
; 命令が実行されない場合(A<Bのとき)、AはR0レジスタにあります。
        MOVGE    r0,r1
        BX       lr
        ENDP
