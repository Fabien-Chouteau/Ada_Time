with Pebble; use Pebble;
with System;
with Strings_Interface; use Strings_Interface;
with Interfaces.C; use Interfaces.C;
with Pebble.Ui.Windows; use Pebble.Ui.Windows;
with Pebble.Ui.Windows.Stacks; use Pebble.Ui.Windows.Stacks;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;
with Pebble.Graphics; use Pebble.Graphics;
with Pebble.Eventservice.Ticktimer; use Pebble.Eventservice.Ticktimer;
with Pebble.Actionbarlayers; use Pebble.Actionbarlayers;
with Pebble.Logging; use Pebble.Logging;
with Pebble.Ui.Clicks; use Pebble.Ui.Clicks;
with Game_Window;
with Menu_Window;
with Game_Storage;
with Patris; use Patris;
with Patris.Utils;
with UI_Texts;

package body Main_Window is

   Icon_Play_Resource_Id : Uint32_T;
   pragma Import (C, Icon_Play_Resource_Id, "icon_play_resource_id");
   Icon_Menu_Resource_Id : Uint32_T;
   pragma Import (C, Icon_Menu_Resource_Id, "icon_menu_resource_id");
   Splash_Resource_Id : Uint32_T;
   pragma Import (C, Splash_Resource_Id, "splash_resource_id");

   Main_Win : Window;
   Center : Gpoint;
   pragma Unreferenced (Center);
   Canvas_Layer : Layer;
   Action_Layer : Actionbar_Layer;
   Font         : Gfont;

   Icon_Tick, Icon_Cross, Splash : Gbitmap;

   --  Strings
   Font_Txt : aliased char_array := "RESOURCE_ID_GOTHIC_14_BOLD";

   procedure Load (Win : Window) with Convention => C;
   procedure Unload (Win : Window) with Convention => C;
   procedure Tick_Handler (arg1 : access Tm; arg2 : Time_Units)
     with Convention => C;
   procedure Update_Canvas_Layer (L : Layer; Ctx : Gcontext)
     with Convention => C;
   procedure Update_Time;

   procedure Update_Time is
   begin
      Mark_Dirty (Canvas_Layer);
   end Update_Time;

   procedure Update_Canvas_Layer (L : Layer; Ctx : Gcontext) is
      Box : constant Grect := Get_Bounds (L);
      Tmp_Txt : aliased char_array := "XXXXXX";
      Score_Box : Grect;
   begin
      Draw_Bitmap_In_Rect (Ctx    => Ctx,
                           Bitmap => Splash,
                           Rect   => Box);

      if Get_Best_Score = 0 then
         return;
      end if;

      --  Best Score box
      Score_Box.Origin := (Box.Origin.X + 20, Box.Origin.Y + 73);
      Score_Box.Size   := (70, 40);

      --  Background and frame
      Set_Fill_Color (Ctx, Colors.Black);
      Fill_Rect (Ctx           => Ctx,
                 Rect          => Score_Box,
                 Corner_Radius => Game_Window.Corners_Radius,
                 Corner_Mask   => Game_Window.Corners_Radius);
      Set_Stroke_Color (Ctx, Game_Window.Frames_Color);
      Set_Stroke_Width (Ctx, 1);
      Draw_Round_Rect (Ctx, Score_Box, Game_Window.Corners_Radius);

      --  Adjust box for text
      Score_Box := ((Score_Box.Origin.X, Score_Box.Origin.Y + 3),
                    (Score_Box.Size.W, Score_Box.Size.H - 3));
      Set_Text_Color (Ctx, Colors.White);
      Draw_Text (Ctx           => Ctx,
                 Text          => UI_Texts.Get_Str (UI_Texts.ID_Best_Score),
                 Font          => Font,
                 Box           => Score_Box,
                 Overflow_Mode => Gtextoverflowmodefill,
                 Alignment     => Gtextalignmentcenter,
                 Cache         => Null_Cacheref);

      --  Adjust box for score number
      Score_Box := ((Score_Box.Origin.X, Score_Box.Origin.Y + 16),
                    (Score_Box.Size.W, Score_Box.Size.H - 16));

      Patris.Utils.To_String (Get_Best_Score, Tmp_Txt);
      Draw_Text (Ctx           => Ctx,
                 Text          => To_Chars_Ptr (Tmp_Txt'Unchecked_Access),
                 Font          => Font,
                 Box           => Score_Box,
                 Overflow_Mode => Gtextoverflowmodefill,
                 Alignment     => Gtextalignmentcenter,
                 Cache         => Null_Cacheref);

   end Update_Canvas_Layer;

   procedure Config_Provider (Context : System.Address) with Convention => C;
   procedure Button_Handler (Recognizer : Clickrecognizerref;
                        Context : System.Address) with Convention => C;

   procedure Config_Provider (Context : System.Address) is
      pragma Unreferenced (Context);
   begin
      Single_Click_Subscribe (Button_Id_Up, Button_Handler'Access);
      Single_Click_Subscribe (Button_Id_Down, Button_Handler'Access);
   end Config_Provider;

   procedure Button_Handler (Recognizer : Clickrecognizerref;
                           Context : System.Address)
   is
      pragma Unreferenced (Context);
   begin
      if Is_Repeating (Recognizer) = 0 then
         case Get_Button_Id (Recognizer) is
         when Button_Id_Up =>
            if Patris.Get_State = Game_Over then
               Patris.Game_Reset;
            end if;
            Game_Window.Push;
         when Button_Id_Down =>
            Menu_Window.Push;
         when others => null;
         end case;
      end if;
   end Button_Handler;

   procedure Load (Win : Window) is
      pragma Unreferenced (Win);
      Win_Layer  : constant Layer := Get_Root_Layer (Main_Win);
      Bounds : aliased Grect := Get_Bounds (Win_Layer);
   begin
      Font := Get_System_Font (To_Chars_Ptr (Font_Txt'Access));

      --  Canvas
      Center := Center_Point (Bounds'Access);
      Canvas_Layer := Create (Bounds);
      Set_Update_Proc (Canvas_Layer, Update_Canvas_Layer'Access);
      Add_Child (Win_Layer, Canvas_Layer);

      --  Icons bitmaps
      Icon_Tick := Create_With_Resource (Icon_Play_Resource_Id);
      Icon_Cross := Create_With_Resource (Icon_Menu_Resource_Id);

      --  Action bar
      Action_Layer := Create;
      Set_Icon (Action_Layer, Button_Id_Up, Icon_Tick);
      Set_Icon (Action_Layer, Button_Id_Down, Icon_Cross);
      Set_Click_Config_Provider (Action_Layer, Config_Provider'Access);
      Add_To_Window (Action_Layer, Main_Win);

      --  Ada bitmap
      Splash := Create_With_Resource (Splash_Resource_Id);
      Update_Time;
   end Load;

   procedure Unload (Win : Window) is
      pragma Unreferenced (Win);
   begin
      Destroy (Icon_Cross);
      Destroy (Icon_Tick);
      Destroy (Splash);
      Destroy (Canvas_Layer);
   end Unload;

   procedure Tick_Handler (arg1 : access Tm; arg2 : Time_Units) is
      pragma Unreferenced (arg1, arg2);
   begin
      Update_Time;
   end Tick_Handler;

   procedure Init is
      Unref : Boolean with Unreferenced;
   begin
      if not Game_Storage.Restore then
         Patris.Game_Reset;
      end if;

      Main_Win := Create;
      Set_Window_Handlers (Main_Win,
                           (Load => Load'Access,
                            Unload => Unload'Access,
                            others => null));
      Push (Main_Win, Animated => 1);

      Subscribe (Second_Unit, Tick_Handler'Access);
   end Init;

   procedure Deinit is
      Unref : Boolean with Unreferenced;
   begin
      Unref := Game_Storage.Store;
      Destroy (Main_Win);
   end Deinit;

   procedure Last_Chance_Handler is
      Str : aliased char_array := "In Last_Chance_Handler";
   begin
      Log (Log_Level    => Log_Level_Error,
           Src_Filename => Null_Ptr,
           Src_Line     => 0,
           Fmt          => To_Chars_Ptr (Str'Unchecked_Access));
   end Last_Chance_Handler;
end Main_Window;
