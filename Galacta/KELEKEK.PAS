unit kelekek;
interface
uses graph2;
const sarga=70;  zold=45;     piros=39;
      lila=35;   szurke=7;    kek=9;
procedure lezer(var ly,lx:integer;sz:byte);
procedure lang1(y,x:integer);
procedure lang2(y,x:integer);
procedure lang3(y,x:integer);
procedure lang4(y,x:integer);
procedure lang5(y,x:integer);
procedure lang6(y,x:integer);
procedure boom(y,x:integer);
procedure shieldr(y,x:integer);
procedure lifebar(life:integer);
procedure tuz1(y,x:integer;p:pointer);
procedure loadtuz1(p:pointer);
procedure tuz2(y,x:integer;p:pointer);
procedure loadtuz2(p:pointer);
procedure tuz3(y,x:integer;p:pointer);
procedure loadtuz3(p:pointer);

implementation

procedure tuz1(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-20;
  x:=x-10;
  for i:=1 to 21 do
   for j:=1 to 40 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadtuz1(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'tuz.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 21 do
   for j:=1 to 40 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;

procedure tuz2(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-15;
  x:=x-10;
  for i:=1 to 21 do
   for j:=1 to 30 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadtuz2(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'tuz2.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 21 do
   for j:=1 to 30 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;

procedure tuz3(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-20;
  x:=x-14;
  for i:=1 to 28 do
   for j:=1 to 25 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadtuz3(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'tuz.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 28 do
   for j:=1 to 25 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;

procedure lifebar(life:integer);
var szin:byte;
    oszlop,i:integer;
begin
oszlop:=1;
szin:=39;
for i:=1 to life do
   begin
     if i mod 4=0 then inc(oszlop);
     put_pixel(oszlop,(i mod 4)+196,szin);
     if (life<=1300)and(i mod 225=0) then inc(szin)
      else if (life>1300)and(life<=2600)and(i mod 200=0) then inc(szin)
      else if (life>2600)and(life<=3900)and(i mod 175=0) then inc(szin)
      else if (life>3900)and(life<=5200)and(i mod 150=0) then inc(szin)
      else if (life>5200)and(life<=6500)and(i mod 125=0) then inc(szin)
      else if (life>6500)and(life<=7800)and(i mod 100=0) then inc(szin)
      else if (life>7800)and(life<=9200)and(i mod 75=0) then inc(szin)
      else if (life>9200)and(life<=10500)and(i mod 50=0) then inc(szin)
      else if (life>10500)and(i mod 25=0) then inc(szin);
     if oszlop=310 then break;
   end;
end;

procedure shieldr(y,x:integer);
begin
line2(y,x-10,y-13,x+8,sarga);
line2(y,x-10,y+13,x+8,sarga);
line2(y-13,x+8,y+13,x+8,sarga);
end;

procedure boom(y,x:integer);
begin
put_pixel(y+1,x,kek);
put_pixel(y,x,piros);
put_pixel(y+1,x+1,piros);
put_pixel(y,x+1,kek);
put_pixel(y-1,x-1,lila);
put_pixel(y+2,x-1,lila);
put_pixel(y-1,x+2,lila);
put_pixel(y+2,x+2,lila);
put_pixel(y-2,x-2,zold);
put_pixel(y,x-2,zold);
put_pixel(y+3,x-2,zold);
put_pixel(y+3,x,zold);
put_pixel(y+3,x+3,zold);
put_pixel(y+1,x+3,zold);
put_pixel(y-2,x+3,zold);
put_pixel(y-2,x+1,zold);
end;

procedure lang6(y,x:integer);
begin
put_pixel(y-6,x+4,piros);
put_pixel(y-5,x+4,piros);
put_pixel(y-4,x+4,piros);
put_pixel(y-3,x+4,piros);
put_pixel(y-2,x+4,piros);
put_pixel(y-1,x+4,piros);
put_pixel(y,x+4,piros);
put_pixel(y+6,x+4,piros);
put_pixel(y+5,x+4,piros);
put_pixel(y+4,x+4,piros);
put_pixel(y+3,x+4,piros);
put_pixel(y+2,x+4,piros);
put_pixel(y+1,x+4,piros);
put_pixel(y-5,x+6,piros);
put_pixel(y-5,x+5,piros);
put_pixel(y-4,x+5,piros);
put_pixel(y-3,x+5,piros);
put_pixel(y-2,x+5,piros);
put_pixel(y-1,x+5,piros);
put_pixel(y,x+5,piros);
put_pixel(y+5,x+6,piros);
put_pixel(y+5,x+5,piros);
put_pixel(y+4,x+5,piros);
put_pixel(y+3,x+5,piros);
put_pixel(y+2,x+5,piros);
put_pixel(y+1,x+5,piros);
put_pixel(y,x+6,piros);
end;

procedure lang5(y,x:integer);
begin
put_pixel(y-6,x+4,piros);
put_pixel(y-5,x+4,piros);
put_pixel(y-4,x+4,piros);
put_pixel(y-3,x+4,piros);
put_pixel(y-2,x+4,piros);
put_pixel(y-1,x+4,piros);
put_pixel(y,x+4,piros);
put_pixel(y+6,x+4,piros);
put_pixel(y+5,x+4,piros);
put_pixel(y+4,x+4,piros);
put_pixel(y+3,x+4,piros);
put_pixel(y+2,x+4,piros);
put_pixel(y+1,x+4,piros);
put_pixel(y-5,x+6,piros);
put_pixel(y-5,x+5,piros);
put_pixel(y-4,x+5,piros);
put_pixel(y-3,x+5,piros);
put_pixel(y-2,x+5,piros);
put_pixel(y-1,x+5,piros);
put_pixel(y,x+5,piros);
put_pixel(y+5,x+6,piros);
put_pixel(y+5,x+5,piros);
put_pixel(y+4,x+5,piros);
put_pixel(y+3,x+5,piros);
put_pixel(y+2,x+5,piros);
put_pixel(y+1,x+5,piros);
end;

procedure lang4(y,x:integer);
begin
put_pixel(y-6,x+4,piros);
put_pixel(y-5,x+4,piros);
put_pixel(y-4,x+4,piros);
put_pixel(y-3,x+4,piros);
put_pixel(y-2,x+4,piros);
put_pixel(y-1,x+4,piros);
put_pixel(y,x+4,piros);
put_pixel(y+6,x+4,piros);
put_pixel(y+5,x+4,piros);
put_pixel(y+4,x+4,piros);
put_pixel(y+3,x+4,piros);
put_pixel(y+2,x+4,piros);
put_pixel(y+1,x+4,piros);
end;

procedure lang3(y,x:integer);
begin
put_pixel(y-6,x+4,piros);
put_pixel(y-5,x+4,piros);
put_pixel(y-4,x+4,piros);
put_pixel(y+6,x+4,piros);
put_pixel(y+5,x+4,piros);
put_pixel(y+4,x+4,piros);
put_pixel(y-5,x+5,piros);
put_pixel(y+5,x+5,piros);
put_pixel(y-1,x+4,piros);
put_pixel(y,x+4,piros);
put_pixel(y+1,x+4,piros);
put_pixel(y,x+5,piros);
end;

procedure lang2(y,x:integer);
begin
put_pixel(y-6,x+4,piros);
put_pixel(y-5,x+4,piros);
put_pixel(y-4,x+4,piros);
put_pixel(y+6,x+4,piros);
put_pixel(y+5,x+4,piros);
put_pixel(y+4,x+4,piros);
put_pixel(y-5,x+5,piros);
put_pixel(y+5,x+5,piros);
put_pixel(y-1,x+4,piros);
put_pixel(y,x+4,piros);
put_pixel(y+1,x+4,piros);
end;

procedure lang1(y,x:integer);
begin
put_pixel(y-6,x+4,piros);
put_pixel(y-5,x+4,piros);
put_pixel(y-4,x+4,piros);
put_pixel(y+6,x+4,piros);
put_pixel(y+5,x+4,piros);
put_pixel(y+4,x+4,piros);
end;

procedure lezer(var ly,lx:integer;sz:byte);
begin
  put_pixel(ly,lx,sz);
  put_pixel(ly,lx+1,sz);
end;

end.

