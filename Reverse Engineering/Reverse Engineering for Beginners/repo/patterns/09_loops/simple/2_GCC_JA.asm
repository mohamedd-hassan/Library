                public main
main            proc near

var_20          = dword ptr -20h

                push    ebp
                mov     ebp, esp
                and     esp, 0FFFFFFF0h
                push    ebx
                mov     ebx, 2    ; i=2
                sub     esp, 1Ch

; ラベルloc\_80484D0（ループボディの開始場所）を16バイト境界でアラインメント
                nop

loc_80484D0:
; (i)を第一引数としてprinting\_function()に渡す
                mov     [esp+20h+var_20], ebx 
                add     ebx, 1    ; i++
                call    printing_function
                cmp     ebx, 64h  ; i==100か?
                jnz     short loc_80484D0 ; そうでなければ継続
                add     esp, 1Ch
                xor     eax, eax  ; 0をリターン
                pop     ebx
                mov     esp, ebp
                pop     ebp
                retn
main            endp
