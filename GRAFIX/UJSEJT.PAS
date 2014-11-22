program sejtosztodas;
uses crt,mouset,graph;
const ms=160;   ures=0; oszk=2;  halott=4;
      mo=213;   uj=1;   oreg=3;
var a:array[0..ms+1,0..mo+1]of byte;
    i,rand:0..ms+1;
    j,ko,ks,o,s,hosz,hpu:0..mo+1;
    gd,gm:integer;
    c:char;
    q:word;

procedure init;
begin
for i:=0 to ms+1 do
 for j:=0 to mo+1 do a[i,j]:=ures;
end;



procedure szeletkeres;
begin
s:=1;o:=1;ko:=mo;ks:=ms;
for j:=1 to mo do
 for i:=1 to ms do
  if (a[i,j]>0)then
          begin
            if ko>=j then ko:=j;
            if ks>=i then ks:=i;
            if s<=i then s:=i;
            if o<=j then o:=j;
          end;
end;




procedure central;
var x:1..mo;
begin
if (s=1)and(o=1)and(ko=mo)and(ks=ms)then exit;
if (ko+o)div 2<106 then
   for j:=o downto ko do
      begin
        for x:=1 to ms do a[x,j+106-(ko+o)div 2]:=a[x,j];
        for x:=1 to ms do a[x,j]:=4;
      end;
if (ks+s)div 2<80 then
   for j:=s downto ks do
       begin
         for x:=1 to mo do a[j+80-(s+ks)div 2,x]:=a[j,x];
         for x:=1 to ms do a[j,x]:=4;
       end;
if (ko+o)div 2>106 then
   for j:=ko to o do
     begin
       for x:=1 to mo do a[x,j-106-(o+ko)div 2]:=a[x,j];
       for x:=1 to mo do a[j,x]:=4;
     end;
if (ks+s)div 2>80 then
   for j:=ks to s do
     begin
       for x:=1 to mo do a[j-80-(s+ks)div 2,x]:=a[j,x];
       for x:=1 to mo do a[j,x]:=4;
     end;
end;




