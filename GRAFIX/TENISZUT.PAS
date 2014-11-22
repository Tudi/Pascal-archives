program korrajzolo;
uses graph,crt;
const de=60;
var z,x1,y1:integer;

function keresr(r,x:byte):integer;
var y1:real;
begin
y1:=sqrt(abs(sqr(r)-sqr(x)));
keresr:=round(y1);
end;

procedure bf(r:byte;ky,kx:integer);
var i,y:integer;
begin
for i:=1 to r do
  begin
    y:=keresr(r,i);
    putpixel(y+ky,1-i+kx,27);{}{balfelsokor}
    putpixel(i+ky,1-y+kx,27);{}
delay(de);
  end;
end;

procedure ba(r:byte;ky,kx:integer);
var i,y:integer;
begin
for i:=1 to r do
  begin
    y:=keresr(r,i);
    putpixel(y+ky,i+kx,27);{}{balalsokor}
    putpixel(i+ky,y+kx,27);{}
delay(de);
  end;
end;

procedure ja(r:byte;ky,kx:integer);
var i,y:integer;
begin
for i:=1 to r do
  begin
    y:=keresr(r,i);
    putpixel(1-y+ky,i+kx,27);{}{joblalsokor}
    putpixel(1-i+ky,y+kx,27);{}
delay(de);
  end;
end;

procedure jf(r:byte;ky,kx:integer);
var r2,i,y:integer;
begin
r2:=round(r/0.5);
for i:=1 to r2 do
  begin
    y:=keresr(r,i);
    putpixel(1-y+ky,1-i+kx,27);{}{jobfelsokor}
    putpixel(1-i+ky,1-y+kx,27);{}
delay(de);
  end;
end;

procedure kor(r:byte);
begin
jf(r,y1,x1);
ja(r,y1,x1);
bf(r,y1,x1);
ba(r,y1,x1);
end;

begin
x1:=detect;
initgraph(x1,y1,'c:\pascal\bin\tpu&bgi');
y1:=320;x1:=200;
{a kor sugara maxim 180 lehet}
kor(50);
readkey;
closegraph;
end.
setgr($13);
clear (pot);
copyfrom(pot);
readkey;
setgr($03);
end.