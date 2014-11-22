program kod;
uses graph,crt;
const hossz=50; tav=2;
type kor=record
          x,y:integer;
         end;
     stiva=array[0..100]of kor;
var z,i,j,vx,vy,r,k:integer;
    tar:stiva;

procedure mozgat;
begin
for i:=2 to hossz do
    begin
      if (random(20)=10)and(tar[i-1].x-tar[i].x<=tav) then dec(tar[i].x)
          else if (random(20)=10)and(tar[i-1].x-tar[i].x<=tav) then inc(tar[i].x);
{      if (random(20)=10)and(abs(tar[i-1].y-tar[i].y)<=tav) then dec(tar[i].y);}
      if (random(20)=10)and(abs(tar[i-1].x-tar[i].y)<=tav) then dec(tar[i].x);
    end;
end;

procedure feltolt;
begin
for i:=1 to hossz do
  begin
    tar[i].x:=240;
    tar[i].y:=i*10+100;
  end;
end;

procedure kiir;
begin
setcolor(red);
for i:=1 to hossz-1 do line(tar[i].y,tar[i].x,tar[i+1].y,tar[i+1].x);
end;

begin
randomize;
i:=detect;
initgraph(i,j,' ');
feltolt;
repeat
mozgat;
cleardevice;
kiir;
delay(10);
until keypressed;
readln;
closegraph;
end.