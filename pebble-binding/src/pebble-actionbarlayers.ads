with Pebble.Ui.Clicks;  use Pebble.Ui.Clicks;
with Pebble.Graphics;   use Pebble.Graphics;
with Pebble.Ui.Layers;  use Pebble.Ui.Layers;

package Pebble.Actionbarlayers is
   type Actionbarlayericonpressanimation is
     (Actionbarlayericonpressanimationnone,
      Actionbarlayericonpressanimationmoveleft,
      Actionbarlayericonpressanimationmoveup,
      Actionbarlayericonpressanimationmoveright,
      Actionbarlayericonpressanimationmovedown);
   pragma Convention (C, Actionbarlayericonpressanimation);  -- pebble.h:6023

   type Actionbar_Layer is private;

   function Create return Actionbar_Layer;  -- pebble.h:6035
   pragma Import (C, Create, "action_bar_layer_create");

   procedure Destroy (Abl : Actionbar_Layer);  -- pebble.h:6038
   pragma Import (C, Destroy, "action_bar_layer_destroy");

   function Get_Layer (Abl : Actionbar_Layer) return Layer;  -- pebble.h:6044
   pragma Import (C, Get_Layer, "action_bar_layer_get_layer");

   procedure Set_Context
     (Abl : Actionbar_Layer;
      Ctx : Opaque_Ptr);  -- pebble.h:6054
   pragma Import (C, Set_Context, "action_bar_layer_set_context");

   procedure Set_Click_Config_Provider
     (Abl    : Actionbar_Layer;
      Config : Clickconfigprovider);  -- pebble.h:6069
   pragma Import
     (C,
      Set_Click_Config_Provider,
      "action_bar_layer_set_click_config_provider");

   procedure Set_Icon
     (Abl    : Actionbar_Layer;
      Button : Buttonid;
      Icon   : Gbitmap);  -- pebble.h:6083
   pragma Import (C, Set_Icon, "action_bar_layer_set_icon");

   procedure Clear_Icon
     (Abl    : Actionbar_Layer;
      Button : Buttonid);  -- pebble.h:6090
   pragma Import (C, Clear_Icon, "action_bar_layer_clear_icon");

   procedure Add_To_Window
     (Abl : Actionbar_Layer;
      Win : Window);  -- pebble.h:6113
   pragma Import (C, Add_To_Window, "action_bar_layer_add_to_window");

   procedure Remove_From_Window (Abl : Actionbar_Layer);  -- pebble.h:6120
   pragma Import
     (C,
      Remove_From_Window,
      "action_bar_layer_remove_from_window");

   procedure Set_Background_Color
     (Abl   : Actionbar_Layer;
      Color : Gcolor);  -- pebble.h:6126
   pragma Import
     (C,
      Set_Background_Color,
      "action_bar_layer_set_background_color");

   procedure Set_Icon_Animated
     (Abl      : Actionbar_Layer;
      Button   : Buttonid;
      Icon     : Gbitmap;
      Animated : U_Bool);  -- pebble.h:6140
   pragma Import (C, Set_Icon_Animated, "action_bar_layer_set_icon_animated");

   procedure Set_Icon_Press_Animation
     (Abl       : Actionbar_Layer;
      Button    : Buttonid;
      Animation : Actionbarlayericonpressanimation);  -- pebble.h:6150
   pragma Import
     (C,
      Set_Icon_Press_Animation,
      "action_bar_layer_set_icon_press_animation");

private
   type Actionbar_Layer is new Opaque_Ptr;
end Pebble.Actionbarlayers;
