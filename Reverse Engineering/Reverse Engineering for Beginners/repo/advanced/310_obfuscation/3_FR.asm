; ESI=0
add	eax, ebx	; code réel
mul	ecx		; code réel
add	eax, esi	; prédicat opaque.
              ; XOR, AND ou SHL, etc, peuvent être ici au lieu de ADD.
