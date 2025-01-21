$LC0:
        .ascii  "it is not ten\000"
$LC1:
        .ascii  "it is ten\000"
f:
        li      $2,10                   # 0xa
; confronta \$a0 e 10, se sono uguali salta:
        beq     $4,$2,$L2
        nop ; branch delay slot

; metti l'indirizzo della stringa "it is not ten" in \$v0 e ritorna:
        lui     $2,%hi($LC0)
        j       $31
        addiu   $2,$2,%lo($LC0)

$L2:
; metti l'indirizzo della stringa "it is ten" in \$v0 e return:
        lui     $2,%hi($LC1)
        j       $31
        addiu   $2,$2,%lo($LC1)
