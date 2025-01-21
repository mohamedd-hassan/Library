my_abs:
; étendre le signe de la valeur 32-bit en entrée dans le registre X0 64-bit:
	sxtw	x0, w0
	eor	x1, x0, x0, asr 63
; \verb|X1=X0^(X0>>63) (le décalage est arithmétique)|
	sub	x0, x1, x0, asr 63
; \verb|X0=X1-(X0>>63)=X0^(X0>>63)-(X0>>63)|
; (tous les décalages sont arithmétiques)
	ret
