.LC0:
	.string	"a[%d]=%d\n"
main:
; sauver FR et LR sur la stack frame:
	stp	x29, x30, [sp, -112]!
; définir l'environnement de pile (FP=SP)
	add	x29, sp, 0
; initialiser la variable compteur à 0 
; (WZR est le registre qui contient toujours zéro):
	str	wzr, [x29,108]
; sauter au code de test de condition de la boucle:
	b	.L2
.L3:
; charger la valeur de la variable "i":
	ldr	w0, [x29,108]
; la multiplier par 2:
	lsl	w2, w0, 1
; trouver la place du tableau dans la pile locale:
	add	x0, x29, 24
; charger l'entier 32-bit depuis la pile locale et l'étendre en un 64-bit signé:
	ldrsw	x1, [x29,108]
; calculer l'adresse de l'élément (X0+X1<<2=adresse du tableau+i*4) 
; et y stocker W2 (i*2):
	str	w2, [x0,x1,lsl 2]
; incrémenter le compteur (i):
	ldr	w0, [x29,108]
	add	w0, w0, 1
	str	w0, [x29,108]
.L2:
; tester si la boucle est finie:
	ldr	w0, [x29,108]
	cmp	w0, 19
; sauter en L3 (début du corps de la boucle) si non:
	ble	.L3
; La seconde partie de la fonction commence ici.
; mettre la valeur initiale da la variable compteur à 0.
; à propos, le même espace est utilisé dans la pile locale,
; car la même variable locale (i) est utilisée comme compteur.
	str	wzr, [x29,108]
	b	.L4
.L5:
; calculer l'adresse dans le tableau:
	add	x0, x29, 24
; charger la valeur de "i":
	ldrsw	x1, [x29,108]
; charger la valeur du tableau à l'adresse (X0+X1<<2 = adresse du tableau + i*4)
	ldr	w2, [x0,x1,lsl 2]
; charger l'adresse de la chaîne \verb|"a[%d]=%d\n"|:
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; charger la variable "i" dans W1 et la passer à printf() comme second argument:
	ldr	w1, [x29,108]
; W2 contient toujours la valeur de l'élément du tableau qui vient d'être chargée.
; appeler printf():
	bl	printf
; incrémenter la variable "i":
	ldr	w0, [x29,108]
	add	w0, w0, 1
	str	w0, [x29,108]
.L4:
; est-ce fini?
	ldr	w0, [x29,108]
	cmp	w0, 19
; sauter au début du corps de la boucle si non:
	ble	.L5
; renvoyer 0
	mov	w0, 0
; restaurer FP et LR:
	ldp	x29, x30, [sp], 112
	ret
