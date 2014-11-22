uses crt;

procedure kiiro2;
assembler;
asm
  mov cx,2
 @1_kiiro2:push cx
  mov cx,4
  xor al,al
 @2_kiiro2:
  shl bx,1
  rcl al,1
  loop @2_kiiro2
  add al,48
  mov es:[di],ax
  add di,2
  pop cx
  loop @1_kiiro2
  ret
end;

procedure oraki(y,x:byte);
assembler;
asm
  push ds
  mov ax,3
  int 10h
  mov ax,0b800h
  mov es,ax
  mov ax,200h
  int 1ah
  mov al,byte ptr[x]
  mov bl,160
  mul bl
  mov di,ax
  mov al,byte ptr[y]
  mov bl,2
  mul bl
  add di,ax
  mov ah,15
  mov bx,cx
  call kiiro2
  add di,2
  mov bh,dh
  call kiiro2
  mov al,":"
  mov es:[di-6],ax
{  xor ax,ax
  int 16h{}
{  mov ax,4c00h
  int 21h{}
  pop ds
end;

begin
 randomize;
 while not keypressed do
  begin
    oraki(random(70),random(23));
    delay(20);{}
  end;
end.