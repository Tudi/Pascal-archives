unit graph2;
interface
const vseg=$a000;
      border=true;
      amp1=20; amp2=8;
      spd1=2; spd2=4;
      lines=23; lineoffset=4;
type point=record
       x,y,z:integer;
     end;
var pot:pointer;
    bitmap:array[0..lines*320-1] of byte;
    cpos:array[0..319] of word;
    fseg,fofs:word;

procedure line2(x5, y5, x6, y6 : Integer ; col : byte );
procedure put_pixel(x,y:integer;col:byte);
procedure setGr(mode:Byte);
procedure clear(p:pointer);
procedure copyfrom(p:pointer);
procedure setpal(c,r,g,b:byte);
procedure setborder(col:byte);
procedure cls(lvseg:word);
Procedure GetPal(Color: Byte; Var Red, Green, Blue: Byte);
procedure getfont;
procedure retrace;
procedure drawmap;
procedure scrollbitmap(var map);
procedure outtext2(txt:string;oszlop,sor,szin,alap,lassu:byte);
procedure putpixel(x,y : word; c : byte);
procedure copyfrom2(target,source:pointer);
function getpixel(x,y : word) : byte;
procedure copymem(target,source:pointer;sor,oszlop:word);
procedure kepKirako(bitmap: pointer; x, y, width, height: integer) ;


implementation

procedure kepKirako(bitmap: pointer; x, y, width, height: integer) ; Assembler ;
  asm

  les  di, pot{}
  xor  di, di
  mov  ax, y
  mov  bx, 320
  mul  bx
  add  ax, x
  add  di, ax

  push ds

  lds  si, bitmap
  mov  dx, height

@nagyCiklus:
  mov  cx, width
  xor  ax, ax
@kisCiklus:
  cmp  ds:[si], al
  jz @a_pixel_zero
  movsb
  jmp @a_pixel_nem_zero
  @a_pixel_zero:
  inc  si
  inc  di
  @a_pixel_nem_zero:
  loop @kisCiklus
  add  di,320
  sub  di, width
  dec  dx
  jnz  @nagyCiklus

  pop  ds
  end ;

procedure copymem(target,source:pointer;sor,oszlop:word);
var s1,s2,o2,o1:word;
begin
  s1:=seg(target^);
  s2:=seg(source^);
  o1:=ofs(target^);
  o2:=ofs(source^);
  sor:=sor div 2;
  oszlop:=oszlop div 2;
asm
  push ds
  push es
  push si
  push di
  mov ax,s1
  mov es,ax
  mov di,o1
  mov si,o2
  mov dx,sor
 @sorm:pop ds
  mov cx,oszlop
  add di,dx
  dec(dx);
  mov ax,s2
  mov ds,ax
  db 66h{}
  rep movsw
  or dx,dx
  jnz @sorm
  pop di
  pop si
  pop es
  pop ds
end;
end;

procedure copyfrom2(target,source:pointer);
var s1,s2:word;
begin
  s1:=seg(target^);
  s2:=seg(source^);
asm
  push ds
  push es
  push si
  push di
  mov cx,4000h
  mov ax,s1
  mov es,ax
  xor di,di
  mov ax,s2
  xor si,si
  mov ds,ax
  db 66h{}
  rep movsw
  pop di
  pop si
  pop es
  pop ds
end;
end;

procedure putpixel(x,y : word; c : byte);
assembler;
 asm
  mov ax,vseg;
  mov es,ax;
  mov ax,y;
  mov dx,320;
  mul dx
  mov di,ax;
  add di,x;
  mov al,c;
  mov [es:di],al
 end;

procedure getfont; assembler;
asm
  mov ax,1130h
  mov bh,6
  int 10h
  mov fseg,es
  mov fofs,bp
end;

procedure drawmap; assembler;
{ for j:=0 to 11 do for i:=0 to 319 do
    mem[sega000:cpos[i]+j*320]:=bitmap[j,i];}
var _cx:word;
asm
  mov es,sega000
  xor cx,cx
 @l0:
  xor dx,dx
  mov si,cx
  add si,cx
  mov di,word ptr cpos[si]
  mov si,cx
 @l1:
  mov al,byte ptr bitmap[si]
  mov [es:di],al
  add si,320
  add di,320
  inc dl
  cmp dl,lines
  jne @l1
  inc cx
  cmp cx,319
  jne @l0
end;

procedure scrollbitmap(var map); assembler;
asm
  lds si,map
  les di,map
  inc si
  add si,lineoffset*320
  add di,lineoffset*320
  mov cx,2560
  rep movsw
end;

procedure outtext2(txt:string;oszlop,sor,szin,alap,lassu:byte);
var i:word;
    j,idx,idx2,scridx,ch,cp:byte;
