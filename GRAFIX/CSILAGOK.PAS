program csilagoseg;
uses crt,graph2;
const csil=200; min=199; minx=5; maxx=195; miny=5; maxy=315; let=70;
type atr=record
        x,y,m,i,ir:integer;
      end;
     vect=array[1..csil]of atr;
var a:vect;
    i,j,kurens:integer;
    p,irany:byte;
    c:char;

procedure letesit;
begin
inc(kurens);
if random(4)=1 then a[kurens].m:=1;
if random(4)=2 then a[kurens].m:=2;
if random(4)=3 then a[kurens].m:=3;
if a[kurens].m=1 then a[kurens].i:=0;
if a[kurens].m=2 then a[kurens].i:=63;
if a[kurens].m=3 then a[kurens].i:=120;
while (a[kurens].ir=0)or(a[kurens-1].ir=a[kurens].ir)or(a[kurens].ir>9) do a[kurens].ir:=random(9);
if irany=0 then
    begin
      if random(3) mod 2=0 then a[kurens].x:=maxx div 2-random(40)
            else a[kurens].x:=maxx div 2-random(40);
      if random(3)mod 2 =0 then a[kurens].y:=maxy div 2-random(40)
            else a[kurens].x:=maxx div 2-random(40);
    end;
if irany=1 then{fel}
  begin
    a[kurens].x:=maxx;
    a[kurens].y:=random(maxy)+3;
  end;
if irany=2 then{fel jobbra}
  begin
    if random(3) mod 2=0 then a[kurens].x:=maxx
       else a[kurens].y:=miny;
    if a[kurens].x=maxx then a[kurens].y:=random(maxy)+3
        else a[kurens].x:=random(maxx)+3;
  end;
if irany=3 then {jobb}
  begin
    a[kurens].x:=random(maxx)+3;
    a[kurens].y:=miny;
  end;
if irany=4 then {jobb le}
  begin
    if random(3) mod 2=0 then a[kurens].x:=minx
       else a[kurens].y:=miny;
    if a[kurens].x=minx then a[kurens].y:=random(maxy)+3
        else a[kurens].x:=random(maxx)+3;
  end;
if irany=5 then {le}
  begin
    a[kurens].x:=minx;
    a[kurens].y:=random(maxy)+3;
  end;
if irany=6 then {bal le}
  begin
    if random(3) mod 2=0 then a[kurens].x:=minx
       else a[kurens].y:=maxy;
    if a[kurens].x=minx then a[kurens].y:=random(maxy)+3
        else a[kurens].x:=random(maxx)+3;
  end;
if irany=7 then {bal}
  begin
    a[kurens].x:=random(maxx)+3;
    a[kurens].y:=maxy;
  end;
if irany=8 then {bal fel}
  begin
    if random(3) mod 2=0 then a[kurens].x:=maxx
       else a[kurens].y:=maxy;
    if a[kurens].x=maxx then a[kurens].y:=random(maxy)+3
        else a[kurens].x:=random(maxx)+3;
  end;
if irany=9 then {be}
  begin
    if random(9) mod 8 =0 then a[kurens].x:=maxx;
    if random(9) mod 8 =0 then a[kurens].x:=minx;
    if (a[kurens].x<>minx)and(a[kurens].x<>maxx) then
        begin
          a[kurens].x:=random(maxx);
          if random(9) mod 8=0 then a[kurens].y:=miny;
          if random(9) mod 8=0 then a[kurens].y:=maxy;
          if (a[kurens].y<>miny)and(a[kurens].y<>maxy)then a[kurens].y:=random(maxy);
        end;
  end;
end;

procedure mozdit;
var mx,my:integer;
    b:vect;
    irany2:byte;
