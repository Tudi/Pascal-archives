program mozgatsaktablat;
uses graph2,crt;
const sarga=70;  zold=45;     piros=39;  szurke=7;   kek=9;
var r,zxc,szin,i,j,z:integer;
    no,b:boolean;

function keresr(r,x:byte):integer;
var y1:real;
begin
y1:=sqrt(abs(sqr(r)-sqr(x)));
keresr:=round(y1);
end;

procedure pirosk(y,x:integer;szin:byte);
var i,j:integer;
begin
for i:=x to x+20 do
 for j:=y to y+20 do
  if (x>0)and(y>0)and(y<320)and(x<200) then put_pixel(j,i,szin);
end;

procedure feherk(y,x:integer;szin:byte);
var i,j:integer;
begin
for i:=x to x+20 do
 for j:=y to y+20 do
  if (x>0)and(y>0)and(y<320)and(x<200) then put_pixel(j,i,szin);
end;

procedure torol(szin:byte);
var i,j:integer;
begin
for i:=1 to 320 do
 for j:=1 to 200 do put_pixel(i,j,szin);
end;

procedure hatter;
var i,j:integer;
begin
zxc:=0;
for j:=0 to 8 do
for i:=0 to 14 do
 begin
   if zxc mod 2 = 0 then pirosk(i*20,j*20+10,szin)
         else feherk(i*20,j*20+10,szin+9);
   inc(zxc);
 end;
end;

procedure bent(y,x:integer);
var i,j:integer;
begin
clear(pot);
b:=false;
torol(szin+2);
hatter;
for j:=1 to 6 do
for i:=2 to 12 do
 begin
   if zxc mod 2 = 0 then pirosk(i*20+10+y,j*20+20+x,szin*2);
   inc(zxc);
 end;
copyfrom(pot);
{delay(50);{}
end;

procedure kor;
const y1=1;   x1=1;
var r2,i,y:integer;
begin
r2:=round(r/0.999);{}
for i:=1 to r2 do
  begin
    y:=keresr(r,i);
    if (i< r2 div 2)then if i mod 3=0 then bent(1-y+y1,1-i+x1);{}
    if (i>r2 div 2 )then bent(1-y+y1,1-i+x1);
  end;
for i:=1 to r2 do
  begin
    y:=keresr(r,i);
    if (i< r2 div 2)then if i mod 3=0 then bent(i+y1,1-y+x1);{}
    if (i>r2 div 2 )then bent(i+y1,1-y+x1);{}
  end;
for i:=1 to r2 do
  begin
    y:=keresr(r,i);
    if (i< r2 div 2)then if i mod 3=0 then bent(y+y1,i+x1);{}
    if (i>r2 div 2 )then bent(y+y1,i+x1);{}
  end;
for i:=1 to r2 do
  begin
    y:=keresr(r,i);
    if (i< r2 div 2)then if i mod 3=0 then bent(1-i+y1,y+x1);{}
    if (i>r2 div 2 )then bent(1-i+y1,y+x1);{}
  end;
inc(szin);
end;


begin
setGr($13);
getmem(pot, $0ffff) ;
freemem(pot, $0ffff) ;
no:=true;
szin:=1;
r:=70;
repeat
if r>35 then dec(r);
kor;
until keypressed;
setGr($03);
end.