program szovegetiratki;

procedure szovegki(szoveg:string;szin,y,x:byte);
var o,s:word;
begin
o:=ofs(szoveg);
s:=seg(szoveg);
asm
  mov ax,3
  int 10h
  mov ax,0b800h
  mov es,ax
  mov al,byte ptr[x]
  mov bl,160
  mul bl
  mov di,ax
  mov al,byte ptr[y]
  mov bl,2
  mul bl
  add di,ax
  mov si,o
  inc si
  mov dh,szin
 @betuki:
  push ds
  mov ax,s
  mov ds,ax
  mov dl,ds:[si]
  pop ds
  cmp dl,254
  jz @vege
  mov es:[di],dx
  inc si
  add di,2
  jmp @betuki
 @vege:
   xor ax,ax
   int 16h
   mov ax,4c00h
   int 21h
end;
end;

begin
{szovegki('m',143,40,12);{}
szovegki('hello world,i''m hereþ',143,0,0);{}
end.
