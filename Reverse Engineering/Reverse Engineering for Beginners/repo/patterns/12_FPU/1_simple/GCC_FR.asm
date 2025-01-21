                public f
f               proc near

arg_0           = qword ptr  8
arg_8           = qword ptr  10h

                push    ebp
                fld     ds:dbl_8048608 ; 3.14

; état de la pile maintenant: ST(0) = 3.14

                mov     ebp, esp
                fdivr   [ebp+arg_0]

; état de la pile maintenant: ST(0) = résultat de la division

                fld     ds:dbl_8048610 ; 4.1

; état de la pile maintenant: ST(0) = 4.1, ST(1) = résultat de la division

                fmul    [ebp+arg_8]

; état de la pile maintenant: ST(0) = résultat de la multiplication, ST(1) = résultat de la division

                pop     ebp
                faddp   st(1), st

; état de la pile maintenant: ST(0) = résultat de l'addition

                retn
f               endp
