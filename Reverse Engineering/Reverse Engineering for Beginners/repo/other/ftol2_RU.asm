                public __ftol2
__ftol2         proc near
                push    ebp
                mov     ebp, esp
                sub     esp, 20h
                and     esp, 0FFFFFFF0h
                fld     st
                fst     dword ptr [esp+18h]
                fistp   qword ptr [esp+10h]
                fild    qword ptr [esp+10h]
                mov     edx, [esp+18h]
                mov     eax, [esp+10h]
                test    eax, eax
                jz      short integer_QnaN_or_zero

arg_is_not_integer_QnaN:
                fsubp   st(1), st
                test    edx, edx
                jns     short positive
                fstp    dword ptr [esp]
                mov     ecx, [esp]
                xor     ecx, 80000000h
                add     ecx, 7FFFFFFFh
                adc     eax, 0
                mov     edx, [esp+14h]
                adc     edx, 0
                jmp     short localexit

positive:
                fstp    dword ptr [esp]
                mov     ecx, [esp]
                add     ecx, 7FFFFFFFh
                sbb     eax, 0
                mov     edx, [esp+14h]
                sbb     edx, 0
                jmp     short localexit

integer_QnaN_or_zero:
                mov     edx, [esp+14h]
                test    edx, 7FFFFFFFh
                jnz     short arg_is_not_integer_QnaN
                fstp    dword ptr [esp+18h] ; первая
                fstp    dword ptr [esp+18h] ; вторая

localexit:
                leave
                retn
__ftol2         endp
