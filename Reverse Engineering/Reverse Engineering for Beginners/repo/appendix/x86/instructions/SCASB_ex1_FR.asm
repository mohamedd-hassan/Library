lea     edi, string
mov     ecx, 0FFFFFFFFh ; scanne les octets $2^{32}-1$, i.e., presque l'\emph{infini}
xor     eax, eax        ; 0 est le terminateur
repne scasb
add     edi, 0FFFFFFFFh ; le corriger

; maintenant EDI pointe sur le dernier caractère de la chaîne ASCIIZ.

; déterminer la longueur de la chaîne
; ECX vaut = -1-strlen

not     ecx
dec     ecx

; maintenant ECX contient la longueur de la chaîne