begin
{!!!peldaprogram!!!
 setgr($13);
 getfont;
  outtext2('ma szep ido lessz',9,0,1,0);
  readkey;{}
  cp:=7;
  scridx:=1;
  ch:=byte(txt[scridx]);
  for i:=0 to 319 do cpos[i]:=320*sor+oszlop;
  fillchar(bitmap,sizeof(bitmap),0);
  while scridx<=length(txt) do
  begin
    if lassu=1 then retrace;{}
    if scridx<=length(TXT)THEN for i:=0 to 319 do cpos[i]:=cpos[i]+1;
    scrollbitmap(bitmap);
    for j:=0 to 15 do
      bitmap[(lineoffset+trunc(j/1.5))*320+319]:=
        ((mem[fseg:fofs+ch*16+j]shr cp) and 1)*{szin+alap*{}(32+cp+j+scridx mod 60){};
    dec(cp);
    cp:=cp mod 8;
    if cp=0 then begin
      scridx:=1+scridx;
      ch:=byte(txt[scridx]);
    end;
    drawmap;
  end;
end;

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


procedure cls(lvseg:word); assembler;
asm
  mov es,[lvseg]
  xor di,di
  xor ax,ax
  mov cx,320*200/2
  rep stosw
end;

procedure setborder(col:byte);
assembler;
asm
  xor ch,ch;
  mov cl,border;
  jcxz @out;
  mov dx,3dah;
  in al,dx
  mov dx,3c0h;
  mov al,11h+32;
  out dx,al;
  mov al,col;
  out dx,al;
  @out:
end;

function getpixel(x,y : word) : byte;
assembler;
 asm
  mov ax,vseg;
  mov es,ax;
  mov ax,y;
  mov dx,320;
  mul dx
  mov di,ax;
  add di,x;
  mov al,[es:di]
  end;

procedure retrace;
{var a grafikus portra(szinkronizalja a kepernyot es a memoriat)}
assembler;
asm
  mov dx,03dah
 @l1:
  in al,dx
  test al,8
  jnz @l1
 @l2:
  in al,dx
  test al,8
  jz @l2
end;


procedure setpal(c,r,g,b:byte); assembler; asm
  mov dx,3c8h; mov al,[c]; out dx,al; inc dx; mov al,[r]
  out dx,al; mov al,[g]; out dx,al; mov al,[b]; out dx,al; end;


procedure line2(x5, y5, x6, y6 : Integer ; col : byte );
var ddx, ddy : integer ;
    m    : real ;
    i    : word ;
    k, l : shortint ;
    x4, y4 : integer ;
    s    : word ;
begin
  ddx := x6 - x5 ; if ddx < 0 then k := -1 else k := 1 ;
  ddy := y6 - y5 ; if ddy < 0 then l := -1 else l := 1 ;
  s := seg ( pot^ ) ;
  if abs ( ddy ) < abs ( ddx ) then
  begin
  if (ddx = 0) and (ddy = 0) then exit ;
  m := abs(ddy/ddx) ;
  asm
  mov ax, s            {put the first point}
  mov es, ax

  mov ax, y5
  mov di, x5
  xchg ah, al
  add di, ax
  shr ax, 2
  add di, ax

  mov al, col
  mov es:[di], al
  end ;
  for i := 1 to abs(ddx)-1 do
   begin

   x4 := x5+i*k ; y4 := y5+trunc(m*i)*l ;
    asm
    mov ax, y4
    mov di, x4
    xchg ah, al
    add di, ax
    shr ax, 2
    add di, ax

    mov al, col
    mov es:[di], al
    end ;
   end ;
  end

  else
  begin
  asm
  mov ax, s            {put the first point}
  mov es, ax

  mov ax, y5
  mov di, x5
  xchg ah, al
  add di, ax
  shr ax, 2
  add di, ax

  mov al, col
  mov es:[di], al
  end ;
  if (ddx = 0) and (ddy = 0) then exit ;
  m := abs(ddx/ddy) ;
  for i := 1 to abs(ddy)-1 do
   begin
   y4 := y5+i*l ; x4 := x5+trunc(m*i)*k ;
    asm
    mov ax, y4
    mov di, x4
    xchg ah, al
    add di, ax
    shr ax, 2
    add di, ax

    mov al, col
    mov es:[di], al
    end ;
   end ;
  end ;
end ;
procedure put_pixel ( x, y : integer ; col : byte ) ;
var l,o : word ;
begin
l := seg (pot^) ;
asm
  mov ax, l          {put the first point}
  mov es, ax
  mov ax, y
  cmp ax, 199
  ja  @ende
  mov di, x
  cmp di, 319
  ja  @ende
  xchg ah, al
  add di, ax
  shr ax, 2
  add di, ax
  mov al, col
  mov es:[di], al
@ende:
end ;end;

procedure setGr(mode: Byte) ; Assembler ;
  asm
  mov   al, mode
  mov   ah, 00h
  int   10h
  end;

procedure clear (p : pointer);
var s : word ;
begin
  s := seg (p^) ;
asm
  mov   ax, s
  mov   es, ax
  xor   ax, ax
  mov   di, ax
  mov   cx, 8000h
  rep   stosw
end ;
end ;

procedure copyfrom(p : pointer) ;
var s,o : word ;
begin
  s := seg (p^) ; o := ofs(p^) ;
  asm
  push   es
  push   ds
  mov    ax, 0a000h
  mov    es, ax
  xor    di, di
  xor    si, si
  mov    cx, 4000h
  mov    ax, s
  mov    ds, ax
  db 66h{}
  rep    movsw
  pop    ds
  pop    es
  end ;
end ;
end.