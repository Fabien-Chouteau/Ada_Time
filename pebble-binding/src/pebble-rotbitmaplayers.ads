with Pebble.Graphics; use Pebble.Graphics;

package Pebble.Rotbitmaplayers is
   type Rotbitmaplayer is private;
   Null_Rotbitmaplayer : constant Rotbitmaplayer;

   function Create (Bitmap : Gbitmap) return Rotbitmaplayer;  -- pebble.h:6356
   pragma Import (C, Create, "rot_bitmap_layer_create");

   procedure Destroy (Bitmap : Rotbitmaplayer);  -- pebble.h:6361
   pragma Import (C, Destroy, "rot_bitmap_layer_destroy");

   procedure Set_Corner_Clip_Color
     (Bitmap : Rotbitmaplayer;
      Color  : Gcolor);  -- pebble.h:6367
   pragma Import
     (C,
      Set_Corner_Clip_Color,
      "rot_bitmap_layer_set_corner_clip_color");

   procedure Set_Angle
     (Bitmap : Rotbitmaplayer;
      Angle  : Int32_T);  -- pebble.h:6372
   pragma Import (C, Set_Angle, "rot_bitmap_layer_set_angle");

   procedure Increment_Angle
     (Bitmap       : Rotbitmaplayer;
      Angle_Change : Int32_T);  -- pebble.h:6377
   pragma Import (C, Increment_Angle, "rot_bitmap_layer_increment_angle");

   procedure Set_Src_Ic
     (Bitmap : Rotbitmaplayer;
      Ic     : Gpoint);  -- pebble.h:6389
   pragma Import (C, Set_Src_Ic, "rot_bitmap_set_src_ic");

   procedure Set_Compositing_Mode
     (Bitmap : Rotbitmaplayer;
      Mode   : Gcompop);  -- pebble.h:6398
   pragma Import (C, Set_Compositing_Mode, "rot_bitmap_set_compositing_mode");

private
   type Rotbitmaplayer is new Opaque_Ptr;
   Null_Rotbitmaplayer : constant Rotbitmaplayer :=
     Rotbitmaplayer (Null_Opaque_Ptr);

end Pebble.Rotbitmaplayers;
