calculate_machine_epsilon:
	fmov	x0, d0       ; double型の入力値をX0にロード
	add	x0, x0, 1    ; X0++
	fmov	d1, x0       ; FPUレジスタにムーブ
	fsub	d0, d1, d0   ; 引く
	ret
