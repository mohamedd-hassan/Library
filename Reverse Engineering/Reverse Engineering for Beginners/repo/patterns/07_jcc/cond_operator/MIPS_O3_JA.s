$LC0:
        .ascii  "it is not ten\000"
$LC1:
        .ascii  "it is ten\000"
f:
        li      $2,10                   # 0xa
; \$a0と10を比較し、等しければ分岐
        beq     $4,$2,$L2
        nop ; branch delay slot

; "it is not ten"文字列へのアドレスを\$v0に残しつつリターン
        lui     $2,%hi($LC0)
        j       $31
        addiu   $2,$2,%lo($LC0)

$L2:
; "it is ten"文字列へのアドレスを\$v0に残しつつリターン
        lui     $2,%hi($LC1)
        j       $31
        addiu   $2,$2,%lo($LC1)
