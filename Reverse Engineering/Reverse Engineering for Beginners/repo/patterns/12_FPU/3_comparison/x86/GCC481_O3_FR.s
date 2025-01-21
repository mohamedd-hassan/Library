	fld	QWORD PTR [esp+4]	; charger "a"
	fld	QWORD PTR [esp+12]	; charger "b"
	; ST0=b, ST1=a
	fxch	st(1)
	; ST0=a, ST1=b
	; comparer "a" et "b"
	fucomi	st, st(1)
	; copier ST1 ("b" ici) dans ST0 si a<=b
	; laisser "a" dans ST0 autrement
	fcmovbe	st, st(1)
	; supprimer la valeur dans ST1
	fstp	st(1)
	ret
