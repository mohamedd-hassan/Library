get_from_array:
; EDI=idx
; faire une copie:
        mov     eax, edi
; calculer idx>>1:
        shr     eax
; déterminer si l'élément est pair ou impair en isolant le bit le plus bas:
        and     edi, 1
; calculer (idx>>1)*3.
; la multiplication est lente en général, et peut être remplacée par
; des opérations de décalage et d'addition
; LEA est capable de faire les deux:
        lea     edx, [rax+rax*2]
; EDX contient maintenant (idx>>1)*3
; faire pointer EAX sur l'octet du milieu:
        lea     eax, [rdx+1]
; étendre le signe de la valeur de EAX à RDX:
        cdqe
; copier l'octet du milieu dans EAX:
        movzx   eax, BYTE PTR array[rax]
; enfin vérifier la valeur du bit le plus bas de l'index.
; sauter si l'index est impair (NE est comme NZ (Not Zero)):
        jne     .L9

; c'est un élément pair, continuer
; étendre le signe de EDX à RDX:
	movsx   rdx, edx
; décaler l'octet du milieu de 4 bits vers la droite:
        shr     al, 4
; AL contient maintenant les 4 bits les plus haut de l'octet du milieu
; charger l'octet de gauche dans EDX:
        movzx   edx, BYTE PTR array[rdx]
; étendre le signe de AL (où les 4 bits haut de l'octet du milieu sont maintenant)
        movzx   eax, al
; EAX contient maintenant les 4 bits les plus haut de l'octet du milieu
; EDX contient maintenant l'octet de gauche
; décaler l'octet de gauche de 4 bits à gauche:
        sal     edx, 4
; les 4 bits les plus bas sont dans EDX après que le décalage les aient mis à zéro
; enfin, fusionner les valeurs:
        or      eax, edx
        ret
.L9:
; c'est un élément impair, continuer
; calculer l'adresse de l'octet de droite:
        add     edx, 2
; isoler les 4 bits les plus bas de l'octet du milieu:
	and     eax, 15 ; 15=0xF
; étendre le signe de EDX (où est l'adresse de l'octet de droite) dans RDX:
	movsx   rdx, edx
; décaler les 4 bits que nous avons obtenu de l'octet du milieu de 8 bits à gauche:
        sal     eax, 8
; charger l'octet de droite:
        movzx   edx, BYTE PTR array[rdx]
; fusionner les valeurs:
        or      eax, edx
        ret

