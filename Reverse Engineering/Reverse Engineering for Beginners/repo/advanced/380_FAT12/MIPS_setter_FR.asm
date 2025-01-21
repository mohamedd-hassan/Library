put_to_array:
; \verb|$4=idx|
; \verb|$5=val|
        srl     $2,$4,1
; \verb|$2 = $4>>1 = idx>>1|
        lui     $28,%hi(__gnu_local_gp)
        sll     $3,$2,1
; \verb|$3 = $2<<1 = (idx>>1)<<1 = idx&(~1)|
        andi    $4,$4,0x1
; \verb|$4 = $4&1 = idx&1|
        addiu   $28,$28,%lo(__gnu_local_gp)
; \verb|sauter si $4=idx&1 n'est pas zéro (i.e., si idx est impair):|
        bne     $4,$0,$L11
        addu    $2,$3,$2 ; slot de délai de branchement, cette instruction est exécutée avant BNE
; \verb|$2 = $3+$2 = idx&(~1) + idx>>1 = idx*1.5|

; idx est pair, continuer
        lw      $3,%got(array)($28)
; \verb|$3 = array|
        addiu   $4,$2,1
; \verb|$4 = $2+1 = idx*1.5+1, i.e., offset de l'octet du milieu dans array|
        srl     $6,$5,4
; \verb|$6 = $5>>4 = val>>4|
        addu    $2,$3,$2
; \verb|$2 = $3+$2 = array + idx*1.5 (offset de l'octet de gauche)|
; \verb|stocker $6 (val>>4) comme octet de gauche:|
        sb      $6,0($2)
        addu    $2,$3,$4
; \verb|$2 = $3+$4 = array + idx*1.5 + 1 (adresse absolue de l'octet du milieu)|
; \verb|charger l'octet du milieu en $2+0 = array + idx*1.5 + 1|
        lbu     $3,0($2)
; \verb|$3 = octet du milieu|
        andi    $5,$5,0xf
; \verb|$5 = $5&0xF = val&0xF|
        andi    $3,$3,0xf
; \verb|$3 = $3&0xF = middle_byte&0xF|
        sll     $5,$5,4
; \verb|$5 = $5<<4 = (val&0xF)<<4|
        or      $5,$3,$5
; \verb!$5 = $3|$5 = middle_byte&0xF | (val&0xF)<<4 (nouvelle version de l'octet du milieu)!
        j       $31
; \verb|stocker $5 (nouvel octet du milieu) en $2 (array + idx*1.5 + 1)|
        sb      $5,0($2) ; slot de délai de branchement, cette instruction est exécutée avant J

$L11:
; idx est impair, continuer
        lw      $4,%got(array)($28)
; \verb|$4 = array|
        addiu   $3,$2,1
; \verb|$3 = $2+1 = idx*1.5+1 (offset de l'octet du milieu)|
        addu    $3,$4,$3
; \verb|$3 = $4+$3 = array + idx*1.5+1|
; \verb|charger l'octet du milieu en $3 (array + idx*1.5+1)|
        lbu     $6,0($3)
; \verb|$6 = octet du milieu|
        srl     $7,$5,8
; \verb|$7 = $5>>8 = val>>8|
        andi    $6,$6,0xf0
; \verb|$6 = $6&0xF0 = middle_byte&0xF0|
        or      $6,$6,$7
; \verb!$6 = $6|$7 = middle_byte&0xF0 | val>>8!
        addu    $2,$4,$2
; \verb|stocker l'octet du milieu mis à jour en $3 (array + idx*1.5+1)|
        sb      $6,0($3)
        j       $31
; \verb|stocker les 8 bits bas de val en $2+2=idx*1.5+2 (emplacement de l'octet de droite)|
        sb      $5,2($2) ; slot de délai de branchement, cette instruction est exécutée avant J

