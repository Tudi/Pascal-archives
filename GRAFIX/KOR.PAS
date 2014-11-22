program korrajzolo;
uses graph,crt;
var z,x1,y1:integer;

function keresr(r,x:byte):integer;
var y1:real;
begin
y1:=sqrt(abs(sqr(r)-sqr(x)));
keresr:=round(y1);
end;

procedure kor(r:byte;ky,kx:integer);
var i,y:integer;
begin
for i:=1 to r do
  begin
    y:=keresr(r,i);
    putpixel(y+ky,1-i+kx,27);{}{balfelsokor}
    putpixel(i+ky,1-y+kx,27);{}

    putpixel(y+ky,i+kx,27);{}{balalsokor}
    putpixel(i+ky,y+kx,27);{}

    putpixel(1-y+ky,i+kx,27);{}{joblalsokor}
    putpixel(1-i+ky,y+kx,27);{}

    putpixel(1-y+ky,1-i+kx,27);{}{jobfelsokor}
    putpixel(1-i+ky,1-y+kx,27);{}
  end;
end;

begin
x1:=detect;
initgraph(x1,y1,'c:\pascal\bin\tpu&bgi');
y1:=320;x1:=200;
{a kor sugara maxim 180 lehet}
for z:=1 to 180 do kor(z,y1,x1);
readkey;
closegraph;
end.
setgr($13);
clear (pot);
copyfrom(pot);
readkey;
setgr($03);
end.