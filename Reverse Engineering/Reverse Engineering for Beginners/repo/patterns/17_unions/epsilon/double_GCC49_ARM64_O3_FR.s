calculate_machine_epsilon:
	fmov	x0, d0       ; charger la valeur d'entrée de type double dans X0
	add	x0, x0, 1    ; X0++
	fmov	d1, x0       ; la déplacer dans le registre du FPU
	fsub	d0, d1, d0   ; soustraire
	ret
