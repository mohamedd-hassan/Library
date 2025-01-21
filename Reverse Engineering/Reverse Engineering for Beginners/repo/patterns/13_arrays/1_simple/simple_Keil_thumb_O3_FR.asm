_main
          PUSH    {R4,R5,LR}
; allouer de l'espace pour 20 variables int + une variable supplémentaire
          SUB     SP, SP, #0x54

; première boucle

          MOVS    R0, #0      ; i
          MOV     R5, SP      ; pointeur sur le premier élément du tableau

loc_1CE
          LSLS    R1, R0, #1  ; R1=i<<1 (pareil que i*2)
          LSLS    R2, R0, #2  ; R2=i<<2 (pareil que i*4)
          ADDS    R0, R0, #1  ; i=i+1
          CMP     R0, #20     ; i<20?
          STR     R1, [R5,R2] ; stocker R1 dans *(R5+R2) (pareil que R5+i*4)
          BLT     loc_1CE     ; oui, i<20, effectuer encore le corps de la boucle

; seconde boucle

          MOVS    R4, #0      ; i=0
loc_1DC
          LSLS    R0, R4, #2  ; R0=i<<2 (pareil que i*4)
          LDR     R2, [R5,R0] ; charger depuis *(R5+R0) (pareil que R5+i*4)
          MOVS    R1, R4
          ADR     R0, aADD    ; "a[\%d]=\%d\textbackslash{}n"
          BL      __2printf
          ADDS    R4, R4, #1  ; i=i+1
          CMP     R4, #20     ; i<20?
          BLT     loc_1DC     ; oui, i<20, effectuer encore le corps de la boucle
          MOVS    R0, #0      ; valeur à renvoyer
; libérer le chunk, alloué pour 20 variables int 
; + une variable supplémentaire
          ADD     SP, SP, #0x54
          POP     {R4,R5,PC}
