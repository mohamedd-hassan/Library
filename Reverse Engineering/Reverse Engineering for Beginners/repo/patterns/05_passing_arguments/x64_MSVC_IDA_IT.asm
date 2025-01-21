f               proc near

; shadow space:
arg_0           = dword ptr  8
arg_8           = dword ptr  10h
arg_10          = dword ptr  18h

		; ECX - 1° argomento
		; EDX - 2° argomento
		; R8D - 3° argomento
                mov     [rsp+arg_10], r8d
                mov     [rsp+arg_8], edx
                mov     [rsp+arg_0], ecx
                mov     eax, [rsp+arg_0]
                imul    eax, [rsp+arg_8]
                add     eax, [rsp+arg_10]
                retn
f               endp

main            proc near
                sub     rsp, 28h
                mov     r8d, 3 ; 3° argomento
                mov     edx, 2 ; 2° argomento
                mov     ecx, 1 ; 1° argomento
                call    f
                mov     edx, eax
                lea     rcx, $SG2931    ; "\%d\textbackslash{}n"
                call    printf

                ; ritorna 0
                xor     eax, eax
                add     rsp, 28h
                retn
main            endp
