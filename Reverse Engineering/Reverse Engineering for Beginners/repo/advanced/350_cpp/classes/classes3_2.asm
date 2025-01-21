?dump@solid_object@@QAEXXZ PROC ; solid\_object::dump, COMDAT
; \_this\$ = ecx
    mov  eax, DWORD PTR [ecx]
    push eax
; \verb|'this is a solid_object. density=%d', 0aH|
    push OFFSET ??_C@_0CC@KICFJINL@this?5is?5solid_object?4?5density?$DN?$CFd@
    call _printf
    add  esp, 8
    ret  0
?dump@solid_object@@QAEXXZ ENDP ; solid\_object::dump
