program hexaszam;
uses crt;
var szam:word;

procedure hexa(szam:word);
begin
asm
 push ds
  mov ax,0b800h
  mov es,ax
  mov di,178;
  mov dx,word ptr[szam]
  mov ah,15
  mov cx,4
 @cimke1:
  push cx
  mov cx,4
  xor al,al
 @cimke2:
  shl dx,1
  rcl al,1
  loop @cimke2
  cmp al,10
  jng @haszam
 @betu:add al,55
  jmp @kiir
 @haszam:add al,48
 @kiir:
  mov es:[di],ax
  add di,2
  pop cx
  loop @cimke1
{  xor ax,ax
  int 16h
  mov ax,4c00h
  int 21h{}
  pop ds
end;
end;

begin
clrscr;
write('a szamot kerem(decimalis=>hexaba)');
readln(szam);
write('hexaban:');
hexa(szam);{}
readkey;
end.