                public f
f               proc near

arg_0           = qword ptr  8
arg_8           = qword ptr  10h

                push    ebp
                fld     ds:dbl_8048608 ; 3.14

; 現在のスタック状態: ST(0) = 3.14

                mov     ebp, esp
                fdivr   [ebp+arg_0]

; 現在のスタック状態: ST(0) = 除算の結果

                fld     ds:dbl_8048610 ; 4.1

; 現在のスタック状態: ST(0) = 4.1, ST(1) = 除算の結果

                fmul    [ebp+arg_8]

; 現在のスタック状態: ST(0) = 乗算の結果、 ST(1) = 除算の結果

                pop     ebp
                faddp   st(1), st

; 現在のスタック状態: ST(0) = 加算の結果

                retn
f               endp
