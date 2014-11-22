program pageprobak;
uses crt,graph2;
var i:word;

procedure setpage(pgnum:byte);
assembler;
asm
  mov ah,5
  mov al,pgnum
  int 10h
end;

procedure putpixel(x,y,vseg : word; c : byte);
assembler;
 asm
  mov ax,vseg;
  mov es,ax;
  mov ax,y;
  mov dx,320;
  mul dx
  mov di,ax;
  add di,x;
  mov al,c;
  mov [es:di],al
 end;

begin
setgr($13);
cls($b000);
putpixel(100,100,$a000,9);
putpixel(200,100,$b800,9);
readkey;
for i:=1 to 64000 do putpixel(i mod 320,1 div 320,$b800,9);
readkey;
end.
