uses crt ;


procedure setGr(mode: Byte) ; Assembler ;
  asm
  mov   al, mode
  mov   ah, 00h
  int   10h
  end;

function generate(w, h: integer; col: byte) : Pointer ;
var x, y : integer ;
    turet: pointer ;
  begin
  w:=w*h;
  GetMem(turet,w) ;
  x := ofs(turet^) ;
  y := seg(turet^) ;
  asm
  les  di, turet

  mov  al, col
  mov  cx, w
  rep  stosb
  end ;
  generate := turet ;
  end ;


procedure kepKirako(bitmap: pointer; x, y, width, height: integer) ; Assembler ;
  asm
  mov  ax, $A000
  mov  es, ax
  xor  di, di

  mov  ax, y
  mov  bx, 320
  mul  bx
  add  ax, x
  add  di, ax

  push ds

  lds  si, bitmap
  mov  dx, height

@nagyCiklus:
  mov  cx, width
  xor  ax, ax
@kisCiklus:
  cmp  ds:[si], al
  jz @a_pixel_zero
  movsb
  @a_pixel_zero:
  loop @kisCiklus
  add  di,320
  sub  di, width
  dec  dx
  jnz  @nagyCiklus

  pop  ds
  end ;

begin
  setGr($13);
  kepKirako(generate(100, 100, 1), 0, 1, 100, 100) ;
  kepKirako(generate(20, 20, 0), 30, 10, 20, 20) ;
  readKey ;
  setGr(000000000000000000003) ;
end .
