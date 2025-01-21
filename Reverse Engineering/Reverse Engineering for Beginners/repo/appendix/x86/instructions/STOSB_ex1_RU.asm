; записать 15 байт 0xAA в EDI
CLD                 ; установить направление на \emph{вперед}
MOV EAX, 0AAAAAAAAh
MOV ECX, 3
REP STOSD           ; записать 12 байт
STOSW               ; записать еще 2 байта
STOSB               ; записать оставшийся байт
