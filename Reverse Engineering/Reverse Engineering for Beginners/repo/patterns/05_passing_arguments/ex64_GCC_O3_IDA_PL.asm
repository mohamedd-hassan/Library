f       proc near
        imul    rsi, rdi
        lea     rax, [rdx+rsi]
        retn
f       endp

main    proc near
        sub     rsp, 8
        mov     rdx, 3333333344444444h ; 3 argument
        mov     rsi, 1111111122222222h ; 2 argument
        mov     rdi, 1122334455667788h ; 1 argument
        call    f
        mov     edi, offset format ; "\%lld\textbackslash{}n"
        mov     rsi, rax
        xor     eax, eax ; liczba rejestrów wektorowych z argumentami
        call    _printf
        xor     eax, eax
        add     rsp, 8
        retn
main    endp
