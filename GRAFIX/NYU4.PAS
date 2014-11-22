program nyu1;
uses crt,graph;
const hossz=30; p=50;
type kor=record
         x,y:integer;
         sz:byte;
       end;
var x1,y1,szin,sz,irany,szor,at,x,y,i:integer;
    a:array[1..500]of kor;

procedure terit;
var v:integer;
begin
at:=random(hossz div 2);
szor:=0;
v:=irany;
while (irany=0)or(irany=v) do irany:=random(9);
end;

procedure mozdit;
begin
if irany=1 then dec(x);
if irany=2 then inc(y);
if irany=3 then inc(x);
if irany=4 then dec(y);
if irany=5 then
  begin
    dec(x);
    inc(y);
  end;
if irany=6 then
  begin
    inc(x);
    inc(y);
  end;
if irany=7 then
  begin
    inc(x);
    dec(y);
  end;
if irany=8 then
  begin
    dec(x);
    dec(y);
  end;
end;

procedure tarol;
begin
setcolor(black);
circle(a[hossz].y,a[hossz].x,sz);
for i:=hossz downto 2 do a[i]:=a[i-1];
end;

procedure fest;
begin
for i:=hossz downto 1 do
  begin
    if a[i].sz=1 then setcolor(red);
    if a[i].sz=2 then setcolor(blue);
    if a[i].sz=3 then setcolor(green);
    circle(a[i].y,a[i].x,sz);
  end;
end;

begin
i:=detect;
initgraph(i,x,' ');
randomize;
x:=240;y:=320;sz:=30;
x1:=240;y1:=320;
terit;
repeat
inc(szor);
inc(szin);
if szor>=at then terit;
mozdit;
tarol;
if x>x1+p then terit;
if x<x1-p then terit;
if y<y1-p then terit;
if y>y1+p then terit;
if (szin<10) then a[1].sz:=1;
if (szin<20)and(szin>10) then a[1].sz:=2;
if (szin<30)and(szin>20) then a[1].sz:=3;
if szin=30 then szin:=0;
a[1].x:=x;a[1].y:=y;
{cleardevice;{}
fest;
until keypressed;
end.