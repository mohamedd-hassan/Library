_i$ = -4
_main    PROC
    push   ebp
    mov    ebp, esp
    push   ecx
    mov    DWORD PTR _i$[ebp], 2   ; ループ初期化
    jmp    SHORT $LN3@main
$LN2@main:
    mov    eax, DWORD PTR _i$[ebp] ; 各イテレーションの後にくる場所
    add    eax, 1                  ; (i)に1を加える
    mov    DWORD PTR _i$[ebp], eax
$LN3@main:
    cmp    DWORD PTR _i$[ebp], 10  ; 各イテレーション\emph{の前に}この条件がチェックされる
    jge    SHORT $LN1@main         ; (i) が10以上の場合、ループが終了する
    mov    ecx, DWORD PTR _i$[ebp] ; ループボディ：printing\_function(i)を呼び出す
    push   ecx
    call   _printing_function
    add    esp, 4
    jmp    SHORT $LN2@main         ; ループ開始にジャンプ
$LN1@main:                         ; ループエンド
    xor    eax, eax
    mov    esp, ebp
    pop    ebp
    ret    0
_main    ENDP
