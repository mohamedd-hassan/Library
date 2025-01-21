; copier 15 octets de ESI vers EDI
CLD         ; mettre la direction à \emph{en avant}
MOV ECX, 3
REP MOVSD   ; copier 12 octets
MOVSW       ; copier 2 octets de plus
MOVSB       ; copier l'octet restant
