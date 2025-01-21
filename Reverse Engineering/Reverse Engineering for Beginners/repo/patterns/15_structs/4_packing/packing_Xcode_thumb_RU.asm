var_C = -0xC

      PUSH   {R7,LR}
      MOV    R7, SP
      SUB    SP, SP, #4
      MOV    R9, R1 ; b
      MOV    R1, R0 ; a
      MOVW   R0, #0xF10 ; \verb|"a=%d; b=%d; c=%d; d=%d\n"|
      SXTB   R1, R1  ; подготовить a
      MOVT.W R0, #0
      STR    R3, [SP,#0xC+var_C] ; сохранить d в стек для printf()
      ADD    R0, PC  ; строка формата
      SXTB   R3, R2  ; подготовить c
      MOV    R2, R9  ; b
      BLX    _printf
      ADD    SP, SP, #4
      POP    {R7,PC}
