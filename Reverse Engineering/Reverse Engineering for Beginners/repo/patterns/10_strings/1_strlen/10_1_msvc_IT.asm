_eos$ = -4                       ; dimensione = 4
_str$ = 8                        ; dimensione = 4
_strlen PROC
    push    ebp
    mov     ebp, esp
    push    ecx
    mov     eax, DWORD PTR _str$[ebp]  ; prendi il puntatore alla stringa da "str"
    mov     DWORD PTR _eos$[ebp], eax  ; piazzalo nella variabile locale "eos"
$LN2@strlen_:
    mov     ecx, DWORD PTR _eos$[ebp]  ; ECX=eos
    
    ; prendi un byte (8-bit) dall' indirizzo in ECX e piazzalo 
    ; in EDX come valore a 32-bit con estensione del segno

    movsx   edx, BYTE PTR [ecx]             
    mov     eax, DWORD PTR _eos$[ebp]  ; EAX=eos
    add     eax, 1                     ; incrementa EAX
    mov     DWORD PTR _eos$[ebp], eax  ; rimetti EAX in "eos"
    test    edx, edx                   ; EDX è zero?
    je      SHORT $LN1@strlen_         ; si, allora termina il ciclo
    jmp     SHORT $LN2@strlen_         ; continua il ciclo
$LN1@strlen_:
    
    ; qui calcoliamo la differena tra 2 puntatori

    mov    eax, DWORD PTR _eos$[ebp]         
    sub    eax, DWORD PTR _str$[ebp]
    sub    eax, 1                      ; sottrai 1 e ritorna il risultato
    mov    esp, ebp
    pop    ebp
    ret    0
_strlen_ ENDP
