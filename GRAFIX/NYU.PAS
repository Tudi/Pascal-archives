program kor;
uses graph,crt;
var z,x1,y1,y,r,i:integer;

procedure keresr(x:byte);
var y1:real;
begin
y1:=sqrt(abs(sqr(r)-sqr(x)));
y:=round(y1);
end;

begin
i:=detect;
initgraph(i,r,'c:\programs\pascal\bgi');
r:=6;
y1:=320;x1:=200;
repeat
if z<-8 then z:=0;
inc(z);
for i:=1 to r do
  begin
    keresr(i);
    putpixel(round(cos(i-z)*1)+y1,i+x1,27);
  end;
   readkey;{}
cleardevice;
until keypressed;
{for i:=1 to r div 2 do
  begin
    keresr(i);
    putpixel(y+y1,r-i+x1,27);
  end;}
readkey;
closegraph;
end.