unit hajok;
interface
uses graph2;
const sarga=70;  zold=45;     piros=39;
      lila=35;   szurke=7;    kek=9;
procedure loadspeedy(p:pointer);
procedure loadspeedy2(p:pointer);
procedure loadship(p:pointer);
procedure loadpirat(p:pointer);
procedure loadcsakany(p:pointer);
procedure loadtank(p:pointer);
procedure loadhtank(p:pointer);
procedure loadbomber(p:pointer);
procedure loadhbomber(p:pointer);
procedure loadplazma(p:pointer);
procedure loadobs(p:pointer);
procedure loadpok(p:pointer);
procedure loadpsycho2(p:pointer);
procedure loadpsycho(p:pointer);
procedure ship(y,x:integer;p:pointer);
procedure speedy(y,x:integer;p:pointer);
procedure speedy2(y,x:integer;p:pointer);
procedure pirat(y,x:integer;p:pointer);
procedure csakany(y,x:integer;p:pointer);
procedure tank(y,x:integer;p:pointer);
procedure htank(y,x:integer;p:pointer);
procedure bomber(y,x:integer;p:pointer);
procedure hbomber(y,x:integer;p:pointer);
procedure plazma(y,x:integer;p:pointer);
procedure obs(y,x:integer;p:pointer);
procedure pok(y,x:integer;p:pointer);
procedure psycho(y,x:integer;p:pointer);
procedure psycho2(y,x:integer;p:pointer);
{procedure epsycho(y,x:integer);}

implementation

