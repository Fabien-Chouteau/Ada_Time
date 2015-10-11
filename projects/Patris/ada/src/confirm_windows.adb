with Ada.Unchecked_Deallocation;
with Pebble.Ui.Windows; use Pebble.Ui.Windows;
with Opaque_Pointers;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;
with System; use System;
with Pebble.Ui.Clicks; use Pebble.Ui.Clicks;
with Interfaces.C; use Interfaces.C;
with Strings_Interface; use Strings_Interface;

package body Confirm_Windows is

   package Opaque is new Opaque_Pointers (Confirm_Window_Rec, Confirm_Window);
   use Opaque;

   procedure Free is
     new Ada.Unchecked_Deallocation (Confirm_Window_Rec, Confirm_Window);

   Str_Are_You_Sure : aliased char_array := "Are you sure?";
   Tick_Data : aliased array (Natural range <>) of aliased Pebble.Uint8_T :=
     (16#89#, 16#50#, 16#4e#, 16#47#, 16#0d#, 16#0a#, 16#1a#, 16#0a#, 16#00#,
      16#00#, 16#00#, 16#0d#, 16#49#, 16#48#, 16#44#, 16#52#, 16#00#, 16#00#,
      16#00#, 16#12#, 16#00#, 16#00#, 16#00#, 16#12#, 16#01#, 16#00#, 16#00#,
      16#00#, 16#00#, 16#7e#, 16#b5#, 16#b3#, 16#fa#, 16#00#, 16#00#, 16#00#,
      16#3e#, 16#49#, 16#44#, 16#41#, 16#54#, 16#78#, 16#da#, 16#63#, 16#60#,
      16#80#, 16#01#, 16#46#, 16#20#, 16#66#, 16#6e#, 16#60#, 16#60#, 16#60#,
      16#3f#, 16#c0#, 16#c0#, 16#c0#, 16#7f#, 16#80#, 16#41#, 16#41#, 16#be#,
      16#81#, 16#a1#, 16#c0#, 16#9e#, 16#81#, 16#e1#, 16#47#, 16#1d#, 16#03#,
      16#c3#, 16#9f#, 16#3f#, 16#0c#, 16#0c#, 16#f5#, 16#3f#, 16#18#, 16#18#,
      16#ec#, 16#3f#, 16#30#, 16#30#, 16#c8#, 16#3f#, 16#00#, 16#4b#, 16#33#,
      16#b0#, 16#03#, 16#95#, 16#32#, 16#c3#, 16#35#, 16#33#, 16#00#, 16#00#,
      16#a1#, 16#d1#, 16#0b#, 16#f5#, 16#32#, 16#07#, 16#92#, 16#c2#, 16#00#,
      16#00#, 16#00#, 16#00#, 16#49#, 16#45#, 16#4e#, 16#44#, 16#ae#, 16#42#,
      16#60#, 16#82#
     );

   Cross_Data : aliased array (Natural range <>) of aliased Pebble.Uint8_T :=
     (16#89#, 16#50#, 16#4e#, 16#47#, 16#0d#, 16#0a#, 16#1a#, 16#0a#, 16#00#,
      16#00#, 16#00#, 16#0d#, 16#49#, 16#48#, 16#44#, 16#52#, 16#00#, 16#00#,
      16#00#, 16#12#, 16#00#, 16#00#, 16#00#, 16#12#, 16#01#, 16#00#, 16#00#,
      16#00#, 16#00#, 16#7e#, 16#b5#, 16#b3#, 16#fa#, 16#00#, 16#00#, 16#00#,
      16#3c#, 16#49#, 16#44#, 16#41#, 16#54#, 16#78#, 16#da#, 16#25#, 16#8c#,
      16#b1#, 16#0d#, 16#00#, 16#20#, 16#10#, 16#02#, 16#af#, 16#b2#, 16#b5#,
      16#b5#, 16#73#, 16#11#, 16#13#, 16#37#, 16#d3#, 16#1f#, 16#cd#, 16#c1#,
      16#8c#, 16#28#, 16#b1#, 16#20#, 16#21#, 16#70#, 16#40#, 16#49#, 16#d0#,
      16#32#, 16#8c#, 16#1a#, 16#a8#, 16#2f#, 16#a4#, 16#c5#, 16#54#, 16#d0#,
      16#05#, 16#f5#, 16#40#, 16#de#, 16#5f#, 16#f6#, 16#ce#, 16#dc#, 16#99#,
      16#31#, 16#eb#, 16#8d#, 16#b7#, 16#ef#, 16#e3#, 16#02#, 16#49#, 16#9d#,
      16#17#, 16#4d#, 16#45#, 16#63#, 16#b9#, 16#1f#, 16#00#, 16#00#, 16#00#,
      16#00#, 16#49#, 16#45#, 16#4e#, 16#44#, 16#ae#, 16#42#, 16#60#, 16#82#
     );

   procedure Load (Win : Window) with Convention => C;
   procedure Unload (Win : Window) with Convention => C;
   procedure Config_Provider (Context : System.Address) with Convention => C;
   procedure Button_Handler (Recognizer : Clickrecognizerref;
                             Context : System.Address) with Convention => C;
   procedure Create_Icons (Cw : Confirm_Window);

   ---------------------
   -- Config_Provider --
   ---------------------

   procedure Config_Provider (Context : System.Address) is
      pragma Unreferenced (Context);
   begin
      Single_Click_Subscribe (Button_Id_Up, Button_Handler'Access);
      Single_Click_Subscribe (Button_Id_Down, Button_Handler'Access);
   end Config_Provider;

   --------------------
   -- Button_Handler --
   --------------------

   procedure Button_Handler (Recognizer : Clickrecognizerref;
                             Context : System.Address)
   is
      Cw : constant Confirm_Window := From_Opaque (Context);
   begin
      if Is_Repeating (Recognizer) = 0 then
         case Get_Button_Id (Recognizer) is
         when Button_Id_Up => Cw.Callback (Cw, True);
         when Button_Id_Down => Cw.Callback (Cw, False);
         when others => null;
         end case;
      end if;
   end Button_Handler;

   ----------
   -- Load --
   ----------

   procedure Load (Win : Window) is
      Cw : constant Confirm_Window := From_Opaque (Get_User_Data (Win));
      Win_Layer  : constant Layer := Get_Root_Layer (Win);
      WRect : Grect := Get_Bounds (Win_Layer);

   begin
      --  Text layer
      WRect.Size.W := WRect.Size.W - Action_Bar_Width;
      WRect.Origin.Y := WRect.Size.H / 2 - 10;
      Cw.Text := Create (WRect);
      Set_Text (Cw.Text, To_Chars_Ptr (Str_Are_You_Sure'Access));
      Set_Text_Color (Cw.Text, Colors.Black);
      Set_Text_Alignment (Cw.Text, Gtextalignmentcenter);
      Set_Background_Color (Cw.Text, Colors.White);
      Add_Child (Win_Layer, Get_Layer (Cw.Text));

      --  Action bar layer
      Cw.Action_Layer := Create;
      Add_To_Window (Cw.Action_Layer, Win);
      Set_Context (Cw.Action_Layer, To_Opaque (Cw));
      Set_Click_Config_Provider (Cw.Action_Layer, Config_Provider'Access);

      --  Icons bitmaps
      Set_Icon (Cw.Action_Layer, Button_Id_Up, Cw.Yes_Icon);
      Set_Icon (Cw.Action_Layer, Button_Id_Down, Cw.No_Icon);

   end Load;

   ------------
   -- Unload --
   ------------

   procedure Unload (Win : Window) is
      Cw : constant Confirm_Window := From_Opaque (Get_User_Data (Win));
   begin
      Destroy (Cw.Action_Layer);
      Destroy (Cw.Text);
   end Unload;

   --  Interface

   ------------------
   -- Create_Icons --
   ------------------

   procedure Create_Icons (Cw : Confirm_Window) is
   begin
      Cw.Yes_Icon :=
        Create_From_Png_Data (Tick_Data (Tick_Data'First)'Unchecked_Access,
                             Tick_Data'Length);
      Cw.No_Icon :=
        Create_From_Png_Data (Cross_Data (Cross_Data'First)'Unchecked_Access,
                              Cross_Data'Length);
   end Create_Icons;

   ------------
   -- Create --
   ------------

   function Create (Callback : not null Cw_Callback) return Confirm_Window is
      Cw : constant Confirm_Window := new Confirm_Window_Rec;
   begin
      Cw.Win := Pebble.Ui.Windows.Create;
      Set_User_Data (Cw.Win, To_Opaque (Cw));

      Set_Background_Color (Cw.Win, Colors.White);

      Set_Window_Handlers (Cw.Win,
                           (Load => Load'Access,
                            Unload => Unload'Access,
                            others => null));

      --  Icons
      Create_Icons (Cw);

      Cw.Callback := Callback;
      return Cw;
   end Create;

   -------------
   -- Destroy --
   -------------

   procedure Destroy (Cw : in out Confirm_Window) is
   begin
      if Cw /= null then
         Pebble.Ui.Windows.Destroy (Cw.Win);
         Destroy (Cw.Yes_Icon);
         Destroy (Cw.No_Icon);
         Free (Cw);
      end if;
   end Destroy;

   ----------------
   -- Get_Window --
   ----------------

   function Get_Window (Cw : Confirm_Window) return Window is
   begin
      if Cw = null then
         return Null_Window;
      else
         return Cw.Win;
      end if;
   end Get_Window;
end Confirm_Windows;
