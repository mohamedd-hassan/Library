_check_lic_key  proc near
                push    ebp
                mov     ebp, esp
                mov     eax, 1
                imul    ecx, eax, 6123h
                mov     _secret_array[ecx], 1
                pop     ebp
                retn
_check_lic_key  endp


_get_byte_at_0x6000 proc near

a               = dword ptr  8

                push    ebp
                mov     ebp, esp
                mov     eax, [ebp+a]
                mov     al, [eax+6000h]
                pop     ebp
                retn
_get_byte_at_0x6000 endp

_check_again    proc near
                push    ebp
                mov     ebp, esp
                push    offset point_passed_to_get_byte_at_0x6000 
                call    j__get_byte_at_0x6000
                add     esp, 4
                movzx   eax, al
                cmp     eax, 1
                jnz     short loc_406735
                push    offset _Format  ; \verb|"check failed\n"|
                call    j__printf
                add     esp, 4

loc_406735:
                pop     ebp
                retn
_check_again    endp

.data:0045F5C0 ; \verb|char secret_array[65536]|
.data:0045F5C0 _secret_array   db 123h dup(?)
.data:0045F6E3 ; \verb|char point_passed_to_get_byte_at_0x6000[65245]|
.data:0045F6E3 point_passed_to_get_byte_at_0x6000 db 0FEDDh dup(?)
