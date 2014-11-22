program szamkiiratas;
var szam:word;

procedure kiszam(sz:word);
var temp:word;
begin
asm
  mov ax,0b800h
  mov es,ax
  mov di,offset temp
  mov ax,word ptr[sz]
  mov bx,10
  xor cx,cx
 @cimke1:
  xor dx,dx
  div bx
  mov [di],dl
  inc cx
  inc di
  or ax,ax
  jnz @cimke1
  mov si,di
  dec si
  xor di,di
  mov ah,15
 @cimke2:
  mov al,[si]
  add al,48
  mov es:[di],ax
  add di,2
  dec si
  loop @cimke2
end;
end;

begin
kiszam(1992);
end.