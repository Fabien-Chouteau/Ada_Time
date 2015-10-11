with Pebble.Graphics; use Pebble.Graphics;
with Pebble.Actionbarlayers; use Pebble.Actionbarlayers;
with Pebble.Textlayers; use Pebble.Textlayers;
with Pebble; use Pebble;

package Confirm_Windows is
   type Confirm_Window is private;

   type Cw_Callback is access procedure (Cw : Confirm_Window;
                                         Confirmed : Boolean);

   function Create (Callback : not null Cw_Callback) return Confirm_Window;
   procedure Destroy (Cw : in out Confirm_Window);
   function Get_Window (Cw : Confirm_Window) return Window;

private
   type Confirm_Window_Rec is record
      Win               : Window;
      Callback          : Cw_Callback;
      Action_Layer      : Actionbar_Layer;
      Yes_Icon, No_Icon : Gbitmap;
      Text              : Text_Layer;
   end record;
   type Confirm_Window is access Confirm_Window_Rec;
end Confirm_Windows;
