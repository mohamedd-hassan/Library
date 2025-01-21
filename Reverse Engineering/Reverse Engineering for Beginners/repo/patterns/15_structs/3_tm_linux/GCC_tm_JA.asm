main proc near
     push    ebp
     mov     ebp, esp
     and     esp, 0FFFFFFF0h
     sub     esp, 40h
     mov     dword ptr [esp], 0 ; time()への第一引数
     call    time
     mov     [esp+3Ch], eax
     lea     eax, [esp+3Ch]  ; take pointer to what time() returned
     lea     edx, [esp+10h]  ; at ESP+10h struct tm will begin
     mov     [esp+4], edx    ; 構造体へのポインタを渡す
     mov     [esp], eax      ; time()の結果へのポインタを渡す
     call    localtime_r
     mov     eax, [esp+24h]  ; tm\_year
     lea     edx, [eax+76Ch] ; edx=eax+1900
     mov     eax, offset format ; "Year: \%d\textbackslash{}n"
     mov     [esp+4], edx
     mov     [esp], eax
     call    printf
     mov     edx, [esp+20h]      ; tm\_mon
     mov     eax, offset aMonthD ; "Month: \%d\textbackslash{}n"
     mov     [esp+4], edx
     mov     [esp], eax
     call    printf
     mov     edx, [esp+1Ch]     ; tm\_mday
     mov     eax, offset aDayD  ; "Day: \%d\textbackslash{}n"
     mov     [esp+4], edx
     mov     [esp], eax
     call    printf
     mov     edx, [esp+18h]     ; tm\_hour
     mov     eax, offset aHourD ; "Hour: \%d\textbackslash{}n"
     mov     [esp+4], edx
     mov     [esp], eax
     call    printf
     mov     edx, [esp+14h]        ; tm\_min
     mov     eax, offset aMinutesD ; "Minutes: \%d\textbackslash{}n"
     mov     [esp+4], edx
     mov     [esp], eax
     call    printf
     mov     edx, [esp+10h]
     mov     eax, offset aSecondsD ; "Seconds: \%d\textbackslash{}n"
     mov     [esp+4], edx          ; tm\_sec
     mov     [esp], eax
     call    printf
     leave
     retn
main endp

