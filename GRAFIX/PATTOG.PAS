program pattog;
uses crt,graph2;
const oszl=320; sor=200;
type osz=1..oszl;
var i,i1,x,x1,y,y1,j:integer;

function terit(y,x:osz;ir:byte):byte;
begin
if (x<5)and(ir<4) then
  begin
    if y<(oszl div 3)then terit:=4;
    if (y<2*(oszl div 3))and(y>(oszl div 3))then terit:=5;
    if (y<oszl)and(y>2*(oszl div 3))then terit:=6;
    exit;
  end;
if (x<5)and(ir>9)and(ir<13) then
  begin
    if y<(oszl div 3)then terit:=12;
    if (y<2*(oszl div 3))and(y>(oszl div 3))then terit:=11;
    if (y<oszl)and(y>2*(oszl div 3))then terit:=10;
    exit;
  end;
if (x>sor-5)and(ir>6)and(ir<10) then
  begin
    if y<(oszl div 3)then terit:=9;
    if (y<2*(oszl div 3))and(y>(oszl div 3))then terit:=8;
    if (y<oszl)and(y>2*(oszl div 3))then terit:=7;
    exit;
  end;
if (x>sor-5)and(ir>3)and(ir<7) then
  begin
    if y<(oszl div 3)then terit:=4;
    if (y<2*(oszl div 3))and(y>(oszl div 3))then terit:=5;
    if (y<oszl)and(y>2*(oszl div 3))then terit:=6;
    exit;
  end;
if (y>oszl-5)and(ir<4) then
  begin
    if x<(sor div 3)then terit:=10;
    if (x<2*(sor div 3))and(x>(sor div 3))then terit:=11;
    if (x<sor)and(x>2*(sor div 3))then terit:=12;
    exit;
  end;
if (y<5)and(ir>9)and(ir<13) then
  begin
    if x<(sor div 3)then terit:=1;
    if (x<2*(sor div 3))and(x>(sor div 3))then terit:=2;
    if (x<sor)and(x>2*(sor div 3))then terit:=3;
    exit;
  end;
if (y<5)and(ir>6)and(ir<10) then
  begin
    if x<(sor div 3)then terit:=4;
    if (x<2*(sor div 3))and(x>(sor div 3))then terit:=5;
    if (x<sor)and(x>2*(sor div 3))then terit:=6;
    exit;
  end;
if (y<5)and(ir>3)and(ir<7) then
  begin
    if x<(sor div 3)then terit:=9;
    if (x<2*(sor div 3))and(x>(sor div 3))then terit:=8;
    if (x<sor)and(x>2*(sor div 3))then terit:=7;
    exit;
  end;
end;

procedure megy(var y,x,ir:integer);
begin
if (x<5)or(x>195)or(y<5)or(y>315) then terit(y,x,i);
if (ir=1)or(ir=4) then inc(y,3);
if (ir=2)or(ir=5) then inc(y,2);
if (ir=3)or(ir=6) then inc(y);
if (ir=7)or(ir=10) then dec(y,3);
if (ir=8)or(ir=11) then dec(y,2);
if (ir=9)or(ir=12) then dec(y);
if (ir<4)or(i>9) then dec(x);
if (ir<10)and(ir>3) then inc(x);
end;

procedure init;
begin
x:=100;y:=140;i:=2;
x1:=100;y1:=180;i:=5;
end;

begin
setgr($13);
getmem(pot, $0ffff) ;
clear(pot);
init;
repeat
megy(y,x,i);
megy(y1,x1,i1);
put_pixel(y,x,9);
put_pixel(y1,x1,19);
copyfrom(pot);
until keypressed;
freemem(pot, $0ffff) ;
setgr($03);
end.