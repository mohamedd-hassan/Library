; f(float)
       public _Z1ff
_Z1ff  proc near

var_4  = dword ptr -4
arg_0  = dword ptr  8

       push    ebp
       mov     ebp, esp
       sub     esp, 4
       mov     eax, [ebp+arg_0]
       or      eax, 80000000h  ; マイナス符号を設定
       mov     edx, eax
       and     eax, 807FFFFFh  ; EAXに符号と仮数部のみを残す
       shr     edx, 23         ; 指数を準備
       add     edx, 2          ; 2を加算
       movzx   edx, dl         ; EDXの7:0を除くビットをすべてクリア
       shl     edx, 23         ; 新しく計算された指数をその場所に移す
       or      eax, edx        ; 指数なしで新しい指数と元の値を結合する
       mov     [ebp+var_4], eax
       fld     [ebp+var_4]
       leave
       retn
_Z1ff  endp

       public main
main   proc near
       push    ebp
       mov     ebp, esp
       and     esp, 0FFFFFFF0h
       sub     esp, 10h
       fld     ds:dword_8048614 ; -4.936
       fstp    qword ptr [esp+8]
       mov     dword ptr [esp+4], offset asc_8048610 ; \verb|"%f\n"|
       mov     dword ptr [esp], 1
       call    ___printf_chk
       xor     eax, eax
       leave
       retn
main   endp
