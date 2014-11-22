program palettatvaltoztat;
uses graph2,crt;
var i,j:word;
    b:byte;

procedure setpal(col,r,g,b : byte); assembler; asm
  mov dx,03c8h; mov al,col; out dx,al; inc dx; mov al,r
  out dx,al; mov al,g; out dx,al; mov al,b; out dx,al; end;

procedure initcolors;
var i : byte;
begin
  for i := 0 to 63 do begin
    setpal(i+1,21+i div 3,21+i div 3,63-i);
    setpal(i+65,42-i div 3,42+i div 3,i div 3);
  end;
end;

{procedure InitColors; var I : byte;

begin
  for I := 1 to 63 do begin
    port[$3C8] := I;
    port[$3C9] := 32;
    port[$3C9] := I div 2;
    port[$3C9] := I;
  end;
end;}

procedure kikep;
begin
 clear(pot);
 for i:=1 to 200 do
  for j:=1 to 320 do
   put_pixel(j,i,i);
 copyfrom(pot);
 readkey;
end;

var x,x44:integer;
begin
setgr($13);
getmem(pot, $0ffff) ;
{initcolors;
kikep;}
for x:=0 to 63 do
  begin
    setpal(x,x div 4,x div 2,x);{}
{    setpal(127-x,x div 4,x div 2,x);{}
{    setpal(127+x,x,x div 4,x div 2);{}
    setpal(127-x,x,x div 4,x div 2);{}
  end;
 kikep;
 x44:=-10;
{ while x44<70 do
   begin
     kikep;
     inc(x44,10);
     for i:=1 to 255 do setpal(i,255-i div 6,255-i div 4,x44);
   end;}
freemem(pot, $0ffff) ;
setgr($03);
readkey;
end.