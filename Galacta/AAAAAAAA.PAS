program galaktika;
uses dos,screens,initenem,graph2,hajok,kelekek,crt;
const fel=#72;   pfel=#73;    f10=#68;   f4=#62;     f8=#66;
      le=#80;    ple=#81;     f1=#59;    f5=#63;     f9=#67;
      bal=#75;   tab=#9;      f2=#60;    f6=#64;     space=#32;
      job=#77;   esc=#27;     f3=#61;    f7=#65;     lila=35;
      sarga=70;  zold=45;     piros=39;  szurke=7;   kek=9;
      sor=200;   oszlop=320;  feher=30;{}
const maxsor=150;  maxosz=300;     minsor=10;    minosz=10;
      mg=100;      bszel=10;       jszel=315;    msor=190;
      shiposz=28;                  shipal=420;
      speedyosz=21;                speedyal=231;
      speedy2osz=40;               speedy2al=440;
      piratosz=42;                 piratal=546;
      csakanyosz=28;               csakanyal=812;
      tankosz=40;                  tankal=760;
      htankosz=38;                 htankal=798;
      bomberosz=44;                bomberal=968;
      hbomberosz=45;               hbomberal=855;
      plazmaosz=34;                plazmaal=748;
      obsosz=31;                   obsal=682;
      pokosz=33;                   pokal=792;
      psychoosz=45;                psychoal=585;
      psycho2osz=40;               psycho2al=680;
      slife=15;     sshield=5;
      s2life=30;    s2shield=15;
      plife=50;     pshield=20;
      cslife=100;   csshield=5;
      tlife=150;    tshield=25;
      htlife=200;   htshield=25;
      blife=200;    bshield=5;
      hblife=200;   hbshield=15;{}
      pllife=255;   plshield=30;
      olife=200;    oshield=25;
      polife=100;   poshield=40;
 mrad=15;    mlspeed=5;    mspeed=10;   mpsychodam=200;
 mldam=30;   marmor=50;    mlszam=100;  mlife=30000;
 menergy=60000;            mlevel=20;
type kor=record
          x,y:integer;
        end;
     en=record
          x,y:integer;
          life,irany,szor,at,tipe:byte;
        end;
     golyo=record
        x,y:integer;
        t:byte;
      end;
     gen=array[1..mg]of golyo;
     resz=^byte;
var enem:array[1..50] of en;
    x,y,life:integer;
    rad,level,lspeed,speed,psychodam,ldam,lszin,abombs,psychos,armor,lsz,mlsz:byte;
    pfegyver,sfegyver:byte;
    bel,bpsycho,bion,bcloak,bbombs:boolean;
    energy,penz,score:longint;
    ge,go:gen;
    ko:array[1..10]of golyo;
    kosz,elgyak,elspeed,melsz,elsz,earmor,eldam,epsychodam,esz,mesz:byte;
    erad,elszin:byte;
    delay1,szin:byte;
    magnet,bay,exitg,soundb,inv:boolean;
    name:string[20];
    c:char;
    DirInfo:SearchRec;
    point:word;
    psychop,psycho2p,bomberp,hbomberp,htankp,tankp,csakanyp,piratp:pointer;
    pot1,tuz1p,tuz2p,tuz3p,plazmap,obsp,pokp,speedy2p,speedyp,shipp:pointer;

procedure menu;forward;
procedure upgrademenu;forward;
procedure rendezenemyt;forward;
procedure chooseinit;forward;

procedure ujratxt;
begin
kekhatter;
upgrademenu;
gotoxy(35,21);
write('money:',penz);
gotoxy(2,23);
write('S-save     L-load     X-exit     score: ',score);
gotoxy(2,21);
write('a number(1..12): ');
end;

procedure cheats;
begin
name:='terminator 66';
penz:=30000;
energy:=300000;
psychos:=255;
bay:=true;
magnet:=true;
armor:=marmor+2;
ldam:=mldam+2;
psychodam:=mpsychodam+2;
lszin:=lila;
lsz:=0;
lspeed:=mlspeed;
rad:=mrad;
speed:=mspeed;
mlsz:=mg;
life:=30000;
abombs:=255;
bel:=true;bpsycho:=true;bion:=true;bbombs:=true;bcloak:=true;
end;

