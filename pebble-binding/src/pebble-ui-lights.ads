package Pebble.Ui.Lights is
   procedure Enable_Interaction;  -- pebble.h:6565
   pragma Import (C, Enable_Interaction, "light_enable_interaction");

   procedure Enable (Enable : U_Bool);  -- pebble.h:6571
   pragma Import (C, Enable, "light_enable");

end Pebble.Ui.Lights;
