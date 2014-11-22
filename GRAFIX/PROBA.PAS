uses crt;
const size=390;  x=48;{szinskala} lepes=3;{lasabb=>nagyobb}
var i:integer;
    n2,n1,n3:integer;
    a:array[1..size]of byte;
    b:boolean;
    c:char;

procedure init2(y,sz:integer);
const pl=15;
var i,k:integer;
begin
fillchar(a,sizeof(a),0);
k:=pl+sz;
for i:=y to y+x do
  begin
    a[i]:=k;
    inc(k);
  end;
k:=x+pl-1+sz;
for i:=y+x to y+x*2 do
  begin
    a[i]:=k;
    dec(k);
  end;
end;

procedure szinez;
var n,sz,sz1,sz2:integer;
begin
n:=0;
sz:=0;sz1:=0;sz2:=0;
asm cli end;
  while (port[$3da] and 8)<>0 do;
  while (port[$3da] and 8)=0 do;
  for i:=1 to size do
    begin
      if n3 mod 3=0 then sz:=a[n];
      if n3 mod 4=0 then sz1:=a[n]
         else sz2:=a[n];
      port[$3c8]:=0;{}
      port[$3c9]:=sz;{}
      port[$3c9]:=sz1;
      while (port[$3da] and 1)<>0 do;
      while (port[$3da] and 1)=0 do;
      port[$3c9]:=sz2;
      inc(n);{}
    end;
asm sti end;
end;

procedure rez;
begin
inc(n1);
if (b=true)and(n1 mod lepes=0) then inc(n2);
if (b=false)and(n1 mod lepes=0) then dec(n2);
if n2=size-x*2-3 then
 begin
   b:=false;
   dec(n2);
   n1:=0;
 end;
if n2=1 then b:=true;
if n1 mod x =0 then inc(n3);
init2(n2,n1);
szinez;
end;

begin
init2(1,1);
clrscr;
b:=true;
n3:=3;
repeat
repeat
rez;
until keypressed;
c:=readkey;
if c=#13 then writeln;
write(c);
until keypressed;
end.