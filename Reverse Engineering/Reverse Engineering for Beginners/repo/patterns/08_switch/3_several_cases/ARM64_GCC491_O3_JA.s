f14:
; 入力値はW0にある
	sub	w0, w0, #1
	cmp	w0, 21
; 以下の場合に分岐(unsigned):
	bls	.L9
.L2:
; "default"を表示
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	b	puts
.L9:
; X1にジャンプテーブルのアドレスをロードする:
	adrp	x1, .L4
	add	x1, x1, :lo12:.L4
; W0=input\_value-1
; テーブルからバイトをロード:
	ldrb	w0, [x1,w0,uxtw]
; Lrtxラベルのアドレスをロードする
	adr	x1, .Lrtx4
; テーブルの要素に4をかける(2ビット左シフトすることで)。Lrtxのアドレスに足す(または引く)
	add	x0, x1, w0, sxtb #2
; 計算したアドレスにジャンプする
	br	x0
; このラベルはコード(text)セグメントを指す
.Lrtx4:
	.section	.rodata
; ".section"ステートメントの後にあるものは読み取り専用のセグメント(rodata)に配置されるdata
.L4:
	.byte	(.L3 - .Lrtx4) / 4     ; case 1
	.byte	(.L3 - .Lrtx4) / 4     ; case 2
	.byte	(.L5 - .Lrtx4) / 4     ; case 3
	.byte	(.L5 - .Lrtx4) / 4     ; case 4
	.byte	(.L5 - .Lrtx4) / 4     ; case 5
	.byte	(.L5 - .Lrtx4) / 4     ; case 6
	.byte	(.L3 - .Lrtx4) / 4     ; case 7
	.byte	(.L6 - .Lrtx4) / 4     ; case 8
	.byte	(.L6 - .Lrtx4) / 4     ; case 9
	.byte	(.L3 - .Lrtx4) / 4     ; case 10
	.byte	(.L2 - .Lrtx4) / 4     ; case 11
	.byte	(.L2 - .Lrtx4) / 4     ; case 12
	.byte	(.L2 - .Lrtx4) / 4     ; case 13
	.byte	(.L2 - .Lrtx4) / 4     ; case 14
	.byte	(.L2 - .Lrtx4) / 4     ; case 15
	.byte	(.L2 - .Lrtx4) / 4     ; case 16
	.byte	(.L2 - .Lrtx4) / 4     ; case 17
	.byte	(.L2 - .Lrtx4) / 4     ; case 18
	.byte	(.L2 - .Lrtx4) / 4     ; case 19
	.byte	(.L6 - .Lrtx4) / 4     ; case 20
	.byte	(.L6 - .Lrtx4) / 4     ; case 21
	.byte	(.L7 - .Lrtx4) / 4     ; case 22
	.text
; ".text"ステートメントの後にあるものはコードセグメント(text)に配置される
.L7:
; "22"を表示
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	b	puts
.L6:
; "8, 9, 21"を表示
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	b	puts
.L5:
; "3, 4, 5"を表示
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	b	puts
.L3:
; "1, 2, 7, 10"を表示
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	b	puts
.LC0:
	.string	"1, 2, 7, 10"
.LC1:
	.string	"3, 4, 5"
.LC2:
	.string	"8, 9, 21"
.LC3:
	.string	"22"
.LC4:
	.string	"default"
