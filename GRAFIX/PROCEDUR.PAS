
Procedure GetPal(Color: Byte; Var Red, Green, Blue: Byte);
Var
   R, G, B: Byte;
Begin
   Asm
      MOV       DX,3C7h
      MOV       AL,COLOR
      OUT       DX,AL

      ADD       DX,2

      IN        AL,DX
      MOV       [R],AL
      IN        AL,DX
      MOV       [G],AL
      IN        AL,DX
      MOV       [B],AL
   End;
   Red:= R;
   Green:= G;
   Blue:= B;
End;


procedure getfont8x8; assembler; asm
  mov ax,1130h; mov bh,1; int 10h; mov fseg,es; mov fofs,bp; end;

procedure setimage(ch : char; var data);
var offset : word;
begin
  offset := ord(ch)*32;
  inline($fa);
  portw[$03c4] := $0402;
  portw[$03c4] := $0704;
  portw[$03ce] := $0204;
  portw[$03ce] := $0005;
  portw[$03ce] := $0006;
  move(data,ptr($a000,offset)^,8);
  portw[$03c4] := $0302;
  portw[$03c4] := $0304;
  portw[$03ce] := $0004;
  portw[$03ce] := $1005;
  portw[$03ce] := $0E06;
  inline($fb);
end;
  textmode(co80+font8x8);

procedure putpixel(x,y : word; c : byte); assembler; asm
  mov ax,vseg; mov es,ax; mov ax,y; mov dx,320; mul dx
  mov di,ax; add di,x; mov al,c; mov [es:di],al end;

function getpixel(x,y : word) : byte; assembler; asm
  mov ax,vseg; mov es,ax; mov ax,y; mov dx,320; mul dx
  mov di,ax; add di,x; mov al,[es:di] end;


function mouseinstalled : boolean; assembler; asm
  xor ax,ax; int 33h; cmp ax,-1; je @skip; xor al,al; @skip: end;

function getmousex : word; assembler; asm
  mov ax,3; int 33h; mov ax,cx end;

function getmousey : word; assembler; asm
  mov ax,3; int 33h; mov ax,dx end;

function leftpressed : boolean; assembler; asm
  mov ax,3; int 33h; and bx,1; mov ax,bx end;

procedure mousesensetivity(x,y : word); assembler; asm
  mov ax,1ah; mov bx,x; mov cx,y; xor dx,dx; int 33h end;

procedure mousewindow(l,t,r,b : word); assembler; asm
  mov ax,7; mov cx,l; mov dx,r; int 33h; mov ax,8
  mov cx,t; mov dx,b; int 33h end;

procedure SetGraphics;
var GrMd,GrDr : integer;

{$F+} function DetectVGA : Integer; begin DetectVGA := 2; end; {$F-}

begin
  InstallUserDriver('SVGA256',@DetectVGA); GrDr := 0;
  InitGraph(GrDr,GrMd,'C:\PROGRAMS\PASCAL\BGI');
end;

procedure setpalette(var pal); assembler;
asm
  push ds
  mov dx,03c8h
  xor ax,ax
  out dx,al
  inc dx
  lds si,pal
  mov cx,0300h
  rep outsb
  pop ds
end;
 setpalette(palette);
 for i:=1 to 255 do setpal(i,255-i div 4,255-i div 4,30);

procedure initcolors;
var i : byte;
begin
  for i := 0 to 63 do begin
    setpal(i+1,21+i div 3,21+i div 3,63-i);
    setpal(i+65,42-i div 3,42+i div 3,i div 3);
  end;
end;
procedure setborder(col:byte); assembler; asm
  xor ch,ch; mov cl,border; jcxz @out; mov dx,3dah; in al,dx
  mov dx,3c0h; mov al,11h+32; out dx,al; mov al,col; out dx,al; @out: end;

procedure setpal(col,r,g,b : byte); assembler; asm
  mov dx,03c8h; mov al,col; out dx,al; inc dx; mov al,r
  out dx,al; mov al,g; out dx,al; mov al,b; out dx,al; end;
  for i:=1 to 255 do setpal(i,255-i div 6,255-i div 4,20);


procedure InstallColors(Buf : PalBuf);

  procedure SetColor(Color,Red,Green,Blue : byte);

  begin
    port[$3C8] := Color;
    port[$3C9] := Red;
    port[$3C9] := Green;
    port[$3C9] := Blue;
  end;

var
  I : byte;
  C : word;

begin
  C := 0;
  for I := 0 to 255 do begin
    SetColor(I,Buf[C],Buf[C+1],Buf[C+2]);
    inc(C,3);
  end;
end;
 InstallColors(Palette);

procedure cls(lvseg:word); assembler;
asm
  mov es,[lvseg]
  xor di,di
  xor ax,ax
  mov cx,320*200/2
  rep stosw
end;

procedure setpal(col,r,g,b : byte); assembler;
asm
  mov dx,03c8h
  mov al,col
  out dx,al
  inc dx
  mov al,r
  out dx,al
  mov al,g
  out dx,al
  mov al,b
  out dx,al
end;
  setpal(1,10,10,45);
  setpal(2,0,0,25);
  setpal(3,20,20,60);

procedure InitColors; var I : byte;

begin
  for I := 1 to 63 do begin
    port[$3C8] := I;
    port[$3C9] := 32;
    port[$3C9] := I div 2;
    port[$3C9] := I;
  end;
end;

procedure cls(lvseg:word); assembler; asm { clear segment }
  mov es,[lvseg]; xor di,di; xor ax,ax; mov cx,2*80*48; rep stosw; end;

procedure ssl(lvseg:word); assembler; asm { scrolls text screen left }
  push ds; mov es,[lvseg]; mov ds,[lvseg]; xor di,di; mov si,2; mov dx,48
  @l0: mov cx,79; rep movsw; add si,2; add di,2; dec dl; jnz @l0; pop ds; end;

procedure setpal(c,r,g,b:byte); assembler; asm
  mov dx,3c8h; mov al,[c]; out dx,al; inc dx; mov al,[r]
  out dx,al; mov al,[g]; out dx,al; mov al,[b]; out dx,al; end;
  for x:=0 to 63 do begin
    setpal(x,x div 4,x div 2,x);
    setpal(127-x,x div 4,x div 2,x);
    setpal(127+x,x,x div 4,x div 2);
    setpal(254-x,x,x div 4,x div 2);
  end;


procedure clrgraph; assembler;
asm
  mov dx,03c4h
  mov al,2
  out dx,al
  inc dx
  mov al,15
  out dx,al
  mov es,sega000
  xor di,di
  xor ax,ax
  mov cx,80*480/2
  rep stosw
end;

procedure putpixel(x,y:word; c:byte);
var b:byte;
begin
  port[$3c4]:=2;
  port[$3c5]:=c;
  b:=mem[sega000:y*80+x shr 3];
  mem[sega000:y*80+x shr 3]:=b or (1 shl (7-(x and 7)));
end;

