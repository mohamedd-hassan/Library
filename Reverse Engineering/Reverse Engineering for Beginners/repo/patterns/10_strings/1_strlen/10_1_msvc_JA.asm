_eos$ = -4                       ; size = 4
_str$ = 8                        ; size = 4
_strlen PROC
    push    ebp
    mov     ebp, esp
    push    ecx
    mov     eax, DWORD PTR _str$[ebp]  ; "str"から文字列へのポインタを配置
    mov     DWORD PTR _eos$[ebp], eax  ; "ローカル変数"eos"に配置
$LN2@strlen_:
    mov     ecx, DWORD PTR _eos$[ebp]  ; ECX=eos
    
    ; ECXのアドレスから8ビットのバイトを取り出し、符号付き32ビットの値としてEDXに配置する
    movsx   edx, BYTE PTR [ecx]             
    mov     eax, DWORD PTR _eos$[ebp]  ; EAX=eos
    add     eax, 1                     ; EAXをインクリメント
    mov     DWORD PTR _eos$[ebp], eax  ; EAXの値を"eos"に戻す
    test    edx, edx                   ; EDXはゼロか
    je      SHORT $LN1@strlen_         ; そうなら、ループを終了する
    jmp     SHORT $LN2@strlen_         ; ループを継続する
$LN1@strlen_:
    
    ; ここで二つのポインタの差分を計算する
    mov    eax, DWORD PTR _eos$[ebp]         
    sub    eax, DWORD PTR _str$[ebp]
    sub    eax, 1                      ; 1を引いて結果をリターンする
    mov    esp, ebp
    pop    ebp
    ret    0
_strlen_ ENDP
