with Pebble.Ui.Clicks; use Pebble.Ui.Clicks;
with Pebble.Graphics;  use Pebble.Graphics;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;

package Pebble.Ui.Windows is

   type Handler is access procedure (Win : Window);
   pragma Convention (C, Handler);  -- pebble.h:3978

   type Window_Handlers is record
      Load      : Handler;  -- pebble.h:3988
      Appear    : Handler;  -- pebble.h:3994
      Disappear : Handler;  -- pebble.h:3999
      Unload    : Handler;  -- pebble.h:4003
   end record;
   pragma Convention (C_Pass_By_Copy, Window_Handlers);  -- pebble.h:3985

   function Create return Window;  -- pebble.h:4016
   pragma Import (C, Create, "window_create");

   procedure Destroy (Win : Window);  -- pebble.h:4019
   pragma Import (C, Destroy, "window_destroy");

   procedure Set_Click_Config_Provider
     (Win             : Window;
      Config_Provider : Clickconfigprovider);  -- pebble.h:4028
   pragma Import
     (C,
      Set_Click_Config_Provider,
      "window_set_click_config_provider");

   procedure Set_Click_Config_Provider_With_Context
     (Win             : Window;
      Config_Provider : Clickconfigprovider;
      Context         : Opaque_Ptr);  -- pebble.h:4037
   pragma Import
     (C,
      Set_Click_Config_Provider_With_Context,
      "window_set_click_config_provider_with_context");

   function Get_Click_Config_Provider
     (Win : Window) return Clickconfigprovider;  -- pebble.h:4041
   pragma Import
     (C,
      Get_Click_Config_Provider,
      "window_get_click_config_provider");

   function Get_Click_Config_Context
     (Win : Window) return Opaque_Ptr;  -- pebble.h:4045
   pragma Import
     (C,
      Get_Click_Config_Context,
      "window_get_click_config_context");

   procedure Set_Window_Handlers
     (Win      : Window;
      Handlers : Window_Handlers);  -- pebble.h:4052
   pragma Import (C, Set_Window_Handlers, "window_set_window_handlers");

   function Get_Root_Layer (Win : Window) return Layer;  -- pebble.h:4060
   pragma Import (C, Get_Root_Layer, "window_get_root_layer");

   procedure Set_Background_Color
     (Win        : Window;
      Background : Gcolor);  -- pebble.h:4067
   pragma Import (C, Set_Background_Color, "window_set_background_color");

  --  Removed in SDK 3.1
  --     procedure Set_Status_Bar_Icon
  --       (Win  : Window;
  --        Icon : Gbitmap);  -- pebble.h:4074
  --     pragma Import (C, Set_Status_Bar_Icon, "window_set_status_bar_icon");

   function Is_Loaded (Win : Window) return U_Bool;  -- pebble.h:4082
   pragma Import (C, Is_Loaded, "window_is_loaded");

   procedure Set_User_Data (Win : Window; Data : Opaque_Ptr);  -- pebble.h:4089
   pragma Import (C, Set_User_Data, "window_set_user_data");

   function Get_User_Data (Win : Window) return Opaque_Ptr;  -- pebble.h:4095
   pragma Import (C, Get_User_Data, "window_get_user_data");

   procedure Single_Click_Subscribe
     (Button  : Buttonid;
      Handler : Clickhandler);  -- pebble.h:4107
   pragma Import (C, Single_Click_Subscribe, "window_single_click_subscribe");

   procedure Single_Repeating_Click_Subscribe
     (Button      : Buttonid;
      Interval_Ms : Uint16_T;
      Handler     : Clickhandler);  -- pebble.h:4119
   pragma Import
     (C,
      Single_Repeating_Click_Subscribe,
      "window_single_repeating_click_subscribe");

   procedure Multi_Click_Subscribe
     (Button          : Buttonid;
      Min_Clicks      : Uint8_T;
      Max_Clicks      : Uint8_T;
      Timeout         : Uint16_T;
      Last_Click_Only : U_Bool;
      Handler         : Clickhandler);  -- pebble.h:4129
   pragma Import (C, Multi_Click_Subscribe, "window_multi_click_subscribe");

   procedure Long_Click_Subscribe
     (Button       : Buttonid;
      Delay_Ms     : Uint16_T;
      Down_Handler : Clickhandler;
      Up_Handler   : Clickhandler);  -- pebble.h:4138
   pragma Import (C, Long_Click_Subscribe, "window_long_click_subscribe");

   procedure Raw_Click_Subscribe
     (Button       : Buttonid;
      Down_Handler : Clickhandler;
      Up_Handler   : Clickhandler;
      Context      : Opaque_Ptr);  -- pebble.h:4147
   pragma Import (C, Raw_Click_Subscribe, "window_raw_click_subscribe");

   procedure Set_Click_Context
     (Button  : Buttonid;
      Context : Opaque_Ptr);  -- pebble.h:4154
   pragma Import (C, Set_Click_Context, "window_set_click_context");

end Pebble.Ui.Windows;
