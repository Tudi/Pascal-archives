unit soundot;
interface
uses crt;
procedure lezersound(bol:boolean);
procedure crashsound(bol:boolean);
procedure elezersound(bol:boolean);
procedure psychosound(bol:boolean);

implementation

procedure elezersound(bol:boolean);
var i:integer;
begin
if bol=false then exit;
for i:=500 downto 1 do if i mod 5 =0 then
   begin
     sound(I);
     if i<50 then sound(1);
     delay(1);
   end;
nosound;
end;

procedure lezersound(bol:boolean);
var i:integer;
begin
if bol=false then exit;
for i:=1000 downto 19 do if i mod 20=0 then
   begin
     sound(i);
     delay(1);
   end;
nosound;
end;

procedure crashsound(bol:boolean);
var i:integer;
begin
if bol=false then exit;
for i:=100 downto 40 do
   begin
     sound(i);
     delay(1);
   end;
nosound;
end;

procedure psychosound(bol:boolean);
begin
if bol=false then exit;
sound(2000);
delay(10);
sound(500);
delay(10);
sound(100);
delay(10);
nosound
end;

end.
