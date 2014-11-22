program korkordinattak;
uses crt,graph2;
type kord=record
        x,y:integer;
        end;
var a:array[1..188*4]of kord;
    ek,dk,dny,eny:array[1..400]of kord;
    j,p,i,z,x,y:word;

function keresr(r,x:byte):integer;
var y1:real;
begin
y1:=sqrt(abs(sqr(r)-sqr(x)));
keresr:=round(y1);
end;

procedure kor2(r:byte;ky,kx,cs:integer);
var i,y:integer;
begin
p:=1;
i:=cs;
eny[p].x:=kx;
eny[p].y:=ky-r;
ek[p].x:=kx-r;
ek[p].y:=ky;
dk[p].x:=kx;
dk[p].y:=ky+r;
dny[p].x:=kx+r;
dny[p].y:=ky;{}
p:=2;
while kx-i>kx-round(r * 10/14)do
  begin
    y:=keresr(r,i);
    inc(i,cs);
    eny[p].x:=kx-i;
    eny[p].y:=ky-y;
    ek[p].x:=kx-i;
    ek[p].y:=ky+y;
    dk[p].x:=kx+i;
    dk[p].y:=ky+y;
    dny[p].x:=kx+i;
    dny[p].y:=ky-y;{}
    eny[p+1].x:=kx-y;
    eny[p+1].y:=ky-i;
    ek[p+1].x:=kx-y;
    ek[p+1].y:=ky+i;
    dk[p+1].x:=kx+y;
    dk[p+1].y:=ky-i;
    dny[p+1].x:=kx+y;
    dny[p+1].y:=ky+i;{}
    inc(p,2);
  end;
for i:=1 to p*4 do
  begin
  end;
end;

procedure kikor;
var i:integer;
begin
  for i:=1 to p do
    begin
      put_pixel(ek[i].y,ek[i].x,9);
      put_pixel(eny[i].y,eny[i].x,9);
      put_pixel(dk[i].y,dk[i].x,9);
      put_pixel(dny[i].y,dny[i].x,9);
    end;
copyfrom(pot);
end;

procedure szinez;
var i:integer;
begin
clear(pot);
  for x:=0 to 63 do begin
    setpal(64-x,x div 4,x div 2,x);
    setpal(127-x,x,x div 4,x div 2);
    setpal(190-x,x div 4,x,x div 2);
  end;
for i:=1 to 200 do line2(1,i,320,i,i);
copyfrom(pot);
readkey;
end;

begin
clrscr;
setgr($13);
getmem(pot, $0ffff) ;
clear(pot);
szinez;
x:=100;
y:=160;
for i:=100 downto 50 do
 begin
   kor2(i,y,x,i-49);
   kikor;
 end;
repeat
  if random(100) mod 50=0 then inc(x,4);
  if random(100) mod 49=0 then dec(x,4);
  if random(100) mod 50=0 then dec(y,4);
  if random(100) mod 49=0 then dec(y,4);
  kor2(50,y,x,3);
  kikor;
until keypressed;
freemem(pot, $0ffff) ;
end.