unit screens;
interface
uses graph2,crt;
type point=record
       x,y,z:integer;
     end;
var  first, index : ^point ;
     leng         : word ;
     pot          : pointer ;
     pal          : array [1..48] of byte ;
     p            : integer ;
const piros=39;
      m = 100 ;
      tav = 15 ;
      x0v = 150 ;
      y0v = 100 ;
      k   = 40 ;
      start = -350 ;
      finish = 450 ;
procedure generate_stars ( xi, xa, yi, ya, zi, za, nr_stars : integer) ;
procedure put_points ( alfa, beta : integer; col : byte ) ;
procedure kw(y,x:integer;szin:byte);
procedure ke(y,x:integer;szin:byte);
procedure kl(y,x:integer;szin:byte);
procedure ko(y,x:integer;szin:byte);
procedure ka(y,x:integer;szin:byte);
procedure kd(y,x:integer;szin:byte);
procedure kn(y,x:integer;szin:byte);
procedure kx(y,x:integer;szin:byte);
procedure ki(y,x:integer;szin:byte);
procedure kt(y,x:integer;szin:byte);
procedure newgame;
procedure loadgame;
procedure exitgame;
procedure ks(y,x:integer;szin:byte);
procedure kc(y,x:integer;szin:byte);
procedure ku(y,x:integer;szin:byte);
procedure km(y,x:integer;szin:byte);
procedure kg(y,x:integer;szin:byte);
procedure kp(y,x:integer;szin:byte);
procedure campaign;
procedure custom;
procedure pirosteglalap;
procedure back;
procedure kekhatter;

implementation

procedure kekhatter;
const xmax=80;     ymax=24;
var i,j:byte;
begin
nosound;
setgr(3);
textbackground(blue);
textcolor(white);
for i:=1 to ymax do
for j:=1 to xmax do
     begin
       gotoxy(j,i);
       if (i=1)and(j=1) then write('É')
         else if (i=1)and(j=xmax)then write('»')
           else if (i=ymax)and(j=1)then write('È')
             else if (i=ymax)and(j=xmax) then write('¼')
               else if ((i>1)and(i<ymax))and((j=1)or(j=xmax))then write('º')
                 else if ((j>1)and(j<xmax))and((i=1)or(i=ymax))then write('Í')
                   else write(' ');
     end;
end;

procedure campaign;
begin
pirosteglalap;
kc(135,97,9);
ka(143,104,9);
km(150,97,9);
kp(157,97,9);
ka(164,104,9);
ki(171,97,9);
kg(176,97,9);
kn(183,97,9);
end;

procedure custom;
begin
pirosteglalap;
kc(135,97,9);
ku(143,97,9);
ks(150,97,9);
kt(157,97,9);
ko(167,97,9);
km(174,97,9);
end;

procedure kp(y,x:integer;szin:byte);
begin
line2(y,x,y,x+7,szin);
line2(y,x,y+5,x+1,szin);
line2(y+5,x+2,y+5,x+3,szin);
line2(y+5,x+3,y,x+5,szin);
end;

procedure kg(y,x:integer;szin:byte);
begin
line2(y,x,y,x+7,szin);
line2(y,x,y+5,x,szin);
line2(y,x+7,y+5,x+7,szin);
line2(y+3,x+4,y+5,x+4,szin);
line2(y+5,x+4,y+5,x+8,szin);
end;

procedure km(y,x:integer;szin:byte);
begin
line2(y,x,y,x+7,szin);
line2(y,x,y+3,x+4,szin);
line2(y+5,x,y+2,x+4,szin);
line2(y+5,x,y+5,x+7,szin);
end;

procedure ku(y,x:integer;szin:byte);
begin
line2(y,x,y,x+7,szin);
line2(y+5,x,y+5,x+8,szin);
line2(y,x+7,y+5,x+7,szin);
end;

procedure kc(y,x:integer;szin:byte);
begin
line2(y,x,y,x+7,szin);
line2(y,x,y+5,x,szin);
line2(y,x+7,y+5,x+7,szin);
end;

procedure ks(y,x:integer;szin:byte);
begin
line2(y,x,y+5,x,szin);
line2(y,x,y,x+3,szin);
line2(y,x+3,y+5,x+3,szin);
line2(y+4,x+3,y+4,x+7,szin);
line2(y,x+7,y+5,x+7,szin);
end;

procedure pirosteglalap;
var i,j:integer;
begin
for i:=130 to 190 do
 for j:=95 to 105 do
   put_pixel(i,j,70);
end;

procedure piroskocka;
var i,j:integer;
begin
for i:=130 to 170 do
 for j:=95 to 105 do
   put_pixel(i,j,70);
end;

procedure loadgame;
begin
piroskocka;
kl(135,97,9);
ko(142,97,9);
ka(150,104,9);
kd(157,97,9);
end;

procedure newgame;
begin
piroskocka;
kn(135,97,9);
ke(145,97,9);
kw(153,97,9);
end;

procedure back;
begin
pirosteglalap;
ke(135,97,9);
kx(142,97,9);
ki(150,97,9);
kt(155,97,9);
end;

procedure exitgame;
begin
piroskocka;
ke(135,97,9);
kx(142,97,9);
ki(150,97,9);
kt(155,97,9);
end;

procedure kt(y,x:integer;szin:byte);
begin
 line2(y,x,y+10,x,szin);
 line2(y+5,x,y+5,x+7,szin);
end;

procedure ki(y,x:integer;szin:byte);
begin
 line2(y,x,y,x+7,szin);
end;

procedure kx(y,x:integer;szin:byte);
begin
 line2(y,x,y+5,x+7,szin);
 line2(y,x+7,y+5,x,szin);
end;

procedure kn(y,x:integer;szin:byte);
begin
 line2(y,x,y,x+7,szin);
 line2(y,x,y+5,x+7,szin);
 line2(y+5,x,y+5,x+7,szin);
end;

procedure kd(y,x:integer;szin:byte);
begin
 line2(y,x,y,x+8,szin);
 line2(y,x,y+4,x+3,szin);
 line2(y+4,x+3,y+4,x+5,szin);
 line2(y+4,x+5,y,x+8,szin);
end;

procedure ka(y,x:integer;szin:byte);
begin
 line2(y,x,y+3,x-7,szin);
 line2(y+2,x-7,y+5,x+1,szin);
 line2(y+1,x-2,y+4,x-2,szin);
end;

procedure ko(y,x:integer;szin:byte);
begin
 line2(y,x,y+5,x,szin);
 line2(y,x+7,y+5,x+7,szin);
 line2(y,x,y,x+7,szin);
 line2(y+5,x,y+5,x+8,szin);
end;

procedure kl(y,x:integer;szin:byte);
begin
 line2(y,x,y,x+7,szin);
 line2(y,x+7,y+5,x+7,szin);
end;

procedure ke(y,x:integer;szin:byte);
begin
 line2(y,x,y,x+6,szin);
 line2(y,x,y+5,x,szin);
 line2(y,x+3,y+5,x+3,szin);
 line2(y,x+6,y+5,x+6,szin);
end;

procedure kw(y,x:integer;szin:byte);
begin
 line2(y,x,y,x+6,szin);
 line2(y,x+6,y+4,x,szin);
 line2(y+4,x,y+8,x+6,szin);
 line2(y+8,x,y+8,x+7,szin);
end;

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
end.