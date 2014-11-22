program vizualpage;
uses crt,graph;
var Gd, Gm: Integer;
begin
 Gd := Detect;
 InitGraph(Gd, Gm, 'c:\programs\pascal\bgi');
 if GraphResult <> grOk then
   Halt(1);
 if (Gd = HercMono) or (Gd = EGA) or (Gd = EGA64) or (Gd = VGA) then
 begin
   SetVisualPage(0);
   SetActivePage(1);
   Rectangle(240, 320, 300, 400);
   readkey;
   SetVisualPage(1);
   readkey;
   setvisualpage(0);
 end
 else
   OutText('No paging supported.');
 CloseGraph;
end.
