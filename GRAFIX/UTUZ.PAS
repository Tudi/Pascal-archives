program ujabbtuz;
uses crt,graph2;
const klb=1; msor=200; mosz=320; mszin=13;
var vj,i,j:integer;
    a:array[1..640]of integer;
    b:array[1..100]of integer;

procedure szinek;
begin
b[1]:=105;
b[2]:=33;
b[3]:=79;

b[4]:=130;
b[5]:=110;
b[6]:=38;
b[7]:=64;
b[8]:=160;

b[9]:=158;
b[10]:=36;
b[11]:=58;
b[12]:=134;
b[13]:=85;
end;

procedure szinek1;
{pl:34!,56,81,107!,132,154}
const sz=34;
begin
for i:=sz to sz+13 do b[i-sz+1]:=i;
for i:=sz to sz+6 do b[i-sz+5]:=i;
end;

procedure feltolt;
const max=250;
var i,j:integer;
begin
a[1]:=max;
for i:=2 to mosz do
  begin
    j:=klb+1;
    while j>klb do j:=random(klb+1);
    if (random(2)=0)and(a[i-1]<max)then a[i]:=a[i-1]+j
         else if (a[i-1]>max div 2) then a[i]:=a[i-1]-j
           else if a[i-1]<max then a[i]:=a[i-1]+j;
  end;
end;

procedure line2(y1,x1:integer);
var i,j,k,l:integer;
begin
k:=13;
l:=36;
for i:=x1 to msor do
  begin
    for j:=2 to mszin do if (msor-x1) div j=i-x1 then dec(k);{}
{   if l<=0 then l:=2;
   if i mod l=0 then
       begin
         dec(k);
         l:=l div 3;
       end;}
    put_pixel(y1,i,b[k]);
  end;
end;

procedure kiir;
var i:integer;
begin
for i:=1 to mosz do line2(i,a[i]);
end;

begin
randomize;
setGr($13) ;
getmem(pot, $0ffff) ;
i:=1;
j:=mszin+5;
feltolt;
kiir;
szinek1;
repeat
inc(i);{}
if i>mosz then
  begin
    copyfrom(pot);
    delay(200);{}
    clear(pot);
  end;
if i>mosz then i:=1;
vj:=j;
while (abs(vj-j)>klb)or(vj=j) do j:=random(110);{}
line2(i,msor-j);
until keypressed;
freemem(pot, $0ffff) ;
readkey ;
setGr ($03) ;
end.