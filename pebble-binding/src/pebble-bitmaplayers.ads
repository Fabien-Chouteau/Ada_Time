with Pebble.Graphics;  use Pebble.Graphics;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;

package Pebble.Bitmaplayers is
   type Bitmaplayer is private;
   Null_Bitmaplayer : constant Bitmaplayer;
   function Create (Arg1 : Grect) return Bitmaplayer;  -- pebble.h:6259
   pragma Import (C, Create, "bitmap_layer_create");

   procedure Destroy (Bl : Bitmaplayer);  -- pebble.h:6262
   pragma Import (C, Destroy, "bitmap_layer_destroy");

   function Get_Layer (Bl : Bitmaplayer) return Layer;  -- pebble.h:6268
   pragma Import (C, Get_Layer, "bitmap_layer_get_layer");

   function Get_Bitmap (Bl : Bitmaplayer) return Gbitmap;  -- pebble.h:6274
   pragma Import (C, Get_Bitmap, "bitmap_layer_get_bitmap");

   procedure Set_Bitmap (Bl : Bitmaplayer; Bitmap : Gbitmap);  -- pebble.h:6283
   pragma Import (C, Set_Bitmap, "bitmap_layer_set_bitmap");

   procedure Set_Alignment
     (Bl    : Bitmaplayer;
      Align : Galign);  -- pebble.h:6294
   pragma Import (C, Set_Alignment, "bitmap_layer_set_alignment");

   procedure Set_Background_Color
     (Bl    : Bitmaplayer;
      Color : Gcolor);  -- pebble.h:6302
   pragma Import
     (C,
      Set_Background_Color,
      "bitmap_layer_set_background_color");

   procedure Set_Compositing_Mode
     (Bl   : Bitmaplayer;
      Mode : Gcompop);  -- pebble.h:6321
   pragma Import
     (C,
      Set_Compositing_Mode,
      "bitmap_layer_set_compositing_mode");

private
   type Bitmaplayer is new Opaque_Ptr;
   Null_Bitmaplayer : constant Bitmaplayer :=
     Bitmaplayer (System.Null_Address);
end Pebble.Bitmaplayers;