procedure psycho(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-22;
  x:=x-6;
  for i:=1 to 13 do
   for j:=1 to 45 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadpsycho(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'psycho.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 301 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(F);
end;

procedure psycho2(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-20;
  x:=x-8;
  for i:=1 to 17 do
   for j:=1 to 40 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadpsycho2(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'rak.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 168 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(F);
end;

procedure pok(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-17;
  x:=x-12;
  for i:=1 to 24 do
   for j:=1 to 33 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadpok(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'pok.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 300 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(F);
end;

procedure obs(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-15;
  x:=x-11;
  for i:=1 to 22 do
   for j:=1 to 31 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadobs(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'observ.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 22 do
   for j:=1 to 31 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;


procedure plazma(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-17;
  x:=x-11;
  for i:=1 to 22 do
   for j:=1 to 34 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadplazma(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'plazma.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 22 do
   for j:=1 to 34 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;


procedure hbomber(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-22;
  x:=x-10;
  for i:=1 to 19 do
   for j:=1 to 45 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadhbomber(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'hbomber.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 19 do
   for j:=1 to 45 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;


procedure bomber(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-22;
  x:=x-11;
  for i:=1 to 22 do
   for j:=1 to 44 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadbomber(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'bomber.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 22 do
   for j:=1 to 44 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;

procedure htank(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-14;
  x:=x-14;
  for i:=1 to 21 do
   for j:=1 to 38 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadhtank(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'htank.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 373 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(F);
end;

procedure tank(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-14;
  x:=x-14;
  for i:=1 to 19 do
   for j:=1 to 40 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadtank(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'tank.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 355 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(F);
end;


procedure csakany(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-14;
  x:=x-14;
  for i:=1 to 29 do
   for j:=1 to 28 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadcsakany(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'felkezu.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 253 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(F);
end;

procedure pirat(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-21;
  x:=x-6;
  for i:=1 to 13 do
   for j:=1 to 42 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure loadpirat(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'speedy2.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 13 do
   for j:=1 to 42 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;

procedure ship(y,x:integer;p:pointer);
var i:integer;
    p2:^byte;
    l:word;
begin
  kepKirako(p,y-12,x-11,28,15);
{  p2:=p;
  y:=y-13;
  x:=x-11;
  l:=1;
  for i:=1 to 15*28 do
     begin
       if p2^<>0 then put_pixel(y+(l mod 28),x+(l div 28),p2^);
       inc(l);
       inc(p2);
     end;{}
end;

procedure loadship(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'ship.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 186 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(F);
end;


procedure loadspeedy(p:pointer);
var f:file of byte;
    i,j:integer;
    b:byte;
    p2:^byte;
begin
  assign(f,'pirat2.gpi');
  reset(f);
  read(f,b);
  p2:=p;
  for i:=1 to 11 do
   for j:=1 to 21 do
   begin
     read(f,b);
     p2^:=b;
     inc(p2);
   end;
 close(f);
end;

procedure loadspeedy2(p:pointer);
type elem=record
        szor,data:byte;
      end;
var f:file of elem;
    e:elem;
    p2:^byte;
    i,j:integer;
begin
  assign(f,'pirat.sss');
  reset(f);
  read(f,e);
  p2:=p;
  for i:=1 to 139 do
   begin
     read(f,e);
     for j:=1 to e.szor do
        begin
          p2^:=e.data;
          inc(p2);
        end;
   end;
  close(f);
end;

procedure speedy2(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
    l:word;
begin
  p2:=p;
  y:=y-20;
  l:=0;
  for i:=1 to 10 do
   for j:=1 to 40 do
     begin
       if p2^<>0 then put_pixel(y+j,x+i,p2^);
       inc(p2);
     end;
end;

procedure speedy(y,x:integer;p:pointer);
var i,j:integer;
    p2:^byte;
begin
  p2:=p;
  y:=y-10;
  for i:=1 to 11 do
    for j:=1 to 21 do
      begin
        if p2^<>0 then put_pixel(y+j,i+x,p2^);
        inc(p2);
      end;
end;
{
procedure psycho(y,x:integer);
begin
line2(y,x-3,y,x+5,piros);
line2(y-1,x+3,y+2,x+3,piros);
line2(y-1,x-2,y-1,x+2,zold);
line2(y+1,x-2,y+1,x+2,zold);
line2(y-3,x+2,y+4,x+2,szurke);
end;

procedure epsycho(y,x:integer);
begin
put_pixel(y,x-4,piros);
line2(y-1,x-3,y+2,x-3,piros);
line2(y-3,x-2,y+4,x-2,szurke);
line2(y-2,x-1,y+3,x-1,szurke);
line2(y-1,x-1,y-1,x+2,zold);
line2(y+1,x-1,y+1,x+2,zold);
line2(y,x-1,y,x+3,piros);
end;

procedure hbomber(y,x:integer);
begin
line2(y-6,x-2,y+8,x-2,szurke);
line2(y-6,x-1,y+8,x-1,szurke);
line2(y-3,x,y+5,x,szurke);
line2(y-3,x+1,y+5,x+1,szurke);
line2(y-1,x-2,y-1,x+3,zold);
line2(y+2,x-2,y+2,x+3,zold);
line2(y,x-2,y,x+1,piros);
line2(y+1,x-2,y+1,x+1,piros);
put_pixel(y-6,x,piros);
put_pixel(y-5,x,piros);
put_pixel(y+6,x,piros);
put_pixel(y+7,x,piros);
end;

procedure bomber(y,x:integer);
begin
line2(y-5,x-2,y+7,x-2,szurke);
line2(y-5,x-1,y+7,x-1,szurke);
line2(y-3,x,y+5,x,szurke);
line2(y-3,x+1,y+5,x+1,szurke);
line2(y-1,x-2,y-1,x+3,piros);
line2(y+2,x-2,y+2,x+3,piros);
line2(y,x-2,y,x+1,zold);
line2(y+1,x-2,y+1,x+1,zold);
end;

procedure htank(y,x:integer);
begin
line2(y-4,x-3,y+5,x-3,szurke);
line2(y-4,x-2,y+5,x-2,szurke);
line2(y-1,x-2,y-1,x+3,szurke);
line2(y+1,x-2,y+1,x+3,szurke);
line2(y,x-3,y,x+3,zold);
put_pixel(y,x+3,piros);
put_pixel(y-4,x-1,piros);
put_pixel(y-3,x-1,piros);
put_pixel(y+4,x-1,piros);
put_pixel(y+3,x-1,piros);
end;

procedure tank(y,x:integer);
begin
line2(y-4,x-3,y+5,x-3,szurke);
line2(y-4,x-2,y+5,x-2,szurke);
line2(y-1,x-2,y-1,x+3,szurke);
line2(y+1,x-2,y+1,x+3,szurke);
line2(y,x-3,y,x+3,zold);
put_pixel(y,x+3,piros);
end;

procedure pirat(y,x:integer);
begin
line2(y-2,x-1,y+3,x-1,szurke);
put_pixel(y-2,x,szurke);
put_pixel(y+2,x,szurke);
put_pixel(y,x,zold);
put_pixel(y-2,x+1,piros);
put_pixel(y+2,x+1,piros);
end;

procedure speedy(y,x:integer);
begin
put_pixel(y-1,x,szurke);
put_pixel(y,x,szurke);
put_pixel(y+1,x,szurke);
put_pixel(y,x+1,piros);
end;

procedure hajo(y,x:integer);
begin
put_pixel(y,x-4,piros);

put_pixel(y-1,x-3,zold);
put_pixel(y,x-3,zold);
put_pixel(y+1,x-3,zold);

put_pixel(y-1,x-2,szurke);
put_pixel(y,x-2,lila);
put_pixel(y+1,x-2,szurke);

put_pixel(y-6,x-1,piros);
put_pixel(y-1,x-1,szurke);
put_pixel(y,x-1,lila);
put_pixel(y+1,x-1,szurke);
put_pixel(y+6,x-1,piros);

put_pixel(y-7,x,szurke);
put_pixel(y-6,x,kek);
put_pixel(y-5,x,szurke);
put_pixel(y-1,x,szurke);
put_pixel(y,x,lila);
put_pixel(y+1,x,szurke);
put_pixel(y+5,x,szurke);
put_pixel(y+6,x,kek);
put_pixel(y+7,x,szurke);

put_pixel(y-7,x+1,szurke);
put_pixel(y-6,x+1,kek);
put_pixel(y-5,x+1,szurke);
put_pixel(y-2,x+1,piros);
put_pixel(y-1,x+1,szurke);
put_pixel(y,x-1,lila);
put_pixel(y+1,x+1,szurke);
put_pixel(y+2,x+1,piros);
put_pixel(y+5,x+1,szurke);
put_pixel(y+6,x+1,kek);
put_pixel(y+7,x+1,szurke);

put_pixel(y-7,x+2,szurke);
put_pixel(y-6,x+2,kek);
put_pixel(y-5,x+2,szurke);
put_pixel(y-4,x+2,szurke);
put_pixel(y-3,x+2,szurke);
put_pixel(y-2,x+2,zold);
put_pixel(y-1,x+2,szurke);
put_pixel(y,x+2,lila);
put_pixel(y+1,x+2,szurke);
put_pixel(y+2,x+2,zold);
put_pixel(y+3,x+2,szurke);
put_pixel(y+4,x+2,szurke);
put_pixel(y+5,x+2,szurke);
put_pixel(y+6,x+2,kek);
put_pixel(y+7,x+2,szurke);

put_pixel(y-7,x+3,szurke);
put_pixel(y-6,x+3,kek);
put_pixel(y-5,x+3,szurke);
put_pixel(y-4,x+3,szurke);
put_pixel(y-3,x+3,szurke);
put_pixel(y-2,x+3,zold);
put_pixel(y-1,x+3,szurke);
put_pixel(y,x+3,lila);
put_pixel(y+1,x+3,szurke);
put_pixel(y+2,x+3,zold);
put_pixel(y+3,x+3,szurke);
put_pixel(y+4,x+3,szurke);
put_pixel(y+5,x+3,szurke);
put_pixel(y+6,x+3,kek);
put_pixel(y+7,x+3,szurke);
end;}
end.