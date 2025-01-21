            EXPORT _main
_main
            STMFD   SP!, {R4,LR}
            SUB     SP, SP, #0x50    ; allouer de la place pour 20 variables int

; première boucle

            MOV     R4, #0           ; i
            B       loc_4A0
loc_494
            MOV     R0, R4,LSL#1     ; R0=R4*2
            STR     R0, [SP,R4,LSL#2]; stocker R0 dans SP+R4<<2 (pareil que SP+R4*4)
            ADD     R4, R4, #1       ; i=i+1

loc_4A0
            CMP     R4, #20          ; i<20?
            BLT     loc_494          ; oui, effectuer encore le corps de la boucle

; seconde boucle

            MOV     R4, #0           ; i
            B       loc_4C4
loc_4B0
            LDR     R2, [SP,R4,LSL#2]; (second argument de printf) R2=*(SP+R4<<4)
                                     ; (pareil que *(SP+R4*4))
            MOV     R1, R4           ; (premier argument de printf) R1=i
            ADR     R0, aADD         ; "a[\%d]=\%d\textbackslash{}n"
            BL      __2printf
            ADD     R4, R4, #1       ; i=i+1

loc_4C4
            CMP     R4, #20          ; i<20?
            BLT     loc_4B0          ; oui, effectuer encore le corps de la boucle
            MOV     R0, #0           ; valeur à renvoyer
            ADD     SP, SP, #0x50    ; libérer le chunk, alloué pour 20 variables int
            LDMFD   SP!, {R4,PC}
