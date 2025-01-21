main            proc near

var_20          = dword ptr -20h
var_4           = dword ptr -4

                push    ebp
                mov     ebp, esp
                and     esp, 0FFFFFFF0h
                sub     esp, 20h
                mov     [esp+20h+var_4], 2  ; inizializzazione (i)
                jmp     short loc_8048476

loc_8048465:
                mov     eax, [esp+20h+var_4]
                mov     [esp+20h+var_20], eax
                call    printing_function
                add     [esp+20h+var_4], 1  ; incrementa (i)

loc_8048476:
                cmp     [esp+20h+var_4], 9
                jle     short loc_8048465   ; se i<=9, continua il ciclo
                mov     eax, 0
                leave
                retn
main            endp
