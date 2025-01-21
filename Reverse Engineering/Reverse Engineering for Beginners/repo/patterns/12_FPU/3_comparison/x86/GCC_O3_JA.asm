                public d_max
d_max           proc near

arg_0           = qword ptr  8
arg_8           = qword ptr  10h

                push    ebp
                mov     ebp, esp
                fld     [ebp+arg_0] ; \_a
                fld     [ebp+arg_8] ; \_b

; 現在のスタック状態: ST(0) = \_b, ST(1) = \_a
                fxch    st(1)

; 現在のスタック状態: ST(0) = \_a, ST(1) = \_b
                fucom   st(1) ; compare \_a and \_b
                fnstsw  ax
                sahf
                ja      short loc_8048448

; ST(0)にST(0)を保存 (アイドル処理)
; スタックのトップの値をポップ
; \_bをトップに残す
                fstp    st
                jmp     short loc_804844A

loc_8048448:
; \_aをST(1)に保存し、スタックのトップの値をポップし、\_aをトップに残す
                fstp    st(1)

loc_804844A:
                pop     ebp
                retn
d_max           endp
