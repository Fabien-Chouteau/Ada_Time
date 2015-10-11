with Pebble.Graphics;  use Pebble.Graphics;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;

package Pebble.Statusbarlayers is
   type Status_Bar_Layer is private;
   Null_Status_Bar_Layer : constant Status_Bar_Layer;

   type Separator_Mode is
     (Statusbarlayerseparatormodenone,
      Statusbarlayerseparatormodedotted);
   pragma Convention (C, Separator_Mode);  -- pebble.h:6168

   function Create return Status_Bar_Layer;  -- pebble.h:6190
   pragma Import (C, Create, "status_bar_layer_create");

   procedure Destroy (Status_Bar : Status_Bar_Layer);  -- pebble.h:6194
   pragma Import (C, Destroy, "status_bar_layer_destroy");

   function Get_Layer
     (Status_Bar : Status_Bar_Layer) return Layer;  -- pebble.h:6201
   pragma Import (C, Get_Layer, "status_bar_layer_get_layer");

   function Get_Background_Color
     (Status_Bar : Status_Bar_Layer) return Gcolor;  -- pebble.h:6206
   pragma Import
     (C,
      Get_Background_Color,
      "status_bar_layer_get_background_color");

   function Get_Foreground_Color
     (Status_Bar : Status_Bar_Layer) return Gcolor;  -- pebble.h:6211
   pragma Import
     (C,
      Get_Foreground_Color,
      "status_bar_layer_get_foreground_color");

   procedure Set_Colors
     (Status_Bar : Status_Bar_Layer;
      Background : Gcolor;
      Foreground : Gcolor);  -- pebble.h:6217
   pragma Import (C, Set_Colors, "status_bar_layer_set_colors");

   procedure Set_Separator_Mode
     (Status_Bar : Status_Bar_Layer;
      Mode       : Separator_Mode);  -- pebble.h:6223
   pragma Import
     (C,
      Set_Separator_Mode,
      "status_bar_layer_set_separator_mode");

private
   type Status_Bar_Layer is new Opaque_Ptr;
   Null_Status_Bar_Layer : constant Status_Bar_Layer :=
     Status_Bar_Layer (Null_Opaque_Ptr);
end Pebble.Statusbarlayers;
