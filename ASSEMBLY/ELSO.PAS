program szamkiiratasbittenkent;

procedure kiiro1;
assembler;
asm
  mov cx,21
  mov ah,15
@1_kiiro1: mov al,[si]
  mov es:[di],ax
  add di,2
  inc si
  loop @1_kiiro1
  ret
end;

procedure kiiro2;
assembler;
asm
  add di,6
  mov cx,8
  mov ah,15
 @1_kiiro2:mov al,"0"
  shl bl,1
  jnc @2_kiiro2
  mov al,"1"
 @2_kiiro2:mov es:[di],ax
 add di,2
 loop @1_kiiro2
 ret
end;

procedure bittek(s,s2:string;szam1:byte);
assembler;
asm
 mov ax,0b800h
 mov es,ax
 mov ax,3
 int 10h
 xor di,di
 mov si,offset s
 call kiiro1
 mov bl,byte ptr[szam1]
 call kiiro2
 mov di,160
 mov si,offset s2
 call kiiro1
 mov cl,1
 mov bl,byte ptr[szam1]
 ror bl,cl
 call kiiro2
 xor ax,ax
end;

begin
bittek('az eredeti szam  :','a muvelet eredmenye',254);
end.