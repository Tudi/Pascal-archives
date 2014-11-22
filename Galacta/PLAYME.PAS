program player;
uses dos,crt;
VAR
  Param:string[63];
  BytesRead,BlockSize,BlockRest:Word;
  dataptr,pp:pointer;
  f:file;
  I:Integer;
  SampRateDiv,times:byte;
  reverse,wavinfo:boolean;
  fmt: record
    wFormatTag:word;
    nChannels:word;
    nSamplesPerSec:longint;
    nAvgBytesPerSec:longint;
    nBlockAlign:word;
    wBitsPerSample:word;
end;

PROCEDURE PlaySound(bufptr:pointer;bufctr:longint;ratediv,times:word);
var
    old_int8 : pointer;
    timesleft :word;
    savemask:byte;
  begin;
  ASM
        jmp     @PlayMain
  @int8_out_spk:
        xor     al,al
        out     42h,al
        mov     al,cl
        out     42h,al
        mov     ax,dx
        or      ax,si
        jz      @ready
        dec     bl
        jnz     @skip
        mov     bl,bh
        mov     al,es:[di]
        shr     al,1
        shr     al,1
        inc     al
        mov     cl,al
        inc     di
        jnz     @noseg
        mov     ax,es
        add     ax,1000h
        mov     es,ax
  @noseg:
        sub     si,+01
        sbb     dx,+00
  @skip:
        mov     al,20h
        out     20h,al
        iret
  @ready:
        mov     ch,0ffh
        jmp     @skip
  @PlayMain:
        cli
        mov     ax,3508h
        int     21h                    { get int vector 08 in es:bx }
        mov     word ptr old_int8,bx
        mov     word ptr old_int8+2,es
        in      al,21h                 { interruptmask }
        mov     savemask,al
        mov     al,0ffh                { disable all interrupts }
        out     21h,al
        sti
        push    ds
        mov     ax,cs
        mov     ds,ax
        mov     dx,offset @int8_out_spk
        mov     ax,2508h
        int     21h                    { set int vector 08 to ds:dx }
        pop     ds
        mov     al,34h
        out     43h,al                 { timer 0 mode }
        mov     al,36h                 { 22khz }
        out     40h,al
        xor     al,al
        out     40h,al
        mov     al,90h
        out     43h,al                 { timer 2 mode }
        in      al,61h                 { enable speaker }
        or      al,3
        out     61h,al
        mov     cx,times
        mov     timesleft,cx
        mov     cl,20h
        mov     bx,ratediv
        mov     bh,bl
        les     si,bufctr
        mov     dx,es
        les     di,bufptr
  @nexttime:
        push    di                     { bufptrlo }
        push    es                     { bufptrhi }
        push    si                     { bufctrlo }
        push    dx                     { bufctrhi }
        push    bx                     { ratediv  }
        xor     ch,ch                  { readyflag = false }
        mov     al,0feh                { enable timerinterrupt }
        out     21h,al
  @notready:
        or      ch,ch
        jz      @notready
        cli
        mov     al,0ffh                { disable all interrupts }
        out     21h,al
        sti
        pop     bx                     { ratediv }
        pop     dx                     { bufctrhi }
        pop     si                     { bufctrlo }
        pop     es                     { bufptrhi }
        pop     di                     { bufptrlo }
        dec     word ptr timesleft     { more times ? }
        jnz     @nexttime
        in      al,61h                 { disable speaker }
        and     al,0fch
        out     61h,al
        mov     al,34h
        out     43h,al                 { timer 0 mode }
        mov     al,0
        out     40h,al                 { timer 0 clock }
        out     40h,al                 { timer 0 clock }
        mov     al,0b6h
        out     43h,al                 { timer mode }
        mov     ax,533h
        out     42h,al                 { timer 2 spkr }
        mov     al,ah
        out     42h,al                 { timer 2 spkr }
        push    ds
        lds     dx,dword ptr old_int8
        mov     ax,2508h
        int     21h                    { set intrpt vector al to ds:dx }
        pop     ds
        mov     al,savemask            { enable timer and keyboard }
        out     21h,al
  END;
  end;

  { The following procedure is also used to half the samplerate }

  PROCEDURE ReadFormat(var f:file);
  var
    str:string[4];
    chunksize:longint;
  BEGIN
    blockread(f,str[1],4);
    str[0]:=#4;
    if str='fmt ' then begin
      blockread(f,chunksize,4);
      if wavinfo then writeln('  ''fmt '' size=',chunksize);
      if chunksize=16 then begin
        blockread(f,fmt,sizeof(fmt));
        if wavinfo then with fmt do begin
          writeln('    wFormatTag=',wFormatTag);
          writeln('    nChannels=',nChannels);
          writeln('    nSamplesPerSec=',nSamplesPerSec);
          writeln('    nAvgBytesPerSec=',nAvgBytesPerSec);
          writeln('    nBlockAlign=',nBlockAlign);
          writeln('    wBitsPerSample=',wBitsPerSample);
        end;
        if fmt.wFormatTag<>1 then begin
          writeln('Unknown Format (',fmt.wFormatTag,')!');
          halt;
        end;
        case word(fmt.nSamplesPerSec) of
          33075..65535:sampratediv:=0;
          16538..33074:sampratediv:=1;
          9188..16537:sampratediv:=2;
          6432..9187:sampratediv:=3;
          4962..6431:sampratediv:=4;
          4043..4961:sampratediv:=5;
          3413..4042:sampratediv:=6;
          else halt;
        end;
      end
      else writeln('''fmt '' chunksize error (',chunksize,')!');
    end
    else writeln('''fmt'' chunk not found!');
  END;

 PROCEDURE PlayWAVE(var f:file;sampratediv,times:byte);
  var
    str:string[4];
    DataSize,l1:longint;
    p1,p2:pointer;
    s,o:word;
  BEGIN
    blockread(f,str[1],4);
    str[0]:=#4;
    if str='data' then begin
      blockread(f,DataSize,4);
      if wavinfo then writeln('  ''data'' size=',Datasize);
      If MaxAvail>DataSize THEN BEGIN
        if DataSize<$FFF0 then Blocksize:=DataSize else Blocksize:=$8000;
        GetMem(pp,BlockSize);
        DataPtr:=pp;
        blockread(f,pp^,BlockSize,bytesread);
        if BlockSize<DataSize then begin
          For I:=1 to pred(DataSize div BlockSize) do begin
            GetMem(pp,BlockSize);
            blockread(f,pp^,Blocksize,bytesread);
          end;
          BlockRest:=DataSize mod BlockSize;
          if BlockRest<>0 then begin
            GetMem(pp,BlockRest);
            blockread(f,pp^,BlockRest,bytesread);
          end;
        end;
        PlaySound(DataPtr,DataSize,SampRateDiv,Times);
      end
      else Writeln('Not enough memory!');
    end
    else writeln('''data'' chunk not found!');
  END;

  PROCEDURE ReadRIFF(var f:file);
  var
    str:string[4];
    RIFFsize,Chunksize:longint;
  BEGIN
    blockread(f,str[1],4);
    str[0]:=#4;
    if str='RIFF' then begin
      blockread(f,RIFFsize,4);
      writeln('''RIFF'' size=',RIFFsize);
      REPEAT
        blockread(f,str[1],4);
        if str='WAVE' then begin
          ReadFormat(f);
          PlayWAVE(f,sampratediv,times);
        end
        else begin
          blockread(f,Chunksize,4);
          seek(f,filepos(f)+Chunksize);
        end;
      until filepos(f)>=RIFFsize+8;
    end
    else Writeln('No RIFF header found!');
  END;

BEGIN
  wavinfo:=false;
  reverse:=false;
  Times:=1;
  filemode:=0;
{  Param:=paramstr(1);
  if Param[1]='/' then begin
    getoption(Param);
    halt;
  end;
  if pos('.',Param)=0 then Param:=Param+'.WAV';}
  assign(f,'DEMO8.WAV');
  reset(f,1);
{  PlayWAVE(f,1,1);{}
  IF Ioresult=0 then ReadRIFF(f)
  else writeln('File not found!');{}
END.

