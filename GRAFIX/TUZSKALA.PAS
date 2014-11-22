program szinskala;
uses graph2,crt;
var i,j : integer ;
    sz,zxc:byte;
    c:char;
    b:boolean;
    a:array[1..100]of integer;

begin
setGr($13);
getmem(pot,$0ffff);
clear(pot);{torli az x grafikus tarat}
copyfrom(pot);{behelyetesiti a grafikus tarba az x tarat}
{line2(1,1,320,200,9);
copyfrom(pot);
readln;{}
a[1]:=105;
a[2]:=33;
a[3]:=79;

a[4]:=130;
a[5]:=110;
a[6]:=38;
a[7]:=64;
a[8]:=160;

a[9]:=158;
a[10]:=36;
a[11]:=58;
a[12]:=134;
a[13]:=85;

for j:=1 to 27 do if j mod 2 =0 then line2(j,1,j,200,a[j div 2]);
copyfrom(pot);
readkey;
freemem(pot,$0ffff);
setGr($03);
writeln(sz);
end.