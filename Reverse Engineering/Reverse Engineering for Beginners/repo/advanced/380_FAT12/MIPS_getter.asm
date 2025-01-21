get_from_array:
; \verb|$4 = idx|
        srl     $2,$4,1
; \verb|$2 = $4>>1 = idx>>1|
        lui     $28,%hi(__gnu_local_gp)
        sll     $3,$2,1
; \verb|$3 = $2<<1 = (idx>>1)<<1 = idx&(~1)|
        andi    $4,$4,0x1
; \verb|$4 = $4&1 = idx&1|
        addiu   $28,$28,%lo(__gnu_local_gp)

; \verb|jump if $4 (idx&1) is not zero (if idx is odd):|
        bne     $4,$0,$L6
; \verb|$2 = $3+$2 = idx>>1 + idx&(~1) = idx*1.5|
        addu    $2,$3,$2 ; branch delay slot - this instruction is executed before BNE

; idx is even, go on:
        lw      $3,%got(array)($28)
; \verb|$3 = array|
        nop
        addu    $2,$3,$2
; \verb|$2 = $3+$2 = array + idx*1.5|
; \verb|load byte at $2+0 = array + idx*1.5 (left byte):|
        lbu     $3,0($2)
; \verb|$3 = left byte|
; \verb|load byte at $2+1 = array + idx*1.5+1 (middle byte):|
        lbu     $2,1($2)
; \verb|$2 = middle byte|
        sll     $3,$3,4
; \verb|$3 = $3<<4 = left_byte<<4|
        srl     $2,$2,4
; \verb|$2 = $2>>4 = middle_byte>>4|
        j       $31
        or      $2,$2,$3 ; branch delay slot - this instruction is executed before J
; \verb!$2 = $2|$3 = middle_byte>>4 | left_byte<<4!
; \verb|$2=returned result|

$L6:
; idx is odd, go on:
        lw      $3,%got(array)($28)
; \verb|$3 = array|
        nop
        addu    $2,$3,$2
; \verb|$2 = $3+$2 = array + idx*1.5|
; \verb|load byte at $2+1 = array + idx*1.5 + 1 (middle byte)|
        lbu     $4,1($2)
; \verb|$4 = middle byte|
; \verb|load byte at $2+1 = array + idx*1.5 + 2 (right byte)|
        lbu     $3,2($2)
; \verb|$3 = right byte|
        andi    $2,$4,0xf
; \verb|$2 = $4&0xF = middle_byte&0xF|
        sll     $2,$2,8
; \verb|$2 = $2<<8 = middle_byte&0xF << 8|
        j       $31
        or      $2,$2,$3 ; branch delay slot - this instruction is executed before J
; \verb!$2 = $2|$3 = middle_byte&0xF << 8 | right byte!
; \verb|$2=returned result|

