with Pebble.Graphics;   use Pebble.Graphics;
with Pebble.Menulayers; use Pebble.Menulayers;
with Pebble.Ui.Layers;  use Pebble.Ui.Layers;

package Pebble.Simplemenulayers is
   type Simplemenulayer is private;
   Null_Simplemenulayer : constant Simplemenulayer;

   type Select_Callback is access procedure
     (Index   : int;
      Context : Opaque_Ptr);
   pragma Convention (C, Select_Callback);  -- pebble.h:5869

   type Simple_Menu_Item is record
      Title    : Strings_Interface.Chars_Ptr;  -- pebble.h:5874
      Subtitle : Strings_Interface.Chars_Ptr;  -- pebble.h:5876
      Icon     : Opaque_Ptr;  -- pebble.h:5878
      Callback : Select_Callback;  -- pebble.h:5881
   end record;
   pragma Convention (C_Pass_By_Copy, Simple_Menu_Item);  -- pebble.h:5882

   type Simple_Menu_Section is record
      Title     : Strings_Interface.Chars_Ptr;  -- pebble.h:5887
      Items     : access constant Simple_Menu_Item;  -- pebble.h:5889
      Num_Items : aliased Uint32_T;  -- pebble.h:5891
   end record;
   pragma Convention (C_Pass_By_Copy, Simple_Menu_Section);  -- pebble.h:5892

   function Create
     (Frame            : Grect;
      Win              : Window;
      Sections         : access constant Simple_Menu_Section;
      Num_Sections     : Int32_T;
      Callback_Context : Opaque_Ptr) return Simplemenulayer;  -- pebble.h:5907
   pragma Import (C, Create, "simple_menu_layer_create");

   procedure Destroy (Sml : Simplemenulayer);  -- pebble.h:5911
   pragma Import (C, Destroy, "simple_menu_layer_destroy");

   function Get_Layer (Sml : Simplemenulayer) return Layer;  -- pebble.h:5918
   pragma Import (C, Get_Layer, "simple_menu_layer_get_layer");

   function Get_Selected_Index
     (Sml : Simplemenulayer) return int;  -- pebble.h:5923
   pragma Import
     (C,
      Get_Selected_Index,
      "simple_menu_layer_get_selected_index");

   procedure Set_Selected_Index
     (Sml      : Simplemenulayer;
      Index    : Int32_T;
      Animated : U_Bool);  -- pebble.h:5930
   pragma Import
     (C,
      Set_Selected_Index,
      "simple_menu_layer_set_selected_index");

   function Get_Menu_Layer
     (Sml : Simplemenulayer) return Menulayer;  -- pebble.h:5934
   pragma Import (C, Get_Menu_Layer, "simple_menu_layer_get_menu_layer");

private
   type Simplemenulayer is new Opaque_Ptr;
   Null_Simplemenulayer : constant Simplemenulayer :=
     Simplemenulayer (System.Null_Address);
end Pebble.Simplemenulayers;
