_eos$ = -4                       ; size = 4
_str$ = 8                        ; size = 4
_strlen PROC
    push    ebp
    mov     ebp, esp
    push    ecx
    mov     eax, DWORD PTR _str$[ebp]  ; copier le pointeur sur la chaîne "str"
    mov     DWORD PTR _eos$[ebp], eax  ; le copier dans la variable locale "eos"
$LN2@strlen_:
    mov     ecx, DWORD PTR _eos$[ebp]  ; ECX=eos

    ; prendre un octet 8-bit depuis l'adresse dans ECX et le copier 
    ; comme une valeur 32-bit dans EDX avec extension du signe

    movsx   edx, BYTE PTR [ecx]
    mov     eax, DWORD PTR _eos$[ebp]  ; EAX=eos
    add     eax, 1                     ; incrémenter EAX
    mov     DWORD PTR _eos$[ebp], eax  ; remettre EAX dans "eos"
    test    edx, edx                   ; est-ce que EDX est à zéro?
    je      SHORT $LN1@strlen_         ; oui, alors finir la boucle
    jmp     SHORT $LN2@strlen_         ; continuer la boucle
$LN1@strlen_:

    ; ici nous calculons la différence entre deux pointeurs

    mov    eax, DWORD PTR _eos$[ebp]
    sub    eax, DWORD PTR _str$[ebp]
    sub    eax, 1                      ; soustraire 1 du résultat et sortir
    mov    esp, ebp
    pop    ebp
    ret    0
_strlen_ ENDP
