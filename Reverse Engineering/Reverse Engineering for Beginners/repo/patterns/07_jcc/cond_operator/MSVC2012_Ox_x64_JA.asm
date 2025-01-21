$SG1355	DB	'it is ten', 00H
$SG1356	DB	'it is not ten', 00H

a$ = 8
f	PROC
; 両方の文字列のポインタをロードする
	lea	rdx, OFFSET FLAT:$SG1355 ; 'it is ten'
	lea	rax, OFFSET FLAT:$SG1356 ; 'it is not ten'
; 入力値と10を比較
	cmp	ecx, 10
; 同じなら、値をRDXからコピー("it is ten")
; 異なるなら、何もしない。文字列へのポインタ
; "it is not ten"はまだRAXにある。
	cmove	rax, rdx
	ret	0
f	ENDP
