 uses crt;
 Procedure Caps(ONorOFF:boolean);Assembler;

    asm
    cmp ONorOFF,1
    je @BeLight
    jmp @BeDarkness
    @BeLight:
     MOV SI,40h
     MOV ES,SI
     MOV AL,ES:[0017h]
     OR  AL,40h
     MOV ES,SI
     MOV ES:[0017h],AL
     jmp @FINISH
    @BeDarkness:
     MOV SI,40h
     MOV ES,SI
     MOV AL,ES:[0017h]
     AND AL,0BFh
     MOV ES,SI
     MOV ES:[0017h],AL
    @FINISH:
     MOV AH,1
     INT 16h
    end;

  Procedure NumLock(ONorOFF:Boolean);Assembler;
    asm
    cmp ONorOFF,1
    je @BeLight
    jmp @BeDarkness
    @BeLight:
     MOV SI,40h
     MOV ES,SI
     MOV AL,ES:[0017h]
     OR  AL,20h
     MOV ES,SI
     MOV ES:[0017h],AL
     jmp @FINISH
    @BeDarkness:
     MOV SI,40h
     MOV ES,SI
     MOV AL,ES:[0017h]
     AND AL,0DFh
     MOV ES,SI
     MOV ES:[0017h],AL
    @FINISH:
     MOV AH,1
     INT 16h
    end;

  Procedure ScrLock(ONorOFF:Boolean);Assembler;
    asm
    cmp ONorOFF,1
    je @BeLight
    jmp @BeDarkness
    @BeLight:
     MOV SI,40h
     MOV ES,SI
     MOV AL,ES:[0017h]
     OR  AL,10h
     MOV ES,SI
     MOV ES:[0017h],AL
     jmp @FINISH
    @BeDarkness:
     MOV SI,40h
     MOV ES,SI
     MOV AL,ES:[0017h]
     AND AL,0EFh
     MOV ES,SI
     MOV ES:[0017h],AL
    @FINISH:
     MOV AH,1
     INT 16h
    end;
begin
repeat
numlock(true);
delay(20);
numlock(false);
delay(80);
caps(true);
delay(20);
caps(false);
delay(80);
ScrLock(true);
delay(20);
ScrLock(false);
delay(80);
until keypressed;
numlock(true);
END.
