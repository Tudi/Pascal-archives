program charakterkiiras;

procedure charki(c:string;szin,y,x:byte);
var hossz,o,s:word;
begin
hossz:=x*160+y*2;
o:=ofs(c);
s:=seg(c);
asm
  mov ax,3
  int 10h
  mov ax,0b800h
  mov es,ax
  mov di,word ptr[hossz]
{  mov al,byte ptr[c]
  mov ah,byte ptr[szin]}
  mov si,o
  mov ax,s
  mov dh,szin
  push ds
  mov ds,ax
  mov dl,ds:[si]
  mov es:[di],dx
  pop ds
  add di,2
  inc si
  mov ds,ax
  mov dl,ds:[si]
  mov es:[di],dx
  xor ax,ax
  int 16h
end;
end;

procedure charki2(c:char;szin,y,x:byte);
assembler;
asm
  mov ax,3
  int 10h
  mov ax,0b800h
  mov es,ax
  mov al,160
  mov bl,byte ptr[x]
  mul bl
  mov di,ax
  mov al,byte ptr[y]
  mov bl,2
  mul bl
  add di,ax
  mov al,byte ptr[c]
  mov ah,byte ptr[szin]
  mov es:[di],ax
  xor ax,ax
  int 16h
end;

begin
 charki('c',143,40,12);
end.