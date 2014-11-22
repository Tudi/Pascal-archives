Unit Eger;

Interface

Uses
  Dos ;

Type
  EgerKurzorTip = Record
                    CsucsX,
                    CsucsY : Word ;
                    Kurzor : Array[1..32] Of Word ;
                  End ;

Var
  EgerJelen : Boolean ;

Procedure EgerInit ;
Procedure EgerBe ;
Procedure EgerKi ;
Function  BalGomb : Boolean ;
Function  JobbGomb : Boolean ;
Function  SzovegEgerX : Word ;
Function  SzovegEgerY : Word ;
Procedure SzovegEgerXY(X,Y: Word) ;
Function  GrafEgerX : Word ;
Function  GrafEgerY : Word ;
Procedure GrafEgerXY(X,Y: Word) ;
Procedure GrafEgerAblak(X1,Y1,X2,Y2: Word) ;
Procedure SzovegEgerAblak(X1,Y1,X2,Y2: Word) ;
Procedure GrafEgerKurzor(CsucsX,CsucsY: Word ;
                         KurzorMutato: Pointer) ;
Implementation

Procedure EgerInit ;
  Var
    R : Registers ;
  Begin
    R.AX := 0 ;
    Intr($33,R) ;
    EgerJelen := R.AX <> 0 ;
  End ;

Procedure EgerBe ;
  Var
    R : Registers ;
  Begin
    R.AX := 1 ;
    Intr($33,R) ;
  End ;

Procedure EgerKi ;
  Var
    R : Registers ;
  Begin
    R.AX := 2 ;
    Intr($33,R) ;
  End ;

Function BalGomb : Boolean ;
  Var
    R : Registers ;
  Begin
    R.AX := 3 ;
    Intr($33,R) ;
    BalGomb := R.BX And 1 = 1 ;
  End ;

Function JobbGomb : Boolean ;
  Var
    R : Registers ;
  Begin
    R.AX := 3 ;
    Intr($33,R) ;
    JobbGomb := R.BX And 2 = 2 ;
  End ;

Function SzovegEgerX : Word ;
  Var
    R : Registers ;
  Begin
    R.AX := 3 ;
    Intr($33,R) ;
    SzovegEgerX := R.CX Div 8 + 1 ;
  End ;

Function SzovegEgerY : Word ;
  Var
    R : Registers ;
  Begin
    R.AX := 3 ;
    Intr($33,R) ;
    SzovegEgerY := R.DX Div 8 + 1 ;
  End ;

Procedure SzovegEgerXY(X,Y: Word) ;
  Var
    R : Registers ;
  Begin
    R.CX := (X-1) * 8 ;
    R.DX := (Y-1) * 8 ;
    R.AX := 4 ;
    Intr($33,R) ;
  End ;

Function GrafEgerX : Word ;
  Var
    R : Registers ;
  Begin
    R.AX := 3 ;
    Intr($33,R) ;
    GrafEgerX := R.CX ;
  End ;

Function GrafEgerY : Word ;
  Var
    R : Registers ;
  Begin
    R.AX := 3 ;
    Intr($33,R) ;
    GrafEgerY := R.DX ;
  End ;

Procedure GrafEgerXY(X,Y: Word) ;
  Var
    R : Registers ;
  Begin
    R.CX := X ;
    R.DX := Y ;
    R.AX := 4 ;
    Intr($33,R) ;
  End ;

Procedure GrafEgerAblak(X1,Y1,X2,Y2: Word) ;
  Var
    R : Registers ;
  Begin
    R.CX := X1 ;
    R.DX := X2 ;
    R.AX := 7 ;
    Intr($33,R) ;
    R.CX := Y1 ;
    R.DX := Y2 ;
    R.AX := 8 ;
    Intr($33,R) ;
  End ;

Procedure SzovegEgerAblak(X1,Y1,X2,Y2: Word) ;
  Var
    R : Registers ;
  Begin
    R.CX := (X1 - 1) * 8 ;
    R.DX := (X2 - 1) * 8 ;
    R.AX := 7 ;
    Intr($33,R) ;
    R.CX := (Y1 - 1) * 8 ;
    R.DX := (Y2 - 1) * 8 ;
    R.AX := 8 ;
    Intr($33,R) ;
  End ;

Procedure GrafEgerKurzor(CsucsX,CsucsY: Word ;
                        KurzorMutato: Pointer) ;
  Var
    R : Registers ;
  Begin
    R.BX := CsucsX ;
    R.CX := CsucsY ;
    R.ES := Seg(KurzorMutato^) ;
    R.DX := Ofs(KurzorMutato^) ;
    R.AX := 9 ;
    Intr($33,R) ;
  End ;

End.
