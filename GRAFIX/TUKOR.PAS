program haromszogben;
uses crt,graph;
const msor=470; mosz=640; kis=10;
var z,i,j:integer;

procedure haromszog2(csy,csx,d,d2:integer);forward;


procedure haromszog1(csy,csx,d,d2:integer);
{d=magasag,d2=feloldalhossz}
begin
  line(csy,csx,csy+d2,csx+d);
  line(csy,csx,csy-d2,csx+d);
  line(csy-d2,csx+d,csy+d2,csx+d);
  if (d>kis) then
    begin
      haromszog1(csy,csx+d div 2,d div 4,d2 div 4);{}
      haromszog1(csy,csx+2*(d div 8),d div 8,d2 div 8);{}
      haromszog1(csy-4*(csy div 8),csx+6*(d div 8),d div 8,d2 div 8);{}
      haromszog1(csy+4*(csy div 8),csx+6*(d div 8),d div 8,d2 div 8);{}
      haromszog2(csy-csy div 2,csx,d div 2,d2 div 2);{}
      haromszog2(csy+csy div 2,csx,d div 2,d2 div 2);{}
      haromszog2(csy,csx-d,d div 2,d2 div 2);{}
    end;
end;

procedure haromszog2(csy,csx,d,d2:integer);
{d=magasag,d2=feloldalhossz,}
begin
  line(csy,csx,csy+d2,csx-d);
  line(csy,csx,csy-d2,csx-d);
  line(csy-d2,csx-d,csy+d2,csx-d);
  if (d>kis) then
    begin
      haromszog2(csy-csy div 2,csx,d div 2,d2 div 2);{}
      haromszog2(csy+csy div 2,csx,d div 2,d2 div 2);{}
      haromszog2(csy,csx-d,d div 2,d2 div 2);{}
      haromszog1(csy,csx+2*(d div 8),d div 8,d2 div 8);{}
      haromszog1(csy-4*(csy div 8),csx+6*(d div 8),d div 8,d2 div 8);{}
      haromszog1(csy+4*(csy div 8),csx+6*(d div 8),d div 8,d2 div 8);{}
    end;
end;

procedure haromszog(csy,csx,d,d2,f:integer);
{d=magasag,d2=feloldalhossz,f csucshelyzet}
begin
  if f=0 then
    begin
      line(csy,csx,csy+d2,csx+d);
      line(csy,csx,csy-d2,csx+d);
      line(csy-d2,csx+d,csy+d2,csx+d);
    end;
  if f=1 then
    begin
      line(csy,csx,csy+d2,csx-d);
      line(csy,csx,csy-d2,csx-d);
      line(csy-d2,csx-d,csy+d2,csx-d);
    end;
  if (f=0)and(d>kis) then
    begin
      haromszog(csy,csx+d,d div 2,d2 div 2,1);{}
     if csx>1 then haromszog(csy div 2,csx+2*d,d,d2,1);{fent}
     if csy>1 then haromszog(csy,csx,d,d2,1);{bal lent}
     if csy<mosz then haromszog(csy+ csy div 2,csx+2*d,d,d2,1);{jobb lent}
    end;
  if (f=1)and(d>kis) then
    begin
      haromszog(csy,csx-d,d div 2,d2 div 2,0);{}
      if csx+d<msor then haromszog(csy,csx,d,d2,0);{lent}
{      if csy<msor then haromszog(csy+csy div 4,csx,d,d2,1);{jobb}
{      if csy-d>1 then haromszog(csy+ csy div 2,csx+2*d,d,d2,1);{}
    end;
end;

begin
i:=detect;
initgraph(i,j,'c:\programs\pascal\bin\bgi');
haromszog1(mosz div 2,1,msor,mosz div 2);{}
haromszog2(mosz div 2,msor,msor div 2,mosz div 4);{}
readkey;
closegraph;
end.