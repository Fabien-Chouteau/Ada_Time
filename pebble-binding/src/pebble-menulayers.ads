with Pebble.Graphics;     use Pebble.Graphics;
with Pebble.Scrolllayers; use Pebble.Scrolllayers;
with Pebble.Ui.Layers;    use Pebble.Ui.Layers;

package Pebble.Menulayers is
   Menu_Cell_Basic_Header_Height : constant := 16;
   procedure Basic_Draw
     (Ctx        : Gcontext;
      Cell_Layer : Layer;
      Title      : Strings_Interface.Chars_Ptr;
      Subtitle   : Strings_Interface.Chars_Ptr;
      Icon       : Opaque_Ptr);  -- pebble.h:5386
   pragma Import (C, Basic_Draw, "menu_cell_basic_draw");

   procedure Menu_Cell_Title_Draw
     (Arg1 : Opaque_Ptr;
      Arg2 : Opaque_Ptr;
      Arg3 : Strings_Interface.Chars_Ptr);  -- pebble.h:5400
   pragma Import (C, Menu_Cell_Title_Draw, "menu_cell_title_draw");

   procedure Menu_Cell_Basic_Header_Draw
     (Ctx        : Gcontext;
      Cell_Layer : Layer;
      Str        : Strings_Interface.Chars_Ptr);  -- pebble.h:5412
   pragma Import
     (C,
      Menu_Cell_Basic_Header_Draw,
      "menu_cell_basic_header_draw");

   type Menuindex is record
      Section : aliased Uint16_T;  -- pebble.h:5426
      Row     : aliased Uint16_T;  -- pebble.h:5428
   end record;
   pragma Convention (C_Pass_By_Copy, Menuindex);  -- pebble.h:5424

   function Menu_Index_Compare
     (Arg1 : Opaque_Ptr;
      Arg2 : Opaque_Ptr) return Int16_T;  -- pebble.h:5439
   pragma Import (C, Menu_Index_Compare, "menu_index_compare");

   type Menucellspan is record
      Y     : aliased Int16_T;  -- pebble.h:5442
      H     : aliased Int16_T;  -- pebble.h:5443
      Sep   : aliased Int16_T;  -- pebble.h:5444
      Index : aliased Menuindex;  -- pebble.h:5445
   end record;
   pragma Convention (C_Pass_By_Copy, Menucellspan);  -- pebble.h:

   type Menulayer is private;
   Null_Menulayer : constant Menulayer;

   type Menulayergetnumberofsectionscallback is access function
     (Ml      : Menulayer;
      Context : Opaque_Ptr) return Uint16_T;
   pragma Convention
     (C,
      Menulayergetnumberofsectionscallback);  -- pebble.h:5457

   type Menulayergetnumberofrowsinsectionscallback is access function
     (Ml            : Menulayer;
      Section_Index : Uint16_T;
      Context       : Opaque_Ptr) return Uint16_T;
   pragma Convention
     (C,
      Menulayergetnumberofrowsinsectionscallback);  -- pebble.h:5469

   type Menulayergetcellheightcallback is access function
     (Ml         : Menulayer;
      Cell_Index : access Menuindex;
      Context    : Opaque_Ptr) return Int16_T;
   pragma Convention (C, Menulayergetcellheightcallback);  -- pebble.h:5481

   type Menulayergetheaderheightcallback is access function
     (Ml            : Menulayer;
      Section_Index : Uint16_T;
      Context       : Opaque_Ptr) return Int16_T;
   pragma Convention (C, Menulayergetheaderheightcallback);  -- pebble.h:5494

   type Menulayergetseparatorheightcallback is access function
     (Ml         : Menulayer;
      Cell_Index : access Menuindex;
      Context    : Opaque_Ptr) return Int16_T;
   pragma Convention
     (C,
      Menulayergetseparatorheightcallback);  -- pebble.h:5506

   type Menulayerdrawrowcallback is access procedure
     (Ctx        : Gcontext;
      Cell_Layer : Layer;
      Cell_Index : access Menuindex;
      Context    : Opaque_Ptr);
   pragma Convention (C, Menulayerdrawrowcallback);  -- pebble.h:5522

   type Menulayerdrawheadercallback is access procedure
     (Ctx           : Gcontext;
      Cell_Layer    : Layer;
      Section_Index : Uint16_T;
      Context       : Opaque_Ptr);
   pragma Convention (C, Menulayerdrawheadercallback);  -- pebble.h:5541

   type Menulayerdrawseparatorcallback is access procedure
     (Ctx        : Gcontext;
      Cell_Layer : Layer;
      Cell_Index : access Menuindex;
      Context    : Opaque_Ptr);
   pragma Convention (C, Menulayerdrawseparatorcallback);  -- pebble.h:5558

   type Menulayerselectcallback is access procedure
     (Ml         : Menulayer;
      Cell_Index : access Menuindex;
      Context    : Opaque_Ptr);
   pragma Convention (C, Menulayerselectcallback);  -- pebble.h:5570

   type Menulayerselectionchangedcallback is access procedure
     (Ml        : Menulayer;
      New_Index : Menuindex;
      Old_Index : Menuindex;
      Context   : Opaque_Ptr);
   pragma Convention (C, Menulayerselectionchangedcallback);  -- pebble.h:5582

   type Menulayerselectionwillchangecallback is access procedure
     (Ml        : Menulayer;
      New_Index : access Menuindex;
      Old_Index : Menuindex;
      Context   : Opaque_Ptr);
   pragma Convention
     (C,
      Menulayerselectionwillchangecallback);  -- pebble.h:5596

   type Menulayerdrawbackgroundcallback is access procedure
     (Ctx       : Gcontext;
      Bg_Layer  : Layer;
      Highlight : U_Bool;
      Context   : Opaque_Ptr);
   pragma Convention (C, Menulayerdrawbackgroundcallback);  -- pebble.h:5608

   --  pebble.h:5618
   type Menulayercallbacks is record
      Get_Num_Sections      : Menulayergetnumberofsectionscallback;
      Get_Num_Rows          : Menulayergetnumberofrowsinsectionscallback;
      Get_Cell_Height       : Menulayergetcellheightcallback;
      Get_Header_Height     : Menulayergetheaderheightcallback;
      Draw_Row              : Menulayerdrawrowcallback;
      Draw_Header           : Menulayerdrawheadercallback;
      Select_Click          : Menulayerselectcallback;
      Select_Long_Click     : Menulayerselectcallback;
      Selection_Changed     : Menulayerselectionchangedcallback;
      Get_Separator_Height  : Menulayergetseparatorheightcallback;
      Draw_Separator        : Menulayerdrawseparatorcallback;
      Selection_Will_Change : Menulayerselectionwillchangecallback;
      Draw_Background       : Menulayerdrawbackgroundcallback;
   end record;
   pragma Convention (C_Pass_By_Copy, Menulayercallbacks);  -- pebble.h:5614

   function Create (Rect : Grect) return Menulayer;  -- pebble.h:5702
   pragma Import (C, Create, "menu_layer_create");

   procedure Destroy (Ml : Menulayer);  -- pebble.h:5705
   pragma Import (C, Destroy, "menu_layer_destroy");

   function Get_Layer (Ml : Menulayer) return Layer;  -- pebble.h:5711
   pragma Import (C, Get_Layer, "menu_layer_get_layer");

   function Get_Scroll_Layer
     (Ml : Menulayer) return Scrolllayer;  -- pebble.h:5717
   pragma Import (C, Get_Scroll_Layer, "menu_layer_get_scroll_layer");

   procedure Set_Callbacks
     (Ml               : Menulayer;
      Callback_Context : Opaque_Ptr;
      Callbacks        : Menulayercallbacks);  -- pebble.h:5727
   pragma Import (C, Set_Callbacks, "menu_layer_set_callbacks");

   procedure Set_Click_Config_Onto_Window
     (Ml  : Menulayer;
      Win : Window);  -- pebble.h:5746
   pragma Import
     (C,
      Set_Click_Config_Onto_Window,
      "menu_layer_set_click_config_onto_window");

   type Menurowalign is
     (Menurowalignnone,
      Menurowaligncenter,
      Menurowaligntop,
      Menurowalignbottom);
   pragma Convention (C, Menurowalign);  -- pebble.h:5767

   procedure Set_Selected_Next
     (Arg1 : Opaque_Ptr;
      Arg2 : U_Bool;
      Arg3 : Menurowalign;
      Arg4 : U_Bool);  -- pebble.h:5777
   pragma Import (C, Set_Selected_Next, "menu_layer_set_selected_next");

   procedure Set_Selected_Index
     (Arg1 : Opaque_Ptr;
      Arg2 : Menuindex;
      Arg3 : Menurowalign;
      Arg4 : U_Bool);  -- pebble.h:5791
   pragma Import (C, Set_Selected_Index, "menu_layer_set_selected_index");

   function Get_Selected_Index
     (Arg1 : Opaque_Ptr) return Menuindex;  -- pebble.h:5801
   pragma Import (C, Get_Selected_Index, "menu_layer_get_selected_index");

   procedure Reload_Data (Arg1 : Opaque_Ptr);  -- pebble.h:5809
   pragma Import (C, Reload_Data, "menu_layer_reload_data");

   function Menu_Cell_Layer_Is_Highlighted
     (Arg1 : Opaque_Ptr) return U_Bool;  -- pebble.h:5818
   pragma Import
     (C,
      Menu_Cell_Layer_Is_Highlighted,
      "menu_cell_layer_is_highlighted");

   procedure Set_Normal_Colors
     (Ml         : Menulayer;
      Background : Gcolor;
      Foreground : Gcolor);  -- pebble.h:5829
   pragma Import (C, Set_Normal_Colors, "menu_layer_set_normal_colors");

   procedure Set_Highlight_Colors
     (Ml         : Menulayer;
      Background : Gcolor;
      Foreground : Gcolor);  -- pebble.h:5840
   pragma Import (C, Set_Highlight_Colors, "menu_layer_set_highlight_colors");

   procedure Pad_Bottom_Enable
     (Ml      : Menulayer;
      Enabled : U_Bool);  -- pebble.h:5851
   pragma Import (C, Pad_Bottom_Enable, "menu_layer_pad_bottom_enable");

private
   type Menulayer is new Opaque_Ptr;
   Null_Menulayer : constant Menulayer := Menulayer (System.Null_Address);
end Pebble.Menulayers;
