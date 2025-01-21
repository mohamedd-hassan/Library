                public d_max
d_max           proc near

arg_0           = qword ptr  8
arg_8           = qword ptr  10h

                push    ebp
                mov     ebp, esp
                fld     [ebp+arg_0] ; \_a
                fld     [ebp+arg_8] ; \_b

; état de la pile maintenant: ST(0) = \_b, ST(1) = \_a
                fxch    st(1)

; état de la pile maintenant: ST(0) = \_a, ST(1) = \_b
                fucom   st(1) ; comparer \_a et \_b
                fnstsw  ax
                sahf
                ja      short loc_8048448

; stocker ST(0) dans ST(0) (opération sans effet),
; dépiler une valeur du sommet de la pile,
; laisser \_b au sommet
                fstp    st
                jmp     short loc_804844A

loc_8048448:
; stocker \_a dans ST(1), dépiler une valeur du sommet de la pile, laisser \_a au sommet
                fstp    st(1)

loc_804844A:
                pop     ebp
                retn
d_max           endp
