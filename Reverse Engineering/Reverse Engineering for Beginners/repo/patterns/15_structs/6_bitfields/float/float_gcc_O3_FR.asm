; f(float)
       public _Z1ff
_Z1ff  proc near

var_4  = dword ptr -4
arg_0  = dword ptr  8

       push    ebp
       mov     ebp, esp
       sub     esp, 4
       mov     eax, [ebp+arg_0]
       or      eax, 80000000h  ; positionnement du signe négatif
       mov     edx, eax
       and     eax, 807FFFFFh  ; Nous ne conservons que le signe et le signifiant dans EAX
       shr     edx, 23         ; Préparation de l'exposant
       add     edx, 2          ; Ajout de 2
       movzx   edx, dl         ; RAZ de tous les octets dans EDX à l'exception des bits 7:0
       shl     edx, 23         ; Décalage du nouvel exposant pour qu'ils soit à sa place
       or      eax, edx        ; Consolidation du nouvel exposant et de la valeur originale de l'exposant
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
