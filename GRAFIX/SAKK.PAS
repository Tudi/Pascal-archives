program saktablaalap;
uses graph2,crt;
const sarga=70;  zold=45;     piros=39;  szurke=7;   kek=9;
var szin,i,j,z:integer;
    no,b:boolean;

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


begin
setGr($13);
getmem(pot, $0ffff) ;
freemem(pot, $0ffff) ;
no:=true;
repeat
clear(pot);
b:=false;
if no then inc(z)
  else dec(z);
if z<0 then
  begin
    no:=true;
    inc(szin);
  end;
if z>20 then
  begin
    no:=false;
    inc(szin);
  end;
torol(szin*3);
for j:=0 to 10 do
for i:=0 to 14 do
 begin
   if b then pirosk(i*20+5-j+z,j*20+1,szin)
         else feherk(i*20+5,j*20+1-i+z,szin*2);
   if b then b:=false
     else b:=true;
 end;
copyfrom(pot);
for j:=0 to 10 do
for i:=0 to 14 do
 begin
   if b then pirosk(i*20+5,j*20+1-i+z,szin*2)
         else feherk(i*20+5-j+z,j*20+1,szin);
   if b then b:=false
     else b:=true;
 end;
copyfrom(pot);
until keypressed;
setGr($03);
end.