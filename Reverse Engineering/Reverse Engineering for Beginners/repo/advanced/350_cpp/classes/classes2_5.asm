?hack_oop_encapsulation@@YAXPAVbox@@@Z PROC ; hack\_oop\_encapsulation
    mov eax, DWORD PTR _o$[esp-4]
    mov DWORD PTR [eax+4], 123
    ret 0
?hack_oop_encapsulation@@YAXPAVbox@@@Z ENDP ; hack\_oop\_encapsulation
