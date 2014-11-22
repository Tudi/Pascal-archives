program korrajzolo;
uses graph2,crt;
var z,x1,y1,szin,valt:integer;

function keresr(r,x:byte):integer;
var y1:real;
begin
y1:=sqrt(abs(sqr(r)-sqr(x)));
keresr:=round(y1);
end;

procedure kor(r:byte;kx,ky:integer);
var i,y:integer;
begin
for i:=1 to r do
  begin
    if i mod valt=0 then inc(szin);

    y:=keresr(r,i);
    put_pixel(y+y1,1-i*2+x1,szin);{}{balfelsokor}

    put_pixel(y+y1,i*2+x1,szin);{}{balalsokor}

    put_pixel(1-y+y1,i*2+x1,szin);{}{joblalsokor}

    put_pixel(1-y+y1,1-i*2+x1,szin);{}{jobfelsokor}

    put_pixel(y*2+y1,1-i+x1,szin);{}{balfelsokor}

    put_pixel(y*2+y1,i+x1,szin);{}{balalsokor}

    put_pixel(1-y*2+y1,i+x1,szin);{}{joblalsokor}

    put_pixel(1-y*2+y1,1-i+x1,szin);{}{jobfelsokor}
  end;
end;

begin
getmem(pot, $0ffff) ;
setGr($13);
y1:=160;x1:=100;
valt:=1;
{a kor sugara maxim 180 lehet}
repeat
clear(pot);
if valt>59 then valt:=1;
inc(valt);
for z:=1 to 60 do
  begin
    kor(z,y1,x1);
  end;
copyfrom(pot);
until keypressed;
readkey;
freemem(pot, $0ffff) ;
setGr ($03) ;
end.
