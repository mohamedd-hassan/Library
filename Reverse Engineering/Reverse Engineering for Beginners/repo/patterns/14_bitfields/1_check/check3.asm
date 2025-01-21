loc_C01EF684:       ; CODE XREF: do\_filp\_open+4F
                test    bl, 40h         ; O\_CREAT
                jnz     loc_C01EF810
                mov     edi, ebx
                shr     edi, 11h
                xor     edi, 1
                and     edi, 1
                test    ebx, 10000h
                jz      short loc_C01EF6D3
                or      edi, 2
