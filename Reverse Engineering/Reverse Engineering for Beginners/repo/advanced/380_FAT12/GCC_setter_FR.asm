put_to_array:
; EDI=idx
; ESI=val
; copier idx dans EAX:
        mov     eax, edi
; calculer idx>>1 et le mettre dans EAX:
        shr     eax
; isoler le bit le plus bas dans idx:
        and     edi, 1
; calculer (idx>>2)*3 et le mettre dans EAX:
        lea     eax, [rax+rax*2]
; sauter si l'index est impair (NE est la même chose que NZ (Not Zero)):
        jne     .L5

; ceci est un élément pair, continuer
; étendre l'adresse du triplet dans EAX à RDX:
        movsx   rdx, eax
; copier la valeur val dans ECX:
        mov     ecx, esi
; calculer l'adresse de l'octet du milieu:
        add     eax, 1
; étendre le signe de EAX à RDX:
        cdqe
; préparer l'octet de gauche dans ECX en le décalant:
        shr     ecx, 4
; préparer 4 bits pour l'octet du milieu:
        sal     esi, 4
; mettre l'octet de gauche:
        mov     BYTE PTR array[rdx], cl
; charger l'octet du milieu (son adresse est toujours dans RAX):
        movzx   edx, BYTE PTR array[rax]
; supprimer les 4 bits hauts:
        and     edx, 15 ; 15=0xF
; fusionner notre donnée et les 4 bits qui étaient là avant:
        or      esi, edx
; remettre l'octet du milieu:
        mov     BYTE PTR array[rax], sil
        ret
.L5:
; ceci est un élément impair, continuer
; calculer l'adresse de l'octet du milieu et la mettre dans ECX:
        lea     ecx, [rax+1]
; copier la valeur val de ESI dans EDI:
        mov     edi, esi
; calculer l'adresse de l'octet de droite:
        add     eax, 2
; obtenir les 4 bits hauts de la valeur entrée en la décalant de 8 bits à droite:
        shr     edi, 8
; étendre le signe de l'adresse dans EAX dans RAX:
        cdqe
; étendre le signe de l'adresse de l'octet du milieu dans ECX à RCX:
        movsx   rcx, ecx
; charger l'octet du milieu dans EDX:
        movzx   edx, BYTE PTR array[rcx]
; supprimer les 4 bits bas de l'octet du milieu:
	and     edx, -16 ; -16=0xF0
; fusionner les données de l'entrée val avec ce qui était dans l'octet du milieu avant:
        or      edx, edi
; stocker l'octet du milieu:
        mov     BYTE PTR array[rcx], dl
; stocker l'octet de droite. val est toujours dans ESI et SIL est la partie du registre
; ESI qui contient les 8 bits bas:
        mov     BYTE PTR array[rax], sil
        ret

