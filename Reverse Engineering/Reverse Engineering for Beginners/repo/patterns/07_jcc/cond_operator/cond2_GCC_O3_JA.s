.LC0:
	.string	"it is ten"
.LC1:
	.string	"it is not ten"
f:
.LFB0:
; 入力値と10を比較
	cmp	DWORD PTR [esp+4], 10
	mov	edx, OFFSET FLAT:.LC1 ; "it is not ten"
	mov	eax, OFFSET FLAT:.LC0 ; "it is ten"
; 比較結果が同じでなければ、EDXの値をEAXにコピー
; そうでなければ、何もしない
	cmovne	eax, edx
	ret
