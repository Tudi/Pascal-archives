program sejtosztodas;
uses crt,graph,mouset;
var a:array[0..161,0..214]of byte;
    i:0..161;
    j,ko,ks,o,s,q:0..214;
    gd,gm:integer;

procedure init;
begin
for i:=0 to 161 do
 for j:=0 to 214 do a[i,j]:=0;
end;

procedure central;
var z:array[1..214]of byte;
    x:1..213;
begin
s:=1;o:=1;ko:=213;ks:=160;
for j:=1 to 213 do
 for i:=1 to 160 do
  if (a[i,j]=1)then
          begin
            if ko>j then ko:=j;
            if ks>i then ks:=i;
            if s<i then s:=i;
            if o<j then o:=j;
          end;
if (ko+o)div 2<106 then
   for j:=o downto 1 do
      begin
        for x:=1 to 160 do a[x,j+106-(ko+o)div 2]:=a[x,j];
        for x:=1 to 160 do a[x,j]:=0;
      end;
if (ks+s)div 2<80 then
   for j:=s downto 1 do
       begin
         for x:=1 to 213 do a[j+80-(s+ks)div 2,x]:=a[j,x];
         for x:=1 to 160 do a[j,x]:=0;
       end;
if (ko+o)div 2>106 then
   for j:=ko to 213 do
     begin
       for x:=1 to 213 do a[x,j-106-(o+ko)div 2]:=a[x,j];
       for x:=1 to 213 do a[j,x]:=0;
     end;
if (ks+s)div 2>80 then
   for j:=ks to 160 do
     begin
       for x:=1 to 213 do a[j-80-(s+ks)div 2,x]:=a[j,x];
       for x:=1 to 213 do a[j,x]:=0;
     end;
{for i:=1 to 160 do
 for j:=1 to 213 do if a[i,j]=true then
     begin
       writeln(i);
       readkey;
     end;}
end;


procedure beolvas;
var c:char;
begin
clrscr;{elso sor elso oszlop}
i:=1;
j:=1;
c:=readkey;
textcolor(white);
repeat
  if c=#0 then
      begin
        c:=readkey;
        if (c=#72)and(i>1)then dec(i);
        if (c=#80)and(i<25)then inc(i);
        if (c=#75)and(j>1)then dec(j);
        if (c=#77)and(j<80)then inc(j);
      end;
  if (c>'a')and(c<'z') then a[i,j]:=1;
  if (c=' ') then a[i,j]:=0;
  gotoxy(75,25);
  write('     ');
  gotoxy(75,25);
  write(i,' ',j);
  gotoxy(j,I);
  if a[i,j]=1 then write('Û')
      else write(' ');
  gotoxy(j,I);
  c:=readkey;
until c=#27;
end;


procedure kisejt(osz,sor:word);
var z,os,so:1..641;
begin
os:=2;
so:=2;
for z:=1 to osz do os:=os+2;
for z:=1 to sor do so:=so+2;
{closegraph;
writeln(os*2-108,' ',so*2);
readkey;}
putpixel(os*2-108,so*2-84,lightred);
SetColor(lightblue);
circle(os*2-108,so*2-84,2);
end;


procedure kirajzol;
begin
cleardevice;
for i:=1 to 160 do
 for j:=1 to 213 do if a[i,j]=1 then kisejt(j,i);
end;

procedure osztodik;
var sz,h:array[0..3,0..214]of byte;
    e:array[0..213]of byte;
    m,s,x,ki,w:0..213;
begin
for i:=1 to 160 do
 for j:=1 to 213 do
        begin
          m:=0;{szabalyok}
          if(a[i,j-1]=1)and(a[i,j]<>1)then inc(m);
          if(a[i-1,j]=1)and(a[i,j]<>1)then inc(m);
          if(a[i,j+1]=1)and(a[i,j]<>1)then inc(m);
          if(a[i+1,j]=1)and(a[i,j]<>1)then inc(m);
          if m=1 then a[i,j]:=3;
        end;
for i:=1 to 160 do
 for j:=1 to 213 do
        begin
          m:=0;
          if(a[i,j-1]=1)and(a[i,j]=1)then inc(m);
          if(a[i-1,j]=1)and(a[i,j]=1)then inc(m);
          if(a[i,j+1]=1)and(a[i,j]=1)then inc(m);
          if(a[i+1,j]=1)and(a[i,j]=1)then inc(m);
          if m>1 then a[i,j]:=0;
        end;
for i:=1 to 160 do
 for j:=1 to 213 do if(a[i,j]=3)then a[i,j]:=1;
end;


begin
init;
beolvas;
{for i:=1 to 160 do
 for j:=1 to 213 do if a[i,j]=1 then writeln(i,' ',j);
readkey;}
gd:=detect;
initgraph(gd,Gm,' ');
repeat
  if q>1 then osztodik;
  central;
  kirajzol;
  inc(q);
until keypressed;
closegraph;
end.