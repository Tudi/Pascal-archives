unit graph2;
interface
type point=record
       x,y,z:integer;
     end;
var pot:pointer;
procedure line2(x1,y1,x2,y2:Integer;col:byte);
procedure put_pixel(x,y:integer;col:byte);
procedure setGr(mode:Byte);
procedure clear(p:pointer);
procedure copyfrom(p:pointer);
procedure setpal(c,r,g,b:byte);

implementation

procedure setpal(c,r,g,b:byte); assembler; asm
  mov dx,3c8h; mov al,[c]; out dx,al; inc dx; mov al,[r]
  out dx,al; mov al,[g]; out dx,al; mov al,[b]; out dx,al; end;


procedure line2(x1, y1, x2, y2 : Integer ; col : byte ) ;
var ddx, ddy : integer ;
    m    : real ;
    i    : word ;
    k, l : shortint ;
    x, y : integer ;
    s    : word ;
begin
  ddx := x2 - x1 ; if ddx < 0 then k := -1 else k := 1 ;
  ddy := y2 - y1 ; if ddy < 0 then l := -1 else l := 1 ;
  s := seg ( pot^ ) ;
  if abs ( ddy ) < abs ( ddx ) then
  begin
  if (ddx = 0) and (ddy = 0) then exit ;
  m := abs(ddy/ddx) ;
  asm
  mov ax, s            {put the first point}
  mov es, ax

  mov ax, y1
  mov di, x1
  xchg ah, al
  add di, ax
  shr ax, 2
  add di, ax

  mov al, col
  mov es:[di], al
  end ;

  for i := 1 to abs(ddx)-1 do
   begin
    x := x1+i*k ;
    y := y1+trunc(m*i)*l ;
    asm
    mov ax, y
    mov di, x
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

  mov ax, y1
  mov di, x1
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
   y := y1+i*l ; x := x1+trunc(m*i)*k ;
    asm
    mov ax, y
    mov di, x
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
  mov    cx, 8000h
  mov    ax, s
  mov    ds, ax
  rep    movsw
  pop    ds
  pop    es
  end ;
end ;
end.