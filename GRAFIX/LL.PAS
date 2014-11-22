uses crt, dos ;

type point = record
       x, y, z : integer ;
     end ;

var  first, index : ^point ;
     leng         : word ;
     pot          : pointer ;
     pal          : array [1..48] of byte ;
     p            : integer ;

const
      m = 100 ;
      tav = 15 ;
      x0v = 150 ;
      y0v = 100 ;
      k   = 40 ;


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

procedure line (x1, y1, x2, y2 : Integer ; col : byte ) ;
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
   x := x1+i*k ; y := y1+trunc(m*i)*l ;
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

procedure setGr(mode: Byte) ; Assembler ;
  asm
  mov   al, mode
  mov   ah, 00h
  int   10h
  end;

const start = -350 ;
      finish = 450 ;

function f1(x:integer) : real ;
var temp : real ;
begin
  {temp :=  -30* exp(cos(pi*x/22.5)) + 50 ;{}
  {temp :=  3*sqrt ( abs( x )) + 7 ;{}
  temp := 30 * exp(cos(pi*(x+20)/90)) ;{}
  {temp := 50 ;{}
  {if (abs(0.7 * x) < 32) then temp := 32 else temp := abs(0.7*x) ;{}
  {if abs(x)<100 then temp := sqrt(10000-x*x)
         else temp := 15 * cos(pi*x/45) + 25 ;{}
  if temp < tav then temp := tav ;
  f1 := temp ;
end ;

function f2(x:integer) : real ;
begin
  f2 := 50 * exp(cos(pi*x/180)) ;
end ;

function num_points ( start, finish, dist : integer ) : word ;
var x, xp, count : integer ;
    last     : real ;
begin
  if start > finish then
    asm
    mov   ax, start
    xchg  ax, finish
    mov   start, ax
    end ;
  x := start ;
  count := 0 ;
  repeat
  count := count + trunc(pi/arctan(dist/(2*sqrt(f1(x)*f1(x)-dist*dist/4)))) ;
  last := f1(x) ; xp := x ;
    while dist > trunc (sqrt(sqr(x-xp)+sqr(f1(x)-last))) do
      inc (x) ;
  until x > finish ;
  num_points := count ;
end ;

procedure generate_points ( start, finish, dist : integer ) ;
var x, xp, i, count : integer ;
    last     : real ;
begin
  leng := num_points ( start, finish, dist ) ;
  getmem ( first, leng * sizeof(point)) ;
  index := first ;
  if start > finish then
    asm
    mov   ax, start
    xchg  ax, finish
    mov   start, ax
    end ;
  x := start ;
  repeat
  count := trunc(pi/arctan(dist/(2*sqrt(f1(x)*f1(x)-dist*dist/4)))) ;
  for i := 1 to count do
    begin
    index^.x := x ;
    index^.y := trunc (f1(x)*cos(2*pi*i/count)) ;
    index^.z := trunc (f1(x)*sin(2*pi*i/count)) ;
    index := ptr ( seg(index^), ofs(index^)+sizeof(point)) ;
    end ;
  last := f1(x) ; xp := x ;
    while dist > trunc (sqrt(sqr(x-xp)+sqr(f1(x)-last))) do
      inc (x) ;
  until x > finish ;
end ;

procedure generate_stars ( xi, xa, yi, ya, zi, za, nr_stars : integer) ;
var i : integer ;
  begin
  leng := nr_stars ;
  getmem(first, leng * sizeof(point)) ;
  index := first ;
  randomize ;
  for i := 1 to nr_stars do
    begin
    index^.x := random (xa - xi) + xi ;
    index^.y := random (ya - yi) + yi ;
    index^.z := random (za - zi) + zi ;
    index := ptr ( seg(index^), ofs(index^)+sizeof(point)) ;
    end ;
  end ;

procedure put_points ( alfa, beta : integer; col : byte ) ;
var i : integer ;
    sina, cosa : real ;
    sinb, cosb : real ;
    x1, y1, z1,
    xv, yv, zv : real ;
    xl, yl : real ;
    x0, y0 : integer ;
begin
  index := first ;
  sina := sin (pi*alfa/180) ;
  cosa := cos (pi*alfa/180) ;
  sinb := sin (pi*beta/180) ;
  cosb := cos (pi*beta/180) ;
  p := trunc ( 200 + 150*sina) ;
  x0 := trunc (x0v + 30 * cosa) ;
  y0 := trunc (y0v + 30 * sina) ;
  for i := 1 to leng do
    begin
{    x1 := index^.x ;}
    yv := index^.y*cosa - index^.z*sina ;
    z1 := index^.y*sina + index^.z*cosa ;
    xv := index^.x*cosb - z1*sinb ;
{    yv := y1 ;}
    zv := index^.x*sinb + z1*sinb ;
{    t1 := index^.x*cosa-index^.y*sina ;
    t2 := index^.x*sina+index^.y*cosa ;{*cosb-index^.z*sinb ;}
    if (zv + p) >1 then
      begin
      xl := (m*xv)/(p+zv)+x0 ;
      yl := (m*yv)/(p+zv)+y0 ;
      {xv := xl*(1 - abs(yl-y0v)/800) ;
      yv := yl*(1 - abs(xl-x0v)/1280) ;}
      put_pixel( trunc(xl), trunc(yl), col) ;
      end ;
    index := ptr ( seg(index^), ofs(index^) + sizeof(point)) ;
    end ;
end ;

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


var alfa : integer ;
begin
setGr ($13) ;
generate_points ( start, finish, tav );{}
{generate_stars( -400, 400, -400, 400, -400, 400, 70 ) ;{}
getmem(pot, $0ffff) ;
for alfa := 0 to 360 do
  begin
  clear (pot) ;
  put_points (alfa, alfa, 9) ;
  copyfrom(pot) ;
  if alfa = 359 then alfa := 0 ;
  if keypressed then break ;
  end ;
freemem(first, leng * sizeof(point)) ;
freemem(pot, $0ffff) ;
readkey ;
setGr ($03) ;
end.