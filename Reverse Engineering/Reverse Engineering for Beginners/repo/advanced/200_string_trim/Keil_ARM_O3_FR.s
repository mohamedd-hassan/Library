str_trim PROC
        PUSH     {r4,lr}
; R0=s
        MOV      r4,r0
; R4=s
        BL       strlen       ; strlen() prend la valeur de "s" dans R0
; R0=str\_len
        MOV      r3,#0
; R3 contiendra toujours 0
|L0.16|
        CMP      r0,#0        ; str\_len==0?
        ADDNE    r2,r4,r0     ; (si str\_len!=0) R2=R4+R0=s+str\_len
        LDRBNE   r1,[r2,#-1]  ; (si str\_len!=0) R1=charger l'octet à l'adresse R2-1=s+str\_len-1
        CMPNE    r1,#0        ; (si str\_len!=0) comparer l'octet chargé avec 0
        BEQ      |L0.56|      ; sauter à la sortie si str\_len==0 ou si l'octet chargé est 0
        CMP      r1,#0xd      ; \verb|est-ce que l'octet chargé est '\r'?|
        CMPNE    r1,#0xa      ; \verb|(si l'octet chargé n'est pas '\r') est-ce '\r'?|
        SUBEQ    r0,r0,#1     ; \verb|(si l'octet chargé  est '\r' ou '\n') R0-- ou str_len--|
        STRBEQ   r3,[r2,#-1]  ; \verb|(si l'octet chargé est '\r' ou '\n')| stocker R3 (zéero) à l'adresse R2-1=s+str\_len-1
        BEQ      |L0.16|      ; \verb|sauter au début de a boucle si l'octet chargé était '\r' ou '\n'|
|L0.56|
; renvoyer "s"
        MOV      r0,r4
        POP      {r4,pc}
        ENDP
