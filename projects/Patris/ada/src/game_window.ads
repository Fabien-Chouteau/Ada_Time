with Interfaces.C; use Interfaces.C;
with Pebble.Graphics; use Pebble.Graphics;
package Game_Window is

   Font_Txt       : aliased char_array := "RESOURCE_ID_GOTHIC_14_BOLD" &
     char (ASCII.NUL);
   Corners_Radius : constant := 7;
   Frames_Color   : constant Gcolor := Colors.Blue;
   Version_Txt    : aliased char_array := "v1.2" & char (ASCII.NUL);

   procedure Push;

end Game_Window;
