                public main
main            proc near

var_20          = dword ptr -20h

                push    ebp
                mov     ebp, esp
                and     esp, 0FFFFFFF0h
                push    ebx
                mov     ebx, 2    ; i=2
                sub     esp, 1Ch

; allinea la label loc\_80484D0 (inizio del corpo del ciclo) con un bordo di 16-byte:
                nop

loc_80484D0:
; passa (i) come primo argomento a printing\_function():
                mov     [esp+20h+var_20], ebx 
                add     ebx, 1    ; i++
                call    printing_function
                cmp     ebx, 64h  ; i==100?
                jnz     short loc_80484D0 ; altrimenti, continua
                add     esp, 1Ch
                xor     eax, eax  ; ritorna 0
                pop     ebx
                mov     esp, ebp
                pop     ebp
                retn
main            endp
