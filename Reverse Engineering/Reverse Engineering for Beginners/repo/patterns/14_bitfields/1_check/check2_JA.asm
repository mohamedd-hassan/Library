do_filp_open    proc near
...
                push    ebp
                mov     ebp, esp
                push    edi
                push    esi
                push    ebx
                mov     ebx, ecx
                add     ebx, 1
                sub     esp, 98h
                mov     esi, [ebp+arg_4] ; acc\_mode (5番目の引数)
                test    bl, 3
                mov     [ebp+var_80], eax ; dfd (1番目の引数)
                mov     [ebp+var_7C], edx ; pathname (2番目の引数)
                mov     [ebp+var_78], ecx ; open\_flag (3番目の引数)
                jnz     short loc_C01EF684
                mov     ebx, ecx        ; ebx <- open\_flag
