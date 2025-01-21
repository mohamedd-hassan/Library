; store 15 0xAA bytes to EDI
CLD                 ; set direction to \emph{forward}
MOV EAX, 0AAAAAAAAh
MOV ECX, 3
REP STOSD           ; write 12 bytes
STOSW               ; write 2 more bytes
STOSB               ; write remaining byte
