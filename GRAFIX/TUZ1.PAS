program megujabbtuz;
uses crt,graph2;
const msor=200; mosz=320; klb=3; koz=30;
type atr=record
        at,i,x,p:integer;
       end;
var a:array[1..mosz]of atr;
    i,j:integer;

procedure mozdit;
var at:integer;
begin
i:=1;
while i<msor do
  begin
    at:=a[i].at;
    for j:=1 to at do
        begin
          inc(i);
          if j mod i=0 then
             if (a[i].i=0)then a[i].x:=a[i].x+a[i].p
                else a[i].x:=a[i].x-a[i].p;
        end;
  end;
end;

procedure feltolt;
var at,i1,x,p,x1:integer;
begin
a[1].x:=random(koz);
for i:=2 to mosz do
  begin
    a[i].i:=random(2);
    a[i].p:=random(klb)+1;
    x1:=a[i-1].x;
    while abs(x1-x)>klb do x:=random(koz);
    a[i].x:=x;
    a[i].at:=random(msor-x div p)+1;
    for j:=i to i+a[i].at do
       begin
         a[j].i:=a[i].i;
         a[j].p:=a[i].p;
         x1:=a[j-1].x;
         while abs(x1-x)>klb do x:=random(koz);
         a[j].x:=x;
         a[j].at:=a[i].at;
       end;
    i:=a[i].at+i;
    if i>mosz then break;
  end;
end;

begin
randomize;
feltolt;
for i:=1 to mosz do
 begin
  writeln(a[i].x,' ',a[i].at,' ',a[i].p);
  if i mod 24=0 then readkey;
 end;
readkey;
setGr ($13) ;
getmem(pot, $0ffff) ;
freemem(pot, $0ffff) ;
readkey ;
setGr ($03) ;
end.
