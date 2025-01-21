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

; aとbをローカルスタックにプッシュ
    mov     eax, [ebp+a_first_half]
    mov     dword ptr [ebp+a], eax
    mov     eax, [ebp+a_second_half]
    mov     dword ptr [ebp+a+4], eax
    mov     eax, [ebp+b_first_half]
    mov     dword ptr [ebp+b], eax
    mov     eax, [ebp+b_second_half]
    mov     dword ptr [ebp+b+4], eax

; aとbをFPUスタックにロード

    fld     [ebp+a]
    fld     [ebp+b]

; 現在のスタック状態: ST(0) - b; ST(1) - a

    fxch    st(1) ; this instruction swaps ST(1) and ST(0)

; 現在のスタック状態: ST(0) - a; ST(1) - b

    fucompp    ; aとbを比較しスタックから2値をポップ。例：a and b
    fnstsw  ax ; FPUステータスをAXに保存
    sahf       ; AHからSF, ZF, AF, PFそしてCFフラグの状態をロード
    setnbe  al ; CF=0かつZF=0の場合にALに1を保存
    test    al, al            ; AL==0か
    jz      short loc_8048453 ; 真
    fld     [ebp+a]
    jmp     short locret_8048456

loc_8048453:
    fld     [ebp+b]

locret_8048456:
    leave
    retn
d_max endp
