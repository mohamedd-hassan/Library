__real@3f800000 DD 03f800000r	; 1

tv128 = -4
_tmp$ = -4
?float_rand@@YAMXZ PROC
	push	ecx
	call	?my_rand@@YAIXZ
; EAX=疑似乱数値
	and	eax, 8388607	; 007fffffH
	or	eax, 1065353216	; 3f800000H
; EAX=疑似乱数値 \& 0x007fffff | 0x3f800000
; ローカルスタックに保存
	mov	DWORD PTR _tmp$[esp+4], eax
; 浮動小数点数としてリロード
	movss	xmm0, DWORD PTR _tmp$[esp+4]
; 1.0を減算
	subss	xmm0, DWORD PTR __real@3f800000
; 一時変数に置くことで値をST0にムーブ
	movss	DWORD PTR tv128[esp+4], xmm0
; 値をSTOにリロード
	fld	DWORD PTR tv128[esp+4]
	pop	ecx
	ret	0
?float_rand@@YAMXZ ENDP
