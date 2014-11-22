program kor;
uses graph,crt;
const szor=60;
var z,x1,y1,y,i:integer;

procedure rand;
var i,j,x1,y1:integer;
    z:real;
begin
for i:=1 to szor do
  putpixel(round(sqrt(abs(sqr(szor)-sqr(i))))+y1,i+x1,27);
end;

begin
i:=detect;
initgraph(i,x1,' ');
y1:=320;
x1:=200;
randomize;
rand;
readkey;
repeat
  if z<-8 then z:=0;
  inc(z);
  for i:=1 to szor do putpixel(round(cos(i-z)*1)+y1,i+x1,27);
  readkey;{}
  cleardevice;
until keypressed;
readkey;
closegraph;
end.