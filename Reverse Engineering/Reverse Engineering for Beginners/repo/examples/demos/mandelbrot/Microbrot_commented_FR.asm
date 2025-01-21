; X est une colonne de l'écran
; Y est une ligne de l'écran


; X=0, Y=0              X=319, Y=0
; +------------------------------->
; |
; |
; |
; |
; |
; |
; v
; X=0, Y=199            X=319, Y=199


; mettre le mode graphique VGA 320*200*256
mov al,13h
int 10h
; initialiser BX à 0
; initialiser DI à 0xFFFE
; DS:BX (ou DS:0) pointe à ce moment sur le Program Segment Prefix
; ... dont les 4 premiers octets sont CD 20 FF 9F
les ax,[bx]
; ES:AX=9FFF:20CD

FillLoop:
; \verb|mettre DX à 0. CWD fonctionne comme: DX:AX = sign_extend(AX).|
; AX ici contient 0x20CD (au début) ou moins que 320 (lorsque l'on revient lors de la boucle),
; donc DX contiendra toujours 0.
cwd 
mov ax,di
; AX est le pointeur courant dnas le buffer VGA
; divise le pointeur courant par 320
mov cx,320
div cx
; \verb|DX (start_X) - reste (colonne: 0..319); AX - résultat (ligne: 0..199)|
sub ax,100
; \verb|AX=AX-100, donc AX (start_Y) est maintenant dans l'intervalle -100..99|
; DX est dans l'intervalle 0..319 ou 0x0000..0x013F
dec dh
; DX est maintenant dans l'intervalle 0xFF00..0x003F (-256..63)

xor bx,bx
xor si,si
; \verb|BX (temp_X)=0; SI (temp_Y)=0|

; prendre le nombre maximal d'itérations
; CX contient toujours 320 ici, donc ceci est aussi le nombre maximal d'itérations
MandelLoop:
mov bp,si      ; \verb|BP = temp_Y|
imul si,bx     ; \verb|SI = temp_X*temp_Y|
add si,si      ; \verb|SI = SI*2 = (temp_X*temp_Y)*2|
imul bx,bx     ; \verb|BX = BX^2 = temp_X^2|
jo MandelBreak ; overflow?
imul bp,bp     ; \verb|BP = BP^2 = temp_Y^2|
jo MandelBreak ; overflow?
add bx,bp      ; \verb|BX = BX+BP = temp_X^2 + temp_Y^2|
jo MandelBreak ; overflow?
sub bx,bp      ; \verb|BX = BX-BP = temp_X^2 + temp_Y^2 - temp_Y^2 = temp_X^2|
sub bx,bp      ; \verb|BX = BX-BP = temp_X^2 - temp_Y^2|

; corrige l'échelle:
sar bx,6       ; BX=BX/64
add bx,dx      ; \verb|BX=BX+start_X|
; \verb|maintenant temp_X = temp_X^2 - temp_Y^2 + start_X|
sar si,6       ; SI=SI/64
add si,ax      ; \verb|SI=SI+start_Y|
; \verb|maintenant temp_Y = (temp_X*temp_Y)*2 + start_Y|

loop MandelLoop

MandelBreak:
; CX=itérations
xchg ax,cx
; AX=itérations. stocke AL dans le buffer VGA en ES:[DI]
stosb
; stosb incrémente aussi DI, donc DI pointe maintenant sur le point suivant dans le buffer VGA
; saute toujours, donc c'est une boucle infinie ici
jmp FillLoop
