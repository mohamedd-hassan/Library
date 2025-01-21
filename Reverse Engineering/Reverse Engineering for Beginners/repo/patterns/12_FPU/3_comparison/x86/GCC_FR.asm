d_max proc near

b               = qword ptr -10h
a               = qword ptr -8
a_first_half    = dword ptr  8
a_second_half   = dword ptr  0Ch
b_first_half    = dword ptr  10h
b_second_half   = dword ptr  14h

    push    ebp
    mov     ebp, esp
    sub     esp, 10h

; mettre a et b sur la pile locale:

    mov     eax, [ebp+a_first_half]
    mov     dword ptr [ebp+a], eax
    mov     eax, [ebp+a_second_half]
    mov     dword ptr [ebp+a+4], eax
    mov     eax, [ebp+b_first_half]
    mov     dword ptr [ebp+b], eax
    mov     eax, [ebp+b_second_half]
    mov     dword ptr [ebp+b+4], eax

; charger a et b sur la pile du FPU:

    fld     [ebp+a]
    fld     [ebp+b]

; état courant de la pile: ST(0) - b; ST(1) - a

    fxch    st(1) ; cette instruction échange ST(1) et ST(0)

; état courant de la pile: ST(0) - a; ST(1) - b

    fucompp    ; comparer a et b et prendre deux valeurs depuis la pile, i.e., a et b
    fnstsw  ax ; stocker l'état du FPU dans AX
    sahf       ; charger l'état des flags SF, ZF, AF, PF, et CF depuis AH
    setnbe  al ; mettre 1 dans AL, si CF=0 et ZF=0
    test    al, al            ; AL==0 ?
    jz      short loc_8048453 ; oui
    fld     [ebp+a]
    jmp     short locret_8048456

loc_8048453:
    fld     [ebp+b]

locret_8048456:
    leave
    retn
d_max endp
