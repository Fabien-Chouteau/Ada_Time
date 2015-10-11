with Main_Window; use Main_Window;
with Pebble; use Pebble;

procedure Main is
begin
   Main_Window.Init;

   Pebble.App_Event_Loop;

   Main_Window.Deinit;
end Main;
