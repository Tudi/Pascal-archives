program plazma1;
uses crt,graph2;
const msor=200; mosz=320;vseg=$a000;
var a:array[1..320,1..200]of byte;
    x,i,j:integer;

procedure szinek;
var x:integer;
begin
for x:=1 to 255 do setpal(x,round(abs(sin(i))),x div 2,round(abs(cos(i))));
  for x:=0 to 63 do begin
    setpal(x,x,x div 4,x div 2);
    setpal(64+x,x div 4,x div 2,x);
    setpal(120+x,x div 4,x,x div 2);
  end;
end;

function getpixel(x,y : word) : byte;
assembler;
 asm
  mov ax,vseg; mov es,ax; mov ax,y; mov dx,320; mul dx
  mov di,ax; add di,x; mov al,[es:di]
end;

procedure novel;
var x,x1:integer;
begin
for i:=1 to mosz do
 for j:=1 to msor do
    begin
{      a[i,j]:=(getpixel(i,j)+getpixel(i-2,j-2)+getpixel(i+2,j+2)+getpixel(i+2,j-2)+getpixel(i-2,j+2)+
               getpixel(i,j)+getpixel(i-1,j-1)+getpixel(i+1,j+1)+getpixel(i+1,j-1)+getpixel(i-1,j+1)+
               getpixel(i-1,j)+getpixel(i+1,j)+getpixel(i,j-1)+getpixel(i,j+1)+
               getpixel(i-2,j)+getpixel(i+2,j)+getpixel(i,j-2)+getpixel(i,j+2)) DIV 18;{}
{      a[i,j]:=(getpixel(i,j)+getpixel(i-1,j-1)+getpixel(i+1,j+1)+getpixel(i+1,j-1)+getpixel(i-1,j+1)+
               getpixel(i-1,j)+getpixel(i+1,j)+getpixel(i,j-1)+getpixel(i,j+1)) DIV 9;{}
{      a[i,j]:=(getpixel(i-1,j-1)+getpixel(i+1,j+1)+getpixel(i+1,j-1)+getpixel(i-1,j+1)+
               getpixel(i-1,j)+getpixel(i+1,j)+getpixel(i,j-1)+getpixel(i,j+1)) DIV 8;{}
{      a[i,j]:=(getpixel(i,j)+getpixel(i-1,j-1)+getpixel(i+1,j+1)+getpixel(i+1,j-1)+getpixel(i-1,j+1)+
              getpixel(i,j)+getpixel(i-1,j)+getpixel(i+1,j)+getpixel(i,j-1)+getpixel(i,j+1)) DIV 9;{}
{      a[i,j]:=(getpixel(i,j)+getpixel(i-1,j-1)+getpixel(i+1,j+1)+getpixel(i+1,j-1)+getpixel(i-1,j+1)) DIV 5;{}
      a[i,j]:=(getpixel(i-1,j-1)+getpixel(i+1,j+1)+getpixel(i+1,j-1)+getpixel(i-1,j+1)) DIV 4;{}
{      a[i,j]:=(getpixel(i-1,j)+getpixel(i+1,j)+getpixel(i,j-1)+getpixel(i,j+1)) DIV 4;{}
{      a[i,j]:=(getpixel(i,j)+getpixel(i-1,j)+getpixel(i+1,j)+getpixel(i,j-1)+getpixel(i,j+1)) DIV 5;{}
{      a[i,j]:=(mem[$a000:(i+(j-1)*mosz)]+mem[$a000:(i+(j+1)*mosz)]+
               mem[$a000:(i+1+j*mosz)]+mem[$a000:(i-1+j*mosz)]) DIV 4;{}
{       x:=(a[i-1,j+1]+a[i+1,j+1]+a[i+1,j-1]+a[i-1,j-1])div 4;{}
{      a[i,j]:=(a[i-1,j]+a[i+1,j]+a[i,j-1]+a[i,j+1])div 4;{}
{      x1:=round((a[i,j]+a[i-1,j+1]+a[i+1,j+1]+a[i+1,j-1]+a[i-1,j-1])/5);{}
{      x:=round((a[i-1,j]+a[i+1,j]+a[i,j-1]+a[i,j+1])/4);{}
{      a[i,j]:=round((x));{}
      inc(a[i,j]);{}
{      if a[i,j]>190 then a[i,j]:=1;{}
    end;
end;

procedure ki;
begin
clear(pot);
for i:=1 to mosz do
 for j:=1 to 200 do put_pixel(i,j,a[i,j]);
copyfrom(pot);
{readkey;}
end;

begin
setgr($13);
getmem(pot, $0ffff) ;
szinek;
randomize;
{if x<370 then
for i:=2 to mosz do put_pixel(i,100,255);
if x<370 then
for i:=2 to msor do put_pixel(160,i,255);}
repeat
ki;
novel;
{for i:=1 to 20 do a[random(320),random(200)]:=255;{}
inc(x);
if x<370 then
for i:=2 to mosz do a[i,100]:=255;
if x<370 then
for i:=2 to msor do a[160,i]:=255;{}
until keypressed;
freemem(pot, $0ffff) ;
setGr($03) ;
readkey ;
end.