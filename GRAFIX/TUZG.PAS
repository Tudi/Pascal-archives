program tuz;
uses crt,graph;
const klb=10;
type kor=record
        x,i:integer;
      end;
var vj,i,j:integer;
    a:array[1..640]of kor;

procedure terit;
begin
end;

procedure feltolt;
const max=250;
var i,j:integer;
begin
a[1].x:=max;
for i:=2 to 640 do
  begin
    j:=klb+1;
    while j>klb do j:=random(klb+1);
    if (random(2)=0)and(a[i-1].x<max)then a[i].x:=a[i-1].x+j
         else if (a[i-1].x>max div 2) then a[i].x:=a[i-1].x-j
           else if a[i-1].x<max then a[i].x:=a[i-1].x+j;
  end;
end;

procedure kiir;
var i:integer;
begin
for i:=1 to 640 do line(i,a[i].x,i,480);
end;

begin
randomize;
i:=detect;
initgraph(i,j,'c:\programs\pascal\bgi');
i:=1;
j:=30;
feltolt;
kiir;
readkey;
repeat
inc(i);
if i>640 then
 begin
{   readkey;{}
   delay(100);
   cleardevice;
 end;
if i>640 then i:=1;
vj:=j;
while (abs(vj-j)>klb)or(vj=j) do j:=random(110);{}
setcolor(random(16));
line(i,480-j,i,480);
until keypressed;
end.