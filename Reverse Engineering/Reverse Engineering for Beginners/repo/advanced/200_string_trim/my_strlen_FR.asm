; RCX = pointeur sur la chaîne en entrée
; RAX = longueur actuelle de la chaîne
        xor     rax, rax
label:
        cmp     byte ptr [rcx+rax], 0
        jz      exit
        inc     rax
        jmp     label
exit:
; RAX = longueur de la chaîne