begin
if kurens<min then letesit;
if (random(100) mod let=0)and(kurens<csil) then letesit;
for i:=1 to kurens do
  begin
    irany2:=irany;
    if irany=0 then irany2:=a[i].ir;
    if p mod 2 =0 then inc(a[i].i);
    if a[i].m=1 then
       begin
         mx:=3;
         my:=3;
       end;
    if a[i].m=2 then
       begin
         mx:=2;
         my:=2;
       end;
    if a[i].m=3 then
       begin
         mx:=1;
         my:=1;
       end;
    if irany2=1 then a[i].x:=a[i].x-mx;
    if irany2=2 then
      begin
        if p mod 2=0 then a[i].y:=a[i].y+my;
        a[i].x:=a[i].x-mx;
      end;
    if irany2=3 then a[i].y:=a[i].y+my;
    if irany2=4 then
      begin
        if p mod 2=0 then a[i].y:=a[i].y+my;
        a[i].x:=a[i].x+mx;
      end;
    if irany2=5 then a[i].x:=a[i].x+mx;
    if irany2=6 then
      begin
        if p mod 2=0 then a[i].y:=a[i].y-my;
        a[i].x:=a[i].x+mx;
      end;
    if irany2=7 then a[i].y:=a[i].y-my;
    if irany2=8 then
      begin
        if p mod 2=0 then a[i].y:=a[i].y-my;
        a[i].x:=a[i].x-mx;
      end;
    if irany2=9 then
      begin
        if (a[i].y<maxy div 2)and(p mod 2 =0)then a[i].y:=a[i].y+my;
        if (a[i].y>maxy div 2)and(p mod 2 =0)then a[i].y:=a[i].y-my;
        if (a[i].x<maxx div 2)then a[i].x:=a[i].x+mx;
        if (a[i].x>maxx div 2)then a[i].x:=a[i].x-mx;
        if (a[i].x<maxx div 2+3)and(a[i].x>maxx div 2-3)then a[i].m:=0;
        if (a[i].y<maxy div 2+3)and(a[i].y>maxy div 2-3)then a[i].m:=0;
      end;
    if(a[i].x<minx)or(a[i].x>maxx)or(a[i].y<miny)or(a[i].y>maxy) then a[i].m:=0
   end;
my:=0;
for i:=1 to kurens do
 if a[i].m<>0 then
    begin
      inc(my);
      b[my]:=a[i];
    end;
a:=b;
kurens:=my;
end;

function szint(m,x:integer):byte;
begin
if m=1 then if x< 63 then szint:=a[i].i mod 63
               else szint:=63;
if m=2 then if x<125 then szint:=a[i].i mod 125
               else szint:=125;
if m=3 then if x<190 then szint:=a[i].i mod 190
               else szint:=190
end;

procedure ki;
var szin:integer;
begin
clear(pot);
 for i:=1 to kurens do
   begin
     szin:=szint(a[i].m,a[i].i);
     if a[i].m=1 then
       begin
         put_pixel(a[i].y,a[i].x,szin);
         put_pixel(a[i].y-1,a[i].x,szin);
         put_pixel(a[i].y+1,a[i].x,szin);
         put_pixel(a[i].y,a[i].x-1,szin);
         put_pixel(a[i].y,a[i].x+1,szin);
       end;
     if a[i].m=2 then
       begin
         put_pixel(a[i].y-1,a[i].x,szin);
         put_pixel(a[i].y+1,a[i].x,szin);
         put_pixel(a[i].y,a[i].x-1,szin);
         put_pixel(a[i].y,a[i].x+1,szin);
       end;
     if a[i].m=3 then put_pixel(a[i].y,a[i].x,szin);
   end;
 copyfrom(pot);
end;

procedure szinek;
var x:integer;
begin
  for x:=0 to 63 do begin
    setpal(64-x,x div 4,x div 2,x);
    setpal(127-x,x,x div 4,x div 2);
    setpal(190-x,x div 4,x,x div 2);
  end;
end;


begin
setgr($13);
getmem(pot, $0ffff) ;
irany:=8;
szinek;
p:=1;
c:='1';
while (ord(c)-48>=0)and(ord(c)-48<11) do
 begin
   repeat
     if p=1 then p:=2
        else p:=1;
     mozdit;
     ki;
   until keypressed;
   c:=readkey;
   if (ord(c)-48<10)and(ord(c)-48>=0) then irany:=ord(c)-48;
 end;
freemem(pot, $0ffff) ;
setGr ($03) ;
readkey ;
end.