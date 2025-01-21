; RDI=配列のアドレス
; RSI=a
; RDX=b

get_by_coordinates1:
; 32ビットint値の"a"と"b"を64ビットの符号付きintに拡張
	movsx	rsi, esi 
	movsx	rdx, edx
	lea	rax, [rdi+rsi*4]
; RAX=RDI+RSI*4=配列のアドレス+a*4
	movzx	eax, BYTE PTR [rax+rdx]
; AL=RAX+RDXアドレスのバイトをロード=配列のアドレス+a*4+b
	ret

get_by_coordinates2:
	lea	eax, [rdx+rsi*4]
; RAX=RDX+RSI*4=b+a*4
	cdqe
	movzx	eax, BYTE PTR [rdi+rax]
; AL=RDI+RAXアドレスのバイトをロード=配列のアドレス+b+a*4
	ret

get_by_coordinates3:
	sal	esi, 2
; ESI=a<<2=a*4
; 32ビットint値の"a*4"と"b"を64ビットの符号付きintに拡張
	movsx	rdx, edx
	movsx	rsi, esi
	add	rdi, rsi
; RDI=RDI+RSI=配列のアドレス+a*4
	movzx	eax, BYTE PTR [rdi+rdx]
; AL=RDI+RDXアドレスのバイトをロード=配列のアドレス+a*4+b
	ret
