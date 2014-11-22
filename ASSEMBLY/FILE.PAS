program filekinyitrasolvasasra;
var memc,fileszam,o:word;
    filenev:string;
    buffer: pointer ;


begin
filenev:='nev.txt';
o:=ofs(filenev);
getMem(buffer, 1233) ;
asm
  mov ax,3
  int 10h

  mov ax,3d00h
  mov dx,offset filenev    {a file megnyitasa olvasasra}
  inc dx
  int 21h

  mov bx ,ax {file azonosito informacio}

  push ds
  lds dx, buffer
  mov ax,3f00h
  mov cx,32
  int 21h
  pop ds

  mov ax,3e00h
  int 21h

  xor di,di
  xor si,si
  mov ax,0b800h
  mov es,ax
  push ds
  lds si, buffer
  mov ah,14
  xor bx,bx
 @cimke1:
  mov al,ds:[si]
  inc si
  cmp al,13
  jz @cimke2
  cmp al,255
  jz @kilepes
  mov es:[di+bx],ax
  add bx,2
  jmp @cimke1
 @cimke2:
  xor bx,bx
  inc si
  add di,160
  jmp @cimke1
 @kilepes:
  pop ds
  mov ax,4c00h
  int 21h
end;
end.