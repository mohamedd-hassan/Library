f               proc near

; シャドースペース
arg_0           = dword ptr  8
arg_8           = dword ptr  10h
arg_10          = dword ptr  18h

		; ECX - 1番目の引数
		; EDX - 2番目の引数
		; R8D - 3番目の引数
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
                mov     r8d, 3 ; 3番目の引数
                mov     edx, 2 ; 2番目の引数
                mov     ecx, 1 ; 1番目の引数
                call    f
                mov     edx, eax
                lea     rcx, $SG2931    ; "\%d\textbackslash{}n"
                call    printf

                ; 0をリターン
                xor     eax, eax
                add     rsp, 28h
                retn
main            endp
