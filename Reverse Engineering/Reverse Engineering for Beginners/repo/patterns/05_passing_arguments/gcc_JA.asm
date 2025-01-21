        public f
f       proc near

arg_0   = dword ptr  8
arg_4   = dword ptr  0Ch
arg_8   = dword ptr  10h

        push    ebp
        mov     ebp, esp
        mov     eax, [ebp+arg_0] ; 1番目の引数
        imul    eax, [ebp+arg_4] ; 2番目の引数
        add     eax, [ebp+arg_8] ; 3番目の引数
        pop     ebp
        retn
f       endp

        public main
main    proc near

var_10  = dword ptr -10h
var_C   = dword ptr -0Ch
var_8   = dword ptr -8

        push    ebp
        mov     ebp, esp
        and     esp, 0FFFFFFF0h
        sub     esp, 10h
        mov     [esp+10h+var_8], 3 ; 3番目の引数
        mov     [esp+10h+var_C], 2 ; 2番目の引数
        mov     [esp+10h+var_10], 1 ; 1番目の引数
        call    f
        mov     edx, offset aD  ; "\%d\textbackslash{}n"
        mov     [esp+10h+var_C], eax
        mov     [esp+10h+var_10], edx
        call    _printf
        mov     eax, 0
        leave
        retn
main    endp
