_i$ = -4
_main    PROC
    push   ebp
    mov    ebp, esp
    push   ecx
    mov    DWORD PTR _i$[ebp], 2   ; inizializzazione ciclo
    jmp    SHORT $LN3@main
$LN2@main:
    mov    eax, DWORD PTR _i$[ebp] ; qui c'è ciò che facciamo dopo ogni iterazione:
    add    eax, 1                  ; aggiungi 1 al valore (i)
    mov    DWORD PTR _i$[ebp], eax
$LN3@main:
    cmp    DWORD PTR _i$[ebp], 10  ; questa condizione è controllata \emph{prima} di ogni iterazione
    jge    SHORT $LN1@main         ; se (i) è maggiore o uguale a 10, il ciclo termina
    mov    ecx, DWORD PTR _i$[ebp] ; corpo del ciclo: call printing\_function(i)
    push   ecx
    call   _printing_function
    add    esp, 4
    jmp    SHORT $LN2@main         ; salta all' inizio del ciclo
$LN1@main:                         ; fine del ciclo
    xor    eax, eax
    mov    esp, ebp
    pop    ebp
    ret    0
_main    ENDP
