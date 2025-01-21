_key$ = 8                ; size = 4
_len$ = 12               ; size = 4
_hash$ = 16              ; size = 4
_crc    PROC
    mov    edx, DWORD PTR _len$[esp-4]
    xor    ecx, ecx ; i est stocké dans ECX
    mov    eax, edx
    test   edx, edx
    jbe    SHORT $LN1@crc
    push   ebx
    push   esi
    mov    esi, DWORD PTR _key$[esp+4] ; ESI = key
    push   edi
$LL3@crc:

; fonctionne avec des octets en utilisant seulement des registres 32-bit.
; l'octet à l'adresse key+i est stocké dans EDI

    movzx  edi, BYTE PTR [ecx+esi]
    mov    ebx, eax ; EBX = (hash = len)
    and    ebx, 255 ; \verb|EBX = hash & 0xff|

; \verb|XOR EDI, EBX (EDI=EDI^EBX)| 
; cette opération utilise tous les 32 bits de chaque registre
; mais les autres bits (8-31) sont toujours mis à 0, donc c'est OK
; ils sont mis à 0 car, comme pour EDI, cela a été fait avec l'instruction MOVZX ci-dessus
; les bits hauts de EBX sont mis à 0 par l'instruction AND EBX, 255 ci-dessus (255 = 0xff)

    xor    edi, ebx

; EAX=EAX>>8; bits 24-31 pris \emph{de nul part} seront mis à 0
    shr    eax, 8

; \verb|EAX=EAX^crctab[EDI*4] - choisir le EDI-ème élément de la table crctab[]|
    xor    eax, DWORD PTR _crctab[edi*4]
    inc    ecx            ; i++
    cmp    ecx, edx       ; i<len ?
    jb     SHORT $LL3@crc ; oui
    pop    edi
    pop    esi
    pop    ebx
$LN1@crc:
    ret    0
_crc    ENDP
