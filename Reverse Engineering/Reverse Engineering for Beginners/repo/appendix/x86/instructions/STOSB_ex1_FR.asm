; sotcke 15 octets 0xAA dans EDI
CLD                 ; met la direction à \emph{en avant}
MOV EAX, 0AAAAAAAAh
MOV ECX, 3
REP STOSD           ; écrit 12 octets
STOSW               ; écrit 2 octets de plus
STOSB               ; écrit l'octet restant
