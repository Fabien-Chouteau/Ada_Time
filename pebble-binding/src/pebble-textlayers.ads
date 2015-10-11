with Pebble.Graphics;  use Pebble.Graphics;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;

package Pebble.Textlayers is

   type Text_Layer is private;
   Null_Text_Layer : constant Text_Layer;

   function Create (Rect : Grect) return Text_Layer;  -- pebble.h:5078
   pragma Import (C, Create, "text_layer_create");

   procedure Destroy (Layer : Text_Layer);  -- pebble.h:5081
   pragma Import (C, Destroy, "text_layer_destroy");

   function Get_Layer (Arg1 : Text_Layer) return Layer;  -- pebble.h:5087
   pragma Import (C, Get_Layer, "text_layer_get_layer");

   procedure Set_Text
     (Arg1 : Text_Layer;
      Arg2 : Strings_Interface.Chars_Ptr);  -- pebble.h:5097
   pragma Import (C, Set_Text, "text_layer_set_text");

   function Get_Text
     (Arg1 : Text_Layer) return Strings_Interface.Chars_Ptr;  -- pebble.h:5102
   pragma Import (C, Get_Text, "text_layer_get_text");

   procedure Set_Background_Color
     (Arg1 : Text_Layer;
      Arg2 : Gcolor);  -- pebble.h:5108
   pragma Import (C, Set_Background_Color, "text_layer_set_background_color");

   procedure Set_Text_Color
     (Arg1 : Text_Layer;
      Arg2 : Gcolor);  -- pebble.h:5114
   pragma Import (C, Set_Text_Color, "text_layer_set_text_color");

   procedure Set_Overflow_Mode
     (Arg1 : Text_Layer;
      Arg2 : Gtextoverflowmode);  -- pebble.h:5119
   pragma Import (C, Set_Overflow_Mode, "text_layer_set_overflow_mode");

   procedure Set_Font (Arg1 : Text_Layer; Arg2 : Gfont);  -- pebble.h:5126
   pragma Import (C, Set_Font, "text_layer_set_font");

   procedure Set_Text_Alignment
     (Arg1 : Text_Layer;
      Arg2 : Gtextalignment);  -- pebble.h:5132
   pragma Import (C, Set_Text_Alignment, "text_layer_set_text_alignment");

   function Get_Content_Size
     (Arg1 : Text_Layer) return Gsize;  -- pebble.h:5137
   pragma Import (C, Get_Content_Size, "text_layer_get_content_size");

   procedure Set_Size (Arg1 : Text_Layer; Arg2 : Gsize);  -- pebble.h:5143
   pragma Import (C, Set_Size, "text_layer_set_size");

private
   type Text_Layer is new Opaque_Ptr;
   Null_Text_Layer : constant Text_Layer := Text_Layer (Null_Opaque_Ptr);
end Pebble.Textlayers;
