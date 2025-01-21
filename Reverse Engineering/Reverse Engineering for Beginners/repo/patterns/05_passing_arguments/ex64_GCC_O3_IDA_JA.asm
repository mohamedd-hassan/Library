f       proc near
        imul    rsi, rdi
        lea     rax, [rdx+rsi]
        retn
f       endp

main    proc near
        sub     rsp, 8
        mov     rdx, 3333333344444444h ; 3番目の引数
        mov     rsi, 1111111122222222h ; 2番目の引数
        mov     rdi, 1122334455667788h ; 1番目の引数
        call    f
        mov     edi, offset format ; "\%lld\textbackslash{}n"
        mov     rsi, rax
        xor     eax, eax ; 渡されたベクトルレジスタの数
        call    _printf
        xor     eax, eax
        add     rsp, 8
        retn
main    endp