procedure beolvas;
var c:char;
begin
writeln('a-tol z-ig egy sejtet hozol letre space-el letorlod(hozz letre egy sejtmintat)majd nyomj ESC-et)');
readkey;
clrscr;
i:=1;
j:=1;
c:=readkey;
textcolor(white);
while c<>#27 do
 begin
  if c=#0 then
      begin
        c:=readkey;
        if (c=#72)and(i>1)then dec(i);
        if (c=#80)and(i<25)then inc(i);
        if (c=#75)and(j>1)then dec(j);
        if (c=#77)and(j<80)then inc(j);
      end;
  if (c>'a')and(c<'z') then a[i,j]:=uj;
  if (c=' ') then a[i,j]:=ures;
  gotoxy(75,25);
  write('     ');
  gotoxy(75,25);
  write(i,' ',j);
  gotoxy(j,I);
  if a[i,j]=uj then write('Û')
      else write(' ');
  gotoxy(j,I);
  c:=readkey;
end;
end;

procedure beolvasm;
var im,xm,ym:word;
begin
writeln('a bal gombbal sejtet hozozl letre a jobbal letorlod(ha kessz vagy a sejtmintaval nyomj meg egy bilentyut)');
readkey;
clrscr;
mouseinit;
clrscr;
repeat
  mousedata(im,xm,ym);
  if im=1 then
      begin
        a[ym,xm]:=uj;
        gotoxy(xm,ym);
        mousehide;
        textcolor(white);
        write('Û');
        mouseshow;
      end;
  if im=2 then
      begin
        a[ym,xm]:=ures;
        gotoxy(xm,ym);
        mousehide;
        textcolor(black);
        write('Û');
        mouseshow;
      end;
until keypressed;
readkey;
end;


procedure kisejt(osz,sor:word);
begin
if a[i,j]<halott then putpixel(osz*3,sor*3,red);
if a[i,j]=halott then putpixel(osz*3,sor*3,black);
if a[i,j]=uj then SetColor(green);
if a[i,j]=oszk then SetColor(red);
if a[i,j]=oreg then SetColor(yellow);
if a[i,j]=halott then SetColor(black);
rectangle(osz*3-1,sor*3-1,osz*3+1,sor*3+1);
{circle(osz*3,sor*3,2);}
end;


procedure kirajzol;
begin
for i:=1 to ms do
 for j:=1 to mo do
     if (a[i,j]<5)and(a[i,j]<>ures) then kisejt(j,i)
end;

procedure oregedik;
begin
for i:=1 to ms do
 for j:=1 to mo do
     if a[i,j]=oszk then a[i,j]:=oreg
       else if a[i,j]=uj then a[i,j]:=oszk;
end;


procedure elhal;
begin
for i:=1 to ms do
 for j:=1 to mo do if a[i,j]=oreg then a[i,j]:=halott;
end;


procedure eltunik;
begin
for i:=1 to ms do
 for j:=1 to mo do if a[i,j]=halott then a[i,j]:=ures;
end;



procedure pusztul4;{piramis}
begin
for i:=1 to ms do
 for j:=1 to mo do if a[i,j]=3 then a[i,j]:=4;
end;





procedure osztodik6;{rakos2random}
var ro,rs:byte;
begin
if q mod rand=0 then
  begin
    ro:=random(210+2);
    rs:=random(157+2);
    a[rs,ro]:=1;
    a[rs-1,ro]:=1;
    a[rs+1,ro]:=1;
    a[rs,ro-1]:=1;
    a[rs,ro+1]:=1;
  end;
for i:=1 to ms do
 for j:=1 to mo do
        begin
          if(a[i,j-1]=2)and(a[i,j-2]=2)and(a[i,j]=0)and(a[i,j+1]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i,j+1]:=uj;
                 end;
          if(a[i,j+1]=2)and(a[i,j+2]=2)and(a[i,j]=0)and(a[i,j-1]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i,j-1]:=uj;
                 end;
          if(a[i+1,j]=2)and(a[i+2,j]=2)and(a[i,j]=0)and(a[i-1,j]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i-1,j]:=uj;
                 end;
          if(a[i-1,j]=2)and(a[i-2,j]=2)and(a[i,j]=0)and(a[i+1,j]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i+1,j]:=uj;
                 end;
        end;
end;





procedure osztodik5;{rakos}
const z=160;
begin
{readkey;}
a[2,q mod z]:=1;{jfent}
a[3,q mod z]:=1;
a[q mod z+1,1]:=1;{jfent}
a[q mod z+1,2]:=1;
a[158,q mod z]:=1;{jlent}
a[159,q mod z]:=1;
a[159-q mod z,1]:=1;{jlent}
a[159-q mod z,2]:=1;
a[1,217-q mod z]:=1;{bfent}
a[2,217-q mod z]:=1;
a[q mod z+1,212]:=1;{bfent}
a[q mod z+1,213]:=1;
a[158,214-q mod z]:=1;{blent}
a[159,214-q mod z]:=1;
a[159-q mod z,212]:=1;{blent}
a[159-q mod z,213]:=1;
for i:=1 to ms do
 for j:=1 to mo do
        begin
          if(a[i,j-1]=2)and(a[i,j-2]=2)and(a[i,j]=0)and(a[i,j+1]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i,j+1]:=uj;
                 end;
          if(a[i,j+1]=2)and(a[i,j+2]=2)and(a[i,j]=0)and(a[i,j-1]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i,j-1]:=uj;
                 end;
          if(a[i+1,j]=2)and(a[i+2,j]=2)and(a[i,j]=0)and(a[i-1,j]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i-1,j]:=uj;
                 end;
          if(a[i-1,j]=2)and(a[i-2,j]=2)and(a[i,j]=0)and(a[i+1,j]=0)then
                 begin
                   a[i,j]:=uj;
                   a[i+1,j]:=uj;
                 end;
        end;
end;








procedure osztodik4;{piramis}
var m:0..9;
begin
for i:=1 to ms do
 for j:=1 to mo do
        begin
          m:=0;
          if(a[i-1,j-1]=oszk)and(a[i-2,j-2]=0)then inc(m);
          if(a[i-1,j+1]=oszk)and(a[i-2,j+2]=0)then inc(m);
          if(a[i+1,j+1]=oszk)and(a[i+2,j+2]=0)then inc(m);
          if(a[i+1,j-1]=oszk)and(a[i+2,j-2]=0)then inc(m);
          if m=1 then a[i,j]:=uj;
        end;
end;



procedure pusztul2;{kereszt}
var m:0..9;
begin
for i:=1 to ms do
 for j:=1 to mo do
        begin
          m:=0;
          if(a[i,j-1]=uj)and(a[i,j]=uj)then inc(m);
          if(a[i-1,j]=uj)and(a[i,j]=uj)then inc(m);
          if(a[i,j+1]=uj)and(a[i,j]=uj)then inc(m);
          if(a[i+1,j]=uj)and(a[i,j]=uj)then inc(m);
          if m>1 then a[i,j]:=halott;
        end;
end;





procedure osztodik2;{kereszt}
var m:0..9;
begin
for i:=1 to ms do
 for j:=1 to mo do
        begin
          m:=0;
          if(a[i,j-1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i-1,j]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i,j+1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i+1,j]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if m=1 then a[i,j]:=uj;
        end;
end;




procedure osztodik3;{atlo}
var m:0..9;
begin
for i:=1 to ms do
 for j:=1 to mo do
        begin
          m:=0;
          if(a[i-1,j-1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i-1,j+1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i+1,j+1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i+1,j-1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if m=1 then a[i,j]:=uj;
        end;
end;


procedure pusztul3;{atlo}
var m:0..9;
begin
for i:=1 to ms do
 for j:=1 to mo do
        begin
          m:=0;
          if(a[i-1,j-1]=uj)and(a[i,j]=uj)then inc(m);
          if(a[i-1,j+1]=uj)and(a[i,j]=uj)then inc(m);
          if(a[i+1,j+1]=uj)and(a[i,j]=uj)then inc(m);
          if(a[i+1,j-1]=uj)and(a[i,j]=uj)then inc(m);
          if m>1 then a[i,j]:=halott;
        end;
end;




procedure pusztul;
var m:0..9;
begin
for i:=1 to ms do
 for j:=1 to mo do
        begin
          m:=0;
          if(a[i-1,j-1]=1)and(a[i,j]<4)then inc(m);
          if(a[i-1,j+1]=1)and(a[i,j]<4)then inc(m);
          if(a[i+1,j+1]=1)and(a[i,j]<4)then inc(m);
          if(a[i+1,j-1]=1)and(a[i,j]<4)then inc(m);
          if(a[i,j-1]=uj)and(a[i,j]<4)then inc(m);
          if(a[i-1,j]=uj)and(a[i,j]<4)then inc(m);
          if(a[i,j+1]=uj)and(a[i,j]<4)then inc(m);
          if(a[i+1,j]=uj)and(a[i,j]<4)then inc(m);
          if m>1 then a[i,j]:=oreg;
        end;
end;





procedure osztodik;
var m:0..9;
begin
for i:=1 to ms do
 for j:=1 to mo do
        begin
          m:=0;
          if(a[i-1,j-1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i-1,j+1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i+1,j+1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i+1,j-1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i,j-1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i-1,j]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i,j+1]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if(a[i+1,j]=oszk)and(a[i,j]<>uj)and(a[i,j]<>oszk)then inc(m);
          if m=1 then a[i,j]:=uj;
        end;
end;


begin
init;
writeln('van mousod(i/n)');
readln(c);
if 'I'=upcase(c) then beolvasm;
if upcase(c)='N' then beolvas;
clrscr;
writeln('hogyan osztodjek');
writeln('1) kereszt');
writeln('2) atlo');
writeln('3) kereszt&atlo');
writeln('4) piramis');
writeln('5) rakos1');
writeln('6) rakos2');
readln(hosz);
if hosz=6 then
   begin
     writeln('a gyakorisag szamat');
     readln(rand);
   end;
writeln('hogyan haljanak el');
writeln('1) kereszt');
writeln('2) atlo');
writeln('3) kereszt&atlo');
writeln('4) oregedik');
readln(hpu);
szeletkeres;
if (ko<>213-o)or(ks<>160-s) then central;;
gd:=detect;
initgraph(gd,Gm,' ');
for q:=1 to 2000 do
  begin
    if q mod 10=0 then szeletkeres;
    if (hosz<>6)and(q mod 10=0)and(ko>3)and(ks>3)and(o<210)and(s<157) then
        begin
          cleardevice;
          central;
        end;
    kirajzol;
    eltunik;
    if hpu=1 then pusztul2;
    if hpu=2 then pusztul3;
    if hpu=3 then pusztul;
    if hpu=4 then pusztul4;
    elhal;
    oregedik;
    if hosz=1 then osztodik2;
    if hosz=2 then osztodik3;
    if hosz=3 then osztodik;
    if hosz=4 then osztodik4;
    if hosz=5 then osztodik5;
    if hosz=6 then osztodik6;
    if keypressed then
        begin
          closegraph;
          writeln('vege ?');
          readln(c);
          if upcase(c)='I' then exit;
          writeln('uj osztodasi szabalyt(regi: ',hosz,')');
          writeln('1) kereszt');
          writeln('2) atlo');
          writeln('3) kereszt&atlo');
          writeln('4) piramis');
          writeln('5) rakos1');
          writeln('6) rakos2');
          readln(hosz);
          if hosz=6 then
             begin
               writeln('a gyakorisag szamat');
               readln(rand);
             end;
          writeln('uj elhalasi szabalyt(regi: ',hpu,')');
          writeln('1) kereszt');
          writeln('2) atlo');
          writeln('3) kereszt&atlo');
          writeln('4) oregseg');
          readln(hpu);
          initgraph(gd,Gm,' ');
        end;
  end;
readkey;
closegraph;
end.
