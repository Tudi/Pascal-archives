
procedure copymem(target,source:pointer;nr:word);
var s1,s2,o2,o1:word;
begin
  s1:=seg(target^);
  s2:=seg(source^);
  o1:=ofs(target^);
  o2:=ofs(source^);
  nr:=nr div 4;
asm
  push ds
  push es
  push si
  push di
  mov cx,nr
  mov ax,s1
  mov es,ax
  mov di,o1
  mov ax,s2
  mov si,o2
  mov ds,ax
  db 66h{}
  rep movsw
  pop di
  pop si
  pop es
  pop ds
end;
end;

procedure setpage(pgnum:byte);
assembler;
asm
  mov ah,5
  mov al,pgnum
  int 10h
end;