procedure jatekotinicializal;
begin
soundb:=true;{}
erad:=3;
elgyak:=30;
melsz:=10;
elspeed:=0;
{soundb:=false;{}
earmor:=1;
eldam:=19;
elsz:=10;
mesz:=10;
epsychodam:=150;
elszin:=kek;
pfegyver:=1;
sfegyver:=1;
name:='jozsa istvan';
penz:=100;
psychos:=1;
bay:=false;
armor:=1;
ldam:=15;
psychodam:=100;
x:=150;
y:=160;
lszin:=kek;
energy:=1;
lsz:=0;
speed:=1;
mlsz:=3;
exitg:=false;
life:=5000;
abombs:=1;
lspeed:=1;
rad:=3;
level:=1;
end;

procedure buy;
var s:string[6];
    sz2,sz,szam:integer;
    i:integer;
begin
ujratxt;
repeat
  textbackground(black);
  gotoxy(19,21);
  write('  ');
  gotoxy(19,21);
  readln(s);
  val(s,szam,i);
  if (szam=1)and(penz>=sqr(speed*2))and(speed<10) then
       begin
         penz:=penz-sqr(speed*2);
         inc(speed);
         ujratxt;
       end;
  if (szam=2)and(penz>=armor*3)and(armor<200) then
       begin
         penz:=penz-armor*3;
         inc(armor);
         ujratxt;
       end;
  if (szam=3)and(penz>=5)and(life<20000) then
       begin
         gotoxy(2,22);
         textbackground(blue);
         write('how many: ');
         read(sz);
         if (penz div 5)*5>penz then sz2:=(penz div 5)*5
             else sz2:=sz*5;
         penz:=penz-sz2;
         life:=life+sz2 div 5;
         ujratxt;
       end;
  if (szam=4)and(penz>=ldam*2)and(ldam<255) then
       begin
         penz:=penz-ldam*2;
         inc(ldam);
         ujratxt;
       end;
  if (szam=5)and(penz>=2*psychodam)and(psychodam<255) then
       begin
         penz:=penz-psychodam;
         inc(psychodam);
         ujratxt;
       end;
  if (szam=6)and(penz>=100)and(lsz<3) then
       begin
         penz:=penz-100;
         inc(lsz);
         ujratxt;
       end;
  if (szam=7)and(penz>=2*mlsz)and(mlsz<200) then
       begin
         penz:=penz-2*mlsz;
         inc(mlsz);
         ujratxt;
       end;
  if (szam=8)and(penz>=20)and(psychos<200) then
       begin
         penz:=penz-20;
         inc(psychos);
         ujratxt;
       end;
  if (szam=11)and(penz>=50)and(abombs<200) then
       begin
         penz:=penz-50;
         inc(abombs);
         ujratxt;
       end;
  if (szam=12)and(penz>=100)and(magnet=false) then
       begin
         penz:=penz-100;
         magnet:=true;
         ujratxt;
       end;
  if (szam=13)and(penz>=10) then
       begin
         gotoxy(2,22);
         textbackground(blue);
         write('how many: ');
         read(sz);
         if (penz div 10)*10>penz then sz2:=(penz div 10)*10
             else sz2:=sz*10;
         penz:=penz-sz2;
         energy:=energy+sz2 div 10;
         ujratxt;
       end;
  if (szam=14)and(penz>=200)and(bay=false) then
       begin
         penz:=penz-200;
         bay:=true;
         ujratxt;
       end;
  if (szam=66)then
       begin
         gotoxy(2,21);
         textbackground(red);
         write('give me the magic word!!!!:  ');
         read(s);
         if s='M.A.X.' then cheats;
         ujratxt;
       end;
until upcase(s[1])='X';
setgr($13);
end;

procedure upgrademenu;
begin
kekhatter;
gotoxy(30,2);
writeln('player name:',name);
gotoxy(4,4);
writeln('ammo name          curent               max          cost/one');
gotoxy(4,5);
write('1 speed:');
                        gotoxy(24,5);
                        write(speed);
                                            gotoxy(44,5);
                                            write('10');
                                                             gotoxy(62,5);
                                                             write(sqr(speed*2));
gotoxy(4,6);
write('2 armor:');
                        gotoxy(24,6);
                        write(armor);
                                            gotoxy(43,6);
                                            write('200');
                                                             gotoxy(62,6);
                                                             write(armor*3);
gotoxy(4,7);
writeln('3 life:');
                        gotoxy(24,7);
                        write(life);
                                            gotoxy(42,7);
                                            write('20000');
                                                             gotoxy(62,7);
                                                             write('5');
gotoxy(4,8);
write('4 leserdamage:');
                        gotoxy(24,8);
                        write(ldam);
                                            gotoxy(42,8);
                                            write(' 255');
                                                             gotoxy(62,8);
                                                             write(ldam*2);
gotoxy(4,9);
writeln('5 psychodamage:');
                        gotoxy(24,9);
                        write(psychodam);
                                             gotoxy(43,9);
                                             write('255');
                                                             gotoxy(62,9);
                                                             write(psychodam*2);
gotoxy(4,10);
write('6 nr of max lezers:');
                        gotoxy(24,10);
                        write(mlsz);
                                             gotoxy(43,10);
                                             writeln('200');
                                                             gotoxy(62,10);
                                                             write(mlsz*2);
gotoxy(4,11);
write('8 nr of psychos');
                        gotoxy(24,11);
                        write(psychos);
                                             gotoxy(43,11);
                                             writeln('200');
                                                             gotoxy(62,11);
                                                             write('20');
gotoxy(4,12);
write('9 nr of sonicbombs');
                        gotoxy(24,12);
                        write(abombs);
                                             gotoxy(43,12);
                                             writeln('200');
                                                             gotoxy(62,12);
                                                             write('50');
gotoxy(4,13);
writeln('gun name           curent                cost           accuracy');
gotoxy(4,15);
write('10 electric:         ',bel    ,'               1000            100');
gotoxy(4,16);
write('11 psycho:           ',bpsycho,'               2000             75');
gotoxy(4,17);
writeln('12 ion:              ',bion   ,'               2500             50');
gotoxy(4,18);
write('13 cloak:            ',bcloak ,'               1000            shield');
gotoxy(4,19);
writeln('14 sonicbomb:        ',bbombs ,'               1500            100');{}
end;

procedure menu2;
var point:byte;
    camp,cust,xgame:boolean;
    i:integer;
begin
point:=1;
camp:=false;
cust:=false;
xgame:=false;
while (cust=false)and(camp=false)and(xgame=false) do
   begin
     inc(i);
     clear (pot) ;
     if i mod 90 =0 then inc(szin);
     put_points (i, i ,szin ) ;{}
     if point>3 then point:=1;
     if point<1 then point:=3;
     if point=1 then campaign;
     if point=2 then custom;
     if point=3 then back;
     copyfrom(pot) ;
     if i = 359 then i := 0 ;
     c:=' ';
     if keypressed then c:=readkey;
     if c=#72 then inc(point);
     if c=#80 then dec(point);
     if (c=#13)and(point=1) then camp:=true;
     if (c=#13)and(point=2) then cust:=true;
     if (c=#13)and(point=3) then xgame:=true;
   end;
if cust then menu;
if camp then
  begin
    jatekotinicializal;
    chooseinit;
  end;
if xgame then menu;
end;

procedure menu;
var point:byte;
    ngame,lgame,xgame:boolean;
    i:integer;
begin
point:=1;
ngame:=false;
lgame:=false;
xgame:=false;
while (ngame=false)and(lgame=false)and(xgame=false) do
   begin
     inc(i);
     clear (pot) ;
     if i mod 90 =0 then inc(szin);
     put_points (i, i ,szin ) ;{}
     if point>3 then point:=1;
     if point<1 then point:=3;
     if point=1 then newgame;
     if point=2 then loadgame;
     if point=3 then exitgame;
     copyfrom(pot) ;
     if i = 359 then i := 0 ;
     c:=' ';
     if keypressed then c:=readkey;
     if c=#72 then inc(point);
     if c=#80 then dec(point);
     if (c=#13)and(point=1) then ngame:=true;
     if (c=#13)and(point=2) then lgame:=true;
     if (c=#13)and(point=3) then xgame:=true;
   end;
if ngame then menu2;
if lgame then exitg:=true;
if xgame then exitg:=true;
c:=' ';
end;

procedure langcheck;
begin
if speed=1 then lang1(y,x)
 else if speed=2 then lang2(y,x)
 else if speed=3 then lang3(y,x)
 else if speed=4 then lang4(y,x)
 else if speed=5 then lang5(y,x)
 else if speed>=6 then lang6(y,x);
end;

procedure getal;
begin
getmem(pot, $0ffff) ;
getmem(shipp,420);
getmem(speedyp,231);
getmem(speedy2p,440);
getmem(piratp,546);
getmem(csakanyp,812);
getmem(tankp,760);
getmem(htankp,798);
getmem(bomberp,968);
getmem(hbomberp,855);
getmem(plazmap,748);
getmem(obsp,682);
getmem(pokp,792);
getmem(psycho2p,680);
getmem(psychop,585);
getmem(tuz1p,840);
getmem(tuz2p,630);
getmem(tuz3p,700);
getmem(pot1,$0ffff);
end;

procedure loadal;
begin
loadship(shipp);
loadspeedy(speedyp);
loadspeedy2(speedy2p);
loadpirat(piratp);
loadcsakany(csakanyp);
loadtank(tankp);
loadhtank(htankp);
loadbomber(bomberp);
loadhbomber(hbomberp);
loadplazma(plazmap);
loadobs(obsp);
loadpok(pokp);
loadpsycho2(psycho2p);
loadpsycho(psychop);
loadtuz1(tuz1p);
loadtuz2(tuz2p);
loadtuz3(tuz3p);
end;

procedure freeal;
begin
freemem(pot, $0ffff) ;
freemem(pot1, $0ffff) ;
freemem(shipp,420);
freemem(speedyp,231);
freemem(speedy2p,440);
freemem(piratp,546);
freemem(csakanyp,812);
freemem(tankp,760);
freemem(htankp,798);
freemem(bomberp,968);
freemem(hbomberp,855);
freemem(plazmap,748);
freemem(obsp,682);
freemem(pokp,792);
freemem(psycho2p,680);
freemem(psychop,585);
freemem(tuz1p,840);
freemem(tuz2p,630);
freemem(tuz3p,700);
end;

procedure rendezenemyt;
var zxc:en;
    halottak:byte;
    i,j:integer;
begin
for i:=1 to esz-1 do
 for j:=i+1 to esz do
   begin
     if enem[i].tipe<enem[j].tipe then
         begin
           zxc:=enem[i];
           enem[i]:=enem[j];
           enem[j]:=zxc;
         end;
   end;
halottak:=0;
for i:=1 to esz do if enem[i].tipe=0 then inc(halottak);
esz:=esz-halottak;
end;


procedure initall(x:byte);
var i:byte;
begin
if x=1 then for i:=1 to mesz do initspeedy(esz,@enem)
 else if x=2 then for i:=1 to mesz do initspeedy2(esz,@enem)
 else if x=3 then for i:=1 to mesz do initpirat(esz,@enem)
 else if x=4 then for i:=1 to mesz do initcsakany(esz,@enem)
 else if x=5 then for i:=1 to mesz do inittank(esz,@enem)
 else if x=6 then for i:=1 to mesz do inithtank(esz,@enem)
 else if x=7 then for i:=1 to mesz do initbomber(esz,@enem)
 else if x=8 then for i:=1 to mesz do inithbomber(esz,@enem)
 else if x=9 then for i:=1 to mesz do initplazma(esz,@enem)
 else if x=10 then for i:=1 to mesz do initobs(esz,@enem)
 else if x=11 then for i:=1 to mesz do initpok(esz,@enem);
{esz:=mesz;{}
end;

procedure loadback;
var f:file of byte;
    b:byte;
    p:^byte;
    x,y:word;
begin
clear(pot1);
assign(f,'back.gpi');
reset(f);
p:=pot1;
x:=0;y:=0;
while not(eof(f)) do
 begin
   read(f,b);
   p^:=b;
   inc(p);
{   if y=320 then inc(x);
   y:=y mod 320;
   putpixel(y,x,b);
   put_pixel(y,x,b);
   inc(y);{}
   inc(x);
   if x mod 200 = 0 then putpixel(x div 200,70,piros);{}
 end;
close(f);
end;

procedure initlezer;
var tipe:byte;
begin
if ldam<20 then tipe:=0
 else tipe:=3;
if (mlsz-lsz>=2) then
  begin
    inc(lsz);
    ge[lsz].x:=x;
    ge[lsz].y:=y;
    ge[lsz].t:=2+tipe;
    inc(lsz);
    ge[lsz].x:=x;
    ge[lsz].y:=y;
    ge[lsz].t:=3+tipe;
  end;
if (mlsz-lsz>=1) then
  begin
    inc(lsz);
    if ldam<30 then ge[lsz].t:=1+tipe
      else ge[lsz].t:=7;
    ge[lsz].x:=x;
    ge[lsz].y:=y;
  end;
end;

procedure lezer;
var e,i,j:byte;
    gc:gen;
begin
if lsz=0 then exit;
e:=0;j:=0;
fillchar(gc,mg,0);
for i:=1 to lsz do
 if(ge[i].x>minsor)and(ge[i].x<msor)and(ge[i].y<maxosz)and(ge[i].y>minosz)and(ge[i].t<>0) then
   begin
     inc(j);
     gc[j]:=ge[i];
   end;
fillchar(ge,mg,0);
ge:=gc;
lsz:=j;
end;

procedure initpsycho(y,x:integer;t,p:byte);
begin
if (t=1)and(lsz<mlsz) then
           begin
              inc(lsz);
              ge[lsz].x:=x;
              ge[lsz].y:=y;
              dec(psychos);
              if psychodam<mpsychodam div 2 then ge[lsz].t:=8
                  else ge[lsz].t:=9;
            end
 else if t=2 then
           begin
              inc(elsz);
              go[elsz].x:=x;
              go[elsz].y:=y;
              if p=1 then go[elsz].t:=8
                  else go[elsz].t:=9;
            end;
end;

procedure enemyshoot(y1,x1:integer;t:byte);
var i:byte;
begin
if elsz>=melsz then exit;
inc(elsz);
if t=1 then
  begin
    go[elsz].x:=X1;
    go[elsz].y:=y1;
    go[elsz].t:=1;
  end
 else if t=2 then
  begin
    go[elsz].x:=X1+5;
    go[elsz].y:=y1-15;
    go[elsz].t:=1;
    inc(elsz);
    go[elsz].x:=X1+5;
    go[elsz].y:=y1+15;
    go[elsz].t:=1;
    inc(elsz);
    go[elsz].x:=X1+5;
    go[elsz].y:=y1-15;
    go[elsz].t:=2;
    inc(elsz);
    go[elsz].x:=X1+5;
    go[elsz].y:=y1+15;
    go[elsz].t:=3;
  end
 else if t=3 then
  begin
    go[elsz].x:=X1;
    go[elsz].y:=y1;
    go[elsz].t:=1;
    inc(elsz);
    go[elsz].x:=X1+5;
    go[elsz].y:=y1;
    go[elsz].t:=1;
    inc(elsz);
    go[elsz].x:=X1+10;
    go[elsz].y:=y1;
    go[elsz].t:=1;
  end
 else if t=4 then
  begin
    if point mod 5=0 then
       begin
         go[elsz].x:=X1+3;
         go[elsz].y:=y1;
         go[elsz].t:=1;
       end
      else
       if (point mod 4=0)and(kosz<10) then
         begin
           inc(kosz);
           ko[kosz].x:=X1+10;
           ko[kosz].y:=y1;
           ko[kosz].t:=3;
         end
      else
       if (point mod 3=0)and(kosz<10) then
         begin
           inc(kosz);
           ko[kosz].x:=X1+10;
           ko[kosz].y:=y1;
           ko[kosz].t:=2;
         end
      else
       if (point mod 2=0)and(kosz<10) then
         begin
           inc(kosz);
           ko[kosz].x:=X1+10;
           ko[kosz].y:=y1;
           ko[kosz].t:=1;
         end;
  end
 else if t=5 then
  begin
    go[elsz].x:=X1;
    go[elsz].y:=y1-10;
    go[elsz].t:=7;
    inc(elsz);
    go[elsz].x:=X1;
    go[elsz].y:=y1+20;
    go[elsz].t:=7;
    inc(elsz);
    go[elsz].x:=X1;
    go[elsz].y:=y1-10;
    go[elsz].t:=5;
    inc(elsz);
    go[elsz].x:=X1;
    go[elsz].y:=y1+20;
    go[elsz].t:=6;
  end
 else if t=7 then initpsycho(y1,x1,2,1)
 else if t=8 then initpsycho(y1,X1,2,2)
 else if t=9 then
  begin
    go[elsz].x:=X1;
    go[elsz].y:=y1-10;
    go[elsz].t:=4;
    inc(elsz);
    go[elsz].x:=X1;
    go[elsz].y:=y1+10;
    go[elsz].t:=4;
    inc(elsz);
    go[elsz].x:=X1;
    go[elsz].y:=y1+3;
    go[elsz].t:=5;
    inc(elsz);
    go[elsz].x:=X1;
    go[elsz].y:=y1+3;
    go[elsz].t:=6;
  end
 else if t=10 then
  begin
    go[elsz].x:=X1;
    go[elsz].y:=y1;
    go[elsz].t:=14;
  end
 else if t=11 then
  begin
    i:=esz-random(esz);
    if enem[i].life<255 then enem[i].life:=enem[i].life+1;
  end;
end;

procedure lepik(irany,i:byte);
begin
  if (irany=1)and(enem[i].x>minsor) then dec(enem[i].x)
   else if (irany=2)and(enem[i].y<maxosz) then inc(enem[i].y)
   else if (irany=3)and(enem[i].x<maxsor) then inc(enem[i].x)
   else if (irany=4)and(enem[i].y>minosz) then dec(enem[i].y)
   else if irany=5 then
       begin
         if enem[i].y<maxosz then inc(enem[i].y);
         if enem[i].x>minsor then dec(enem[i].x);
        end
   else if irany=6 then
        begin
          if enem[i].y<maxosz then inc(enem[i].y);
          if enem[i].x<maxsor then inc(enem[i].x);
        end
   else if irany=7 then
        begin
          if enem[i].x<maxsor then inc(enem[i].x);
          if enem[i].y>minosz then  dec(enem[i].y);
        end
   else if irany=8 then
        begin
          if enem[i].y>minosz then dec(enem[i].y);
          if enem[i].x>minsor then dec(enem[i].x);
                   end
   else if irany=9 then ;
end;

procedure askenemy;
var i,volt:byte;
begin
if esz=0 then exit;
for i:=1 to esz do
   begin
     volt:=enem[i].irany;
     if enem[i].at=enem[i].szor then
           begin
             while enem[i].szor<2 do enem[i].szor:=random(50);
             enem[i].at:=0;
             if enem[i].tipe=1 then while (enem[i].irany<1)or(volt=enem[i].irany) do enem[i].irany:=random(9)
               else while (enem[i].irany<1)or(volt=enem[i].irany) do enem[i].irany:=random(10);
           end;
     if enem[i].at<enem[i].szor then
           begin
             if (enem[i].tipe=1)or(enem[i].tipe=2) then
                begin
                  lepik(enem[i].irany,i);
                  lepik(enem[i].irany,i);
                end
              else lepik(enem[i].irany,i);{}
{             lepik(enem[i].irany,i);{}
             dec(enem[i].szor);
             if (enem[i].tipe=6)and(abs(enem[i].x-x)<=100)and(abs(enem[i].y-y)<=50)and(inv=false) then
               begin
                 line2(enem[i].y+2,enem[i].x+8,y,x,feher);
                 line2(enem[i].y-2,enem[i].x+8,y,x,feher);
                 if point mod 2 = 0 then life:=life-1;
               end;{}
             if enem[i].szor mod elgyak =0 then enemyshoot(enem[i].y,enem[i].x,enem[i].tipe);{}
           end;
     end;
end;

procedure elezer;
var e,i,j:byte;
    gc:gen;
begin
if elsz=0 then exit;
e:=0;j:=0;
fillchar(gc,mg,0);
for i:=1 to elsz do
 if(go[i].x>minsor)and(go[i].x<msor)and(go[i].y<maxosz)and(go[i].y>minosz)and(go[i].t<>0) then
   begin
     inc(j);
     gc[j]:=go[i];
   end;
fillchar(go,mg,0);
go:=gc;
elsz:=j;
end;

procedure golyok(y1,x1:integer;t,szin:byte);
begin
 if t=1 then
  begin
    put_pixel(y1,x1,szin);
    put_pixel(y1,x1+1,szin);
  end
 else if t=2 then
  begin
    put_pixel(y1,x1,szin);
    put_pixel(y1-1,x1+1,szin);
  end
 else if t=3 then
  begin
    put_pixel(y1,x1,szin);
    put_pixel(y1+1,x1+1,szin);
  end
 else if (t=4)or(t=5)or(t=6) then
  begin
    put_pixel(y1,x1,piros);
    put_pixel(y1-1,x1,zold);
    put_pixel(y1+1,x1,zold);
    put_pixel(y1,x1-1,zold);
    put_pixel(y1,x1+1,zold);
    put_pixel(y1-1,x1-1,zold+7);
    put_pixel(y1-1,x1+1,zold+7);
    put_pixel(y1+1,x1+1,zold+7);
    put_pixel(y1+1,x1-1,zold+7);
   end
  else if t=7 then
   begin
     put_pixel(y1,x1+1,lila);
     put_pixel(y1,x1-1,lila);
     put_pixel(y1-1,x1,lila);
     put_pixel(y1+1,x1,lila);
   end
  else if t=8 then kepkirako(psychop,y1,x1,45,13)
  else if t=9 then kepkirako(psycho2p,y1,x1,40,17)
  else if (t<15)and(t>9) then
        begin
          line2(y1-4,x1,y1-4,190,piros);
          line2(y1-3,x1,y1-3,190,lila);
          line2(y1-2,x1,y1-2,190,sarga);
          line2(y1-1,x1,y1-1,190,zold);
          line2(y1,x1,y1,190,kek);
          line2(y1+1,x1,y1+1,190,zold);
          line2(y1+2,x1,y1+2,190,sarga);
          line2(y1+3,x1,y1+3,190,lila);
          line2(y1+4,x1,y1+4,190,piros);
        end;{}
end;

procedure movelezer;
var i:byte;
begin
if lsz=0 then exit;
if lsz>mlsz then lsz:=mlsz;
for i:=1 to lsz do
  begin
    if (ge[i].t=1)or(ge[i].t=4)or(ge[i].t=7)then ge[i].x:=ge[i].x-lspeed
    else if (ge[i].t=2)or(ge[i].t=5)then
       begin
         ge[i].x:=ge[i].x-lspeed;
         if point mod 2=0 then ge[i].y:=ge[i].y+lspeed;
       end
    else if (ge[i].t=3)or(ge[i].t=6) then
       begin
         ge[i].x:=ge[i].x-lspeed;
         if point mod 2=0 then ge[i].y:=ge[i].y-lspeed;
       end
    else if (ge[i].t=8)or(ge[i].t=9) then
       begin
         ge[i].x:=ge[i].x-1;
         if ge[i].y<enem[1].y then ge[i].y:=ge[i].y+1
          else if ge[i].y>enem[1].y then ge[i].y:=ge[i].y-1;
       end
    else if (ge[i].t<15)and(ge[i].t>9) then
        begin
          dec(ge[i].t);
          if ge[i].t=9 then ge[i].t:=0;
        end;
    golyok(ge[i].y,ge[i].x,ge[i].t,lszin);
  end;
lezer;
end;

procedure moveelezer;
var i:byte;
begin
if elsz=0 then exit;
for i:=1 to elsz do
  begin
    if (go[i].t=1)or(go[i].t=4)or(go[i].t=7)then go[i].x:=go[i].x+elspeed+1
    else if (go[i].t=2)or(go[i].t=5)then
       begin
         go[i].x:=go[i].x+elspeed+1;
         if point mod 2=0 then go[i].y:=go[i].y+elspeed+1;
       end
    else if (go[i].t=3)or(go[i].t=6) then
       begin
         go[i].x:=go[i].x+elspeed+1;
         if point mod 2=0 then go[i].y:=go[i].y-elspeed-1;
       end
    else if (go[i].t=8)or(go[i].t=9) then
       begin
         go[i].x:=go[i].x+1;
         if go[i].y<y then go[i].y:=go[i].y+1;
         if go[i].y>y then go[i].y:=go[i].y-1;
       end
    else if (go[i].t<15)and(go[i].t>9) then
        begin
          dec(go[i].t);
          if go[i].t=9 then go[i].t:=0;
        end;
    golyok(go[i].y,go[i].x,go[i].t,elszin);{}
  end;
elezer;
end;

procedure enemyhit;
var dam,de,rad2,i,j,sz,h,armor,life:integer;
    le:boolean;
begin
 le:=false;
 for i:=1 to lsz do
  for j:=1 to esz do
    begin
      if (ge[i].t=8)or(ge[i].t=9) then rad2:=rad+3
        else rad2:=rad;
      if (abs(enem[j].y-ge[i].y)<=rad)and(abs(enem[j].x-ge[i].x)<=rad){} then
{      if (enem[j].y+rad2>=ge[i].y)and(enem[j].y-rad2<=ge[i].y)and
         (enem[j].x+rad2>=ge[i].x)and(enem[j].x-rad2<=ge[i].x) then{}
           begin
             le:=true;
             if enem[j].tipe=1 then armor:=sshield
              else if enem[j].tipe=2 then armor:=s2shield
              else if enem[j].tipe=3 then armor:=pshield
              else if enem[j].tipe=4 then armor:=csshield
              else if enem[j].tipe=5 then armor:=tshield
              else if enem[j].tipe=6 then armor:=htshield
              else if enem[j].tipe=7 then armor:=bshield
              else if enem[j].tipe=8 then armor:=hbshield
              else if enem[j].tipe=9 then armor:=plshield
              else if enem[j].tipe=10 then armor:=oshield
              else if enem[j].tipe=11 then armor:=poshield;
             armor:=armor+earmor;
             if (ge[i].t=1)or(ge[i].t=2)or(ge[i].t=3)then dam:=ldam
              else if (ge[i].t=4)or(ge[i].t=5)or(ge[i].t=6)then dam:=ldam+5
              else if (ge[i].t=7)then dam:=ldam+10
              else if (ge[i].t=8)or(ge[i].t=9)then dam:=psychodam
              else if (ge[i].t=10)then dam:=ldam*2;
             ge[i].t:=0;
             de:=dam-armor;
             if de<=0 then de:=1;
             life:=enem[j].life-de;
             if life<=0 then
                begin
                  penz:=enem[j].tipe+penz+random(10);
                  enem[j].tipe:=254;
                  inc(score,10);
                end
               else enem[j].life:=life;
      end;
    end;
if le then lezer;
end;

procedure ehit;
var dam,de,rad2,i,j,sz,h:integer;
    le:boolean;
begin
 if inv then exit;
 le:=false;
 for i:=1 to elsz do
    begin
      if (go[i].t=8)or(go[i].t=9) then rad2:=erad+3
        else rad2:=erad;
      if (y+rad2>go[i].y)and(y-rad2<go[i].y)then
        if (x+rad2>go[i].x)and(x-rad2<go[i].x) then
           begin
             le:=true;
             if (go[i].t=1)or(go[i].t=2)or(go[i].t=3)then dam:=eldam
              else if (go[i].t=4)or(go[i].t=5)or(go[i].t=6)then dam:=eldam+5
              else if (go[i].t=7)then dam:=eldam+10
              else if (go[i].t=8)then dam:=epsychodam
              else if (go[i].t=9)then dam:=epsychodam+10
              else if (go[i].t=10)then dam:=eldam*2;
             go[i].t:=0;
             de:=dam-armor;
             if de<=0 then de:=1;
             life:=life-de;
             if life<=0 then exitg:=true;
      end;
    end;
if le then elezer;
end;

procedure enemyki;
var i:integer;
    bo:boolean;
begin
bo:=false;
for i:=1 to esz do
     begin
       if enem[i].tipe=1 then kepkirako(speedyp,enem[i].y-10,enem[i].x-5,21,11)
        else if enem[i].tipe=2 then kepkirako(speedy2p,enem[i].y-20,enem[i].x-5,40,11)
        else if enem[i].tipe=3 then kepkirako(piratp,enem[i].y-21,enem[i].x-6,42,13)
        else if enem[i].tipe=4 then kepkirako(csakanyp,enem[i].y-14,enem[i].x-14,28,29)
        else if enem[i].tipe=5 then kepkirako(tankp,enem[i].y-9,enem[i].x-9,40,19)
        else if enem[i].tipe=6 then kepkirako(htankp,enem[i].y-19,enem[i].x-10,38,21)
        else if enem[i].tipe=7 then kepkirako(bomberp,enem[i].y-22,enem[i].x-11,44,22)
        else if enem[i].tipe=8 then kepkirako(hbomberp,enem[i].y-22,enem[i].x-9,45,19)
        else if enem[i].tipe=9 then kepkirako(plazmap,enem[i].y-17,enem[i].x-11,34,22)
        else if enem[i].tipe=10 then kepkirako(obsp,enem[i].y-15,enem[i].x-11,31,22)
        else if enem[i].tipe=11 then kepkirako(pokp,enem[i].y-16,enem[i].x-12,33,24);{}
       if (enem[i].tipe>240)then
            begin
              if (enem[i].tipe<=254)and(enem[i].tipe>=250)then tuz2(enem[i].y,enem[i].x,tuz2p);
              if (enem[i].tipe<250)or(enem[i].tipe>=245)or(enem[i].tipe=249) then tuz1(enem[i].y,enem[i].x,tuz1p)
                else tuz3(enem[i].y,enem[i].x,tuz3p);
              enem[i].tipe:=enem[i].tipe-1;
              if enem[i].tipe=250 then
                 begin
                   bo:=true;
                   enem[i].tipe:=0;
                 end;
            end;
     end;
if bo then rendezenemyt;
end;

procedure chooseinit;
var resz:integer;
begin
if(level=1)then
 initspeedy(esz,@enem){}
else if(level=2)then
 initspeedy2(esz,@enem){}
else if(level=3)then
 initspeedy2(esz,@enem){}
else if(level=4)then
 initpirat(esz,@enem){}
else if(level=5)then
 initcsakany(esz,@enem){}
else if(level=6)then
 inittank(esz,@enem){}
else if(level=7)then
 inithtank(esz,@enem){}
else if(level=8)then
 initbomber(esz,@enem){}
else if(level=9)then
 inithbomber(esz,@enem){}
else if(level=10)then
 initplazma(esz,@enem){}
else if(level=11)then
 initobs(esz,@enem){}
else if(level=12)then
 initpok(esz,@enem){}
 else initenemy(esz,@enem);{}
if(esz<mesz)then esz:=esz+1;
level:=level+1;

{initenemy(esz,@enem);{}
{initspeedy(esz,@enem);{}
{initspeedy2(esz,@enem);{}
{initpirat(esz,@enem);{}
{initcsakany(esz,@enem);{}
{inittank(esz,@enem);{}
{inithtank(esz,@enem);{}
{initbomber(esz,@enem);{}
{inithbomber(esz,@enem);{}
{initplazma(esz,@enem);{}
{initobs(esz,@enem);{}
{initpok(esz,@enem);{}
{initall(1);{}
{initall(2);{}
{initall(3);{}
{initall(4);{}
{initall(5);{}
{initall(6);{}
{initall(7);{}
{initall(8);{}
{initall(9);{}
{initall(10);{}
{initall(11);{}
end;

procedure elektrik;
var i:byte;
begin
 for i:=1 to esz do
   if (abs(x-enem[i].x)<90)and(abs(y-enem[i].y)<40) then
       begin
         line2(y+14,x,enem[i].y,enem[i].x,feher);
         line2(y-14,x,enem[i].y,enem[i].x,feher);
         if enem[i].life<=5 then enem[i].tipe:=254
           else begin
                  dec(enem[i].life);
                  dec(energy);
               end;
       end;
end;

procedure ciklus;
begin
    inc(point);
    if point=360 then
      begin
        point:=1;
        inc(szin);
      end;{}
    delay(delay1);
    enemyhit;
    ehit;
    if esz=0 then chooseinit;
    movelezer;
    moveelezer;
    if inv then
      begin
        shieldr(y,x);
        if energy>0 then dec(energy)
          else inv:=false;
      end;
    lifebar(life);
    ship(y,x,shipp);
    askenemy;
    enemyki;
    langcheck;
    copyfrom(pot);{}
    c:=' ';
    if keypressed then
         begin
           c:=readkey;
           inv:=false;
         end;
    copyfrom2(pot,pot1);{}
end;

procedure ion(ik:byte);
var i:byte;
begin
  for i:=1 to esz do
    if abs(enem[i].y-y)<=rad then
       begin
         line2(y-4,x,y,1,piros);
         line2(y-3,x,y,1,lila);
         line2(y-2,x,y,1,sarga);
         line2(y-1,x,y,1,zold);
         line2(y,x,y,1,kek);
         line2(y+1,x,y,1,zold);
         line2(y+2,x,y,1,sarga);
         line2(y+3,x,y,1,lila);
         line2(y+4,x,y,1,piros);
         if enem[i].life<=200 then
             begin
               enem[i].tipe:=254;
               penz:=penz+enem[i].tipe+random(10);
               inc(score,10);
             end
            else enem[i].life:=enem[i].life-200;
         dec(energy,100);
       end;
if ik<30 then
  begin
    ciklus;
    ion(ik+1);
  end;
end;

procedure bombs;
var i:byte;
begin
  for i:=1 to esz do
    begin
      if enem[i].life-50<0 then
        begin
          penz:=penz+enem[i].tipe+random(10);
          enem[i].tipe:=254;
          inc(score,10);
        end
         else enem[i].life:=enem[i].life-50;
      dec(abombs);
    end;
end;

{kek,piros,sarga,zold,lila}
{***************************foprogram********************}
begin
setGr($13);
getfont;
outtext2('loading',100,50,9,0,1);
randomize;
generate_stars( -400, 400, -400, 400, -400, 400, 70 ) ;{}
getal;
loadal;
loadback;
szin:=20;
menu;{}
freemem(first, leng * sizeof(point)) ;
if exitg=true then exit;{}
jatekotinicializal;
{cheats;{}
chooseinit;
while (c<>#27)and(exitg=false) do
  begin
    if (c=fel)and(x>17) then x:=x-speed
     else if (c=le)and(x<183) then x:=x+speed
     else if (c=job)and(y<303) then y:=y+speed
     else if (c=bal)and(y>17) then y:=y-speed
     else if (c='+')and(delay1<255) then inc(delay1)
     else if (c='-')and(delay1>0) then dec(delay1)
     else if (port[$60]=29)and(lsz<mlsz) then
      begin
        if (pfegyver=1)then initlezer
         else if (pfegyver=2)and(energy>0)and(bel)then elektrik
         else if (pfegyver=3)and(psychos>0)and(bpsycho)then
              begin
                initpsycho(y,x,1,1);
                port[$60]:=157;
              end
         else if (pfegyver=4)and(energy>50)and(bion)then ion(1)
         else if (pfegyver=5)and(energy>0)and(bcloak)then inv:=true
         else if (pfegyver=6)and(abombs>0)and(bbombs)then bombs;
      end
     else if (port[$60]=56)and(lsz<mlsz) then
      begin
        if (sfegyver=1) then initlezer
         else if (sfegyver=2)and(energy>0)and(bel)then elektrik
         else if (sfegyver=3)and(psychos>0)and(bpsycho)then
              begin
                initpsycho(y,x,1,1);
                port[$60]:=184;
              end
         else if (sfegyver=4)and(energy>50)and(bion)then ion(1)
         else if (sfegyver=5)and(energy>0)and(bcloak)then inv:=true
         else if (sfegyver=6)and(abombs>0)and(bbombs)then bombs;
      end
     else if (c='1')or(c='2')or(c='3')or(c='4')or(c='5')or(c='6')then pfegyver:=ord(c)-48
     else if (port[$60]>0)and(port[$60]<7) then sfegyver:=port[$60];
    if (c=f2)then buy;
    if exitg=true then break;
    ciklus;
   end;{}
setGr($03);
freeal;
nosound;
writeLn('Thanx for playing...') ;
end.