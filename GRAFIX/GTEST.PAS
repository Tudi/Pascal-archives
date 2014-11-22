uses crt,graph,graph2;
var i,j:integer;
begin
i:=0;
initgraph(i,j,' ');
putpixel(150,100,red);
readkey;
getmem(pot,$0ffff) ;
clear(pot);
for i:=1 to 320 do
 for j:=1 to 200 do putpixel(i,j,red);
readkey;
copyfrom(pot);
readkey;
freemem(pot,$0ffff) ;
closegraph;
end.