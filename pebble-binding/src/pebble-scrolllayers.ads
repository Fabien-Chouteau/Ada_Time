with Pebble.Graphics;  use Pebble.Graphics;
with Pebble.Ui.Clicks; use Pebble.Ui.Clicks;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;

package Pebble.Scrolllayers is
   type Scrolllayer is private;
   Null_Scrolllayer : constant Scrolllayer;

   type Scrolllayer_Callback is access procedure
     (Scroll_Layer : Scrolllayer;
      Context      : Opaque_Ptr);
   pragma Convention (C, Scrolllayer_Callback);  -- pebble.h:5184

   type Scrolllayer_Callbacks is record
      Click_Config_Provider          : Clickconfigprovider;  -- pebble.h:5195
      Content_Offset_Changed_Handler : Scrolllayer_Callback;  -- pebble.h:5199
   end record;
   pragma Convention (C_Pass_By_Copy, Scrolllayer_Callbacks);  -- pebble.h:5189

   function Create (Frame : Grect) return Opaque_Ptr;  -- pebble.h:5212
   pragma Import (C, Create, "scroll_layer_create");

   procedure Destroy (Scroll_Layer : Scrolllayer);  -- pebble.h:5215
   pragma Import (C, Destroy, "scroll_layer_destroy");

   function Get_Layer
     (Scroll_Layer : Scrolllayer) return Opaque_Ptr;  -- pebble.h:5221
   pragma Import (C, Get_Layer, "scroll_layer_get_layer");

   procedure Add_Child
     (Scroll_Layer : Scrolllayer;
      Child        : Layer);  -- pebble.h:5231
   pragma Import (C, Add_Child, "scroll_layer_add_child");

   procedure Set_Click_Config_Onto_Window
     (Scroll_Layer : Scrolllayer;
      Win          : Window);  -- pebble.h:5255
   pragma Import
     (C,
      Set_Click_Config_Onto_Window,
      "scroll_layer_set_click_config_onto_window");

   procedure Set_Callbacks
     (Scroll_Layer : Scrolllayer;
      Callbacks    : Scrolllayer_Callbacks);  -- pebble.h:5264
   pragma Import (C, Set_Callbacks, "scroll_layer_set_callbacks");

   procedure Set_Context
     (Scroll_Layer : Scrolllayer;
      Context      : Opaque_Ptr);  -- pebble.h:5275
   pragma Import (C, Set_Context, "scroll_layer_set_context");

   procedure Set_Content_Offset
     (Scroll_Layer : Scrolllayer;
      Offset       : Gpoint;
      Animated     : U_Bool);  -- pebble.h:5287
   pragma Import (C, Set_Content_Offset, "scroll_layer_set_content_offset");

   function Get_Content_Offset
     (Scroll_Layer : Scrolllayer) return Gpoint;  -- pebble.h:5292
   pragma Import (C, Get_Content_Offset, "scroll_layer_get_content_offset");

   procedure Set_Content_Size
     (Scroll_Layer : Scrolllayer;
      Size         : Gsize);  -- pebble.h:5300
   pragma Import (C, Set_Content_Size, "scroll_layer_set_content_size");

   function Get_Content_Size
     (Scroll_Layer : Scrolllayer) return Gsize;  -- pebble.h:5305
   pragma Import (C, Get_Content_Size, "scroll_layer_get_content_size");

   procedure Set_Frame
     (Scroll_Layer : Scrolllayer;
      Frame        : Grect);  -- pebble.h:5311
   pragma Import (C, Set_Frame, "scroll_layer_set_frame");

   procedure Scroll_Up_Click_Handler
     (Recognizer : Clickrecognizerref;
      Context    : Opaque_Ptr);  -- pebble.h:5319
   pragma Import
     (C,
      Scroll_Up_Click_Handler,
      "scroll_layer_scroll_up_click_handler");

   procedure Scroll_Down_Click_Handler
     (Recognizer : Clickrecognizerref;
      Context    : Opaque_Ptr);  -- pebble.h:5327
   pragma Import
     (C,
      Scroll_Down_Click_Handler,
      "scroll_layer_scroll_down_click_handler");

   procedure Set_Shadow_Hidden
     (Scroll_Layer : Scrolllayer;
      Hidden       : U_Bool);  -- pebble.h:5335
   pragma Import (C, Set_Shadow_Hidden, "scroll_layer_set_shadow_hidden");

   function Get_Shadow_Hidden
     (Scroll_Layer : Scrolllayer) return U_Bool;  -- pebble.h:5340
   pragma Import (C, Get_Shadow_Hidden, "scroll_layer_get_shadow_hidden");

private
   type Scrolllayer is new Opaque_Ptr;
   Null_Scrolllayer : constant Scrolllayer :=
     Scrolllayer (System.Null_Address);

end Pebble.Scrolllayers;
