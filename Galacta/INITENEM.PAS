unit initenem;
interface
uses graph2;
type kor=record
          x,y:integer;
        end;
     en=record
          x,y:integer;
          life,irany,szor,at,tipe:byte;
        end;
     en1=array[1..50]of en;
     enptr=^en1;

procedure initspeedy(var esz:byte;enp:enptr);
procedure initspeedy2(var esz:byte;enp:enptr);
procedure initpirat(var esz:byte;enp:enptr);
procedure initcsakany(var esz:byte;enp:enptr);
procedure inittank(var esz:byte;enp:enptr);
procedure inithtank(var esz:byte;enp:enptr);
procedure initbomber(var esz:byte;enp:enptr);
procedure inithbomber(var esz:byte;enp:enptr);
procedure initplazma(var esz:byte;enp:enptr);
procedure initobs(var esz:byte;enp:enptr);
procedure initpok(var esz:byte;enp:enptr);
procedure initenemy(var esz:byte;enp:enptr);

implementation

procedure initspeedy(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30+random(10);
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=1;
enp^[esz].life:=15;
{enp^[esz].sz:=2;
enp^[esz].h:=1;
enp^[esz].shield:=0;}
end;

procedure initspeedy2(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30+random(10);
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=2;
enp^[esz].life:=30;
{enp^[esz].sz:=2;
enp^[esz].h:=1;
enp^[esz].shield:=0;}
end;

procedure initpirat(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30+random(10);
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=3;
enp^[esz].life:=50;
{enp^[esz].sz:=3;
enp^[esz].h:=2;
enp^[esz].shield:=1;}
end;

procedure initcsakany(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30+random(10);
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=4;
enp^[esz].life:=100;
{enp^[esz].sz:=2;
enp^[esz].h:=1;
enp^[esz].shield:=0;}
end;

procedure inittank(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30+random(10);
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=5;
enp^[esz].life:=150;
{enp^[esz].sz:=4;
enp^[esz].h:=4;
enp^[esz].shield:=7;}
end;

procedure inithtank(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30+random(10);
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=6;
enp^[esz].life:=200;
{enp^[esz].sz:=4;
enp^[esz].h:=4;
enp^[esz].shield:=7;}
end;

procedure initbomber(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30+random(10);
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=7;
enp^[esz].life:=200;
{enp^[esz].h:=4;
enp^[esz].sz:=6;
enp^[esz].shield:=6;}
end;

procedure inithbomber(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30;
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=8;
enp^[esz].life:=200;
{enp^[esz].h:=4;
enp^[esz].sz:=6;
enp^[esz].shield:=6;}
end;

procedure initplazma(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30;
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=9;
enp^[esz].life:=255;
{enp^[esz].sz:=2;
enp^[esz].h:=1;
enp^[esz].shield:=0;}
end;

procedure initobs(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30;
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=10;
enp^[esz].life:=200;
{enp^[esz].sz:=2;
enp^[esz].h:=1;
enp^[esz].shield:=0;}
end;

procedure initpok(var esz:byte;enp:enptr);
begin
inc(esz);
enp^[esz].x:=30;
enp^[esz].y:=random(160)*2;
enp^[esz].tipe:=11;
enp^[esz].life:=100;
{enp^[esz].sz:=2;
enp^[esz].h:=1;
enp^[esz].shield:=0;}
end;

procedure initenemy(var esz:byte;enp:enptr);
begin
esz:=11;
enp^[1].x:=30;
enp^[1].y:=10;
enp^[1].tipe:=1;
enp^[1].life:=15;
enp^[2].x:=30;
enp^[2].y:=40;
enp^[2].tipe:=2;
enp^[2].life:=30;
enp^[3].x:=30;
enp^[3].y:=60;
enp^[3].tipe:=3;
enp^[3].life:=50;
enp^[4].x:=30;
enp^[4].y:=80;
enp^[4].tipe:=4;
enp^[4].life:=100;
enp^[5].x:=30;
enp^[5].y:=100;
enp^[5].tipe:=5;
enp^[5].life:=150;
enp^[6].x:=30;
enp^[6].y:=120;
enp^[6].tipe:=6;
enp^[6].life:=200;
enp^[7].x:=30;
enp^[7].y:=140;
enp^[7].tipe:=7;
enp^[7].life:=200;
enp^[8].x:=30;
enp^[8].y:=160;
enp^[8].tipe:=8;
enp^[8].life:=200;
enp^[9].x:=30;
enp^[9].y:=180;
enp^[9].tipe:=9;
enp^[9].life:=250;
enp^[10].x:=30;
enp^[10].y:=200;
enp^[10].tipe:=10;
enp^[10].life:=200;
enp^[11].x:=30;
enp^[11].y:=220;
enp^[11].tipe:=11;
enp^[11].life:=100;
end;

end.