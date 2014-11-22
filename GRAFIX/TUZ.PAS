program tuztext;
uses crt;
var i:integer;

procedure kar;
const sor=25;
var gy,r,j:integer;
begin
r:=random(25);
gy:=1;
for i:=2 to 80*sor do
   begin
     if random(80*sor)mod gy=0 then
            begin
              gotoxy(80-i mod 80,23-i div 80);
              if random(3)=1 then textbackground(red)
               else if random(3)=2 then textbackground(lightred)
                  else textbackground(yellow);
              if (23-i div 80<6)and(random(5)=4)then textbackground(black);
              if (23-i div 80<8)and(random(5)=3)then textbackground(black);
              if (23-i div 80<10)and(random(5)=2)then textbackground(black);
              if (23-i div 80<12)and(random(5)=1)then textbackground(black);
              if (23-i div 80<14)and(random(5)=0)then textbackground(black);
              if (23-i div 80<16)and(random(3)=2)then textbackground(black);
              if (23-i div 80<18)and(random(2)=1)then textbackground(black);
              if (23-i div 80<20)and(random(2)=1)then textbackground(black);
              if (23-i div 80<22)and(random(2)=0)then textbackground(black);
              write(' ');
            end;
     inc(gy);
   end;
end;

begin
randomize;
repeat
textbackground(black);
clrscr;
kar;
for i:=1 to 10 do kar;{}
until keypressed;
end.