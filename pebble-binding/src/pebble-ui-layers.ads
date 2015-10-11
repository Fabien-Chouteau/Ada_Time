with Pebble.Graphics; use Pebble.Graphics;

package Pebble.Ui.Layers is

   type Layer is private;
   Null_Layer : constant Layer;

   type Layerupdateproc is access procedure (L : Layer; Ctx : Gcontext);
   pragma Convention (C, Layerupdateproc);  -- pebble.h:3777

   function Create (Frame : Grect) return Layer;  -- pebble.h:3790
   pragma Import (C, Create, "layer_create");

   function Create_With_Data
     (Frame     : Grect;
      Data_Size : Size_T) return Layer;  -- pebble.h:3804
   pragma Import (C, Create_With_Data, "layer_create_with_data");

   procedure Destroy (L : Layer);  -- pebble.h:3807
   pragma Import (C, Destroy, "layer_destroy");

   procedure Mark_Dirty (L : Layer);  -- pebble.h:3818
   pragma Import (C, Mark_Dirty, "layer_mark_dirty");

   procedure Set_Update_Proc
     (L           : Layer;
      Update_Proc : Layerupdateproc);  -- pebble.h:3827
   pragma Import (C, Set_Update_Proc, "layer_set_update_proc");

   procedure Set_Frame (L : Layer; Frame : Grect);  -- pebble.h:3836
   pragma Import (C, Set_Frame, "layer_set_frame");

   function Get_Frame (L : Layer) return Grect;  -- pebble.h:3844
   pragma Import (C, Get_Frame, "layer_get_frame");

   procedure Set_Bounds (L : Layer; Bounds : Grect);  -- pebble.h:3851
   pragma Import (C, Set_Bounds, "layer_set_bounds");

   function Get_Bounds (L : Layer) return Grect;  -- pebble.h:3857
   pragma Import (C, Get_Bounds, "layer_get_bounds");

   function Get_Window (L : Layer) return Window;  -- pebble.h:3865
   pragma Import (C, Get_Window, "layer_get_window");

   procedure Remove_From_Parent (Child : Layer);  -- pebble.h:3871
   pragma Import (C, Remove_From_Parent, "layer_remove_from_parent");

   procedure Remove_Child_Layers (Parent : Layer);  -- pebble.h:3877
   pragma Import (C, Remove_Child_Layers, "layer_remove_child_layers");

   procedure Add_Child (Parent : Layer; Child : Layer);  -- pebble.h:3888
   pragma Import (C, Add_Child, "layer_add_child");

   procedure Insert_Below_Sibling
     (To_Insert     : Layer;
      Below_Sibling : Layer);  -- pebble.h:3898
   pragma Import (C, Insert_Below_Sibling, "layer_insert_below_sibling");

   procedure Insert_Above_Sibling
     (To_Insert     : Layer;
      Above_Sibling : Layer);  -- pebble.h:3908
   pragma Import (C, Insert_Above_Sibling, "layer_insert_above_sibling");

   procedure Set_Hidden (L : Layer; Arg2 : U_Bool);  -- pebble.h:3916
   pragma Import (C, Set_Hidden, "layer_set_hidden");

   function Get_Hidden (L : Layer) return U_Bool;  -- pebble.h:3921
   pragma Import (C, Get_Hidden, "layer_get_hidden");

   procedure Set_Clips (L : Layer; Arg2 : U_Bool);  -- pebble.h:3930
   pragma Import (C, Set_Clips, "layer_set_clips");

   function Get_Clips (L : Layer) return U_Bool;  -- pebble.h:3938
   pragma Import (C, Get_Clips, "layer_get_clips");

   function Get_Data (L : Layer) return Opaque_Ptr;  -- pebble.h:3943
   pragma Import (C, Get_Data, "layer_get_data");

private
   type Layer is new Opaque_Ptr;
   Null_Layer : constant Layer := Layer (System.Null_Address);
end Pebble.Ui.Layers;
