with Pebble.Ui.Windows; use Pebble.Ui.Windows;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;
with Pebble.Timer; use Pebble.Timer;
with Pebble.Ui.Windows.Stacks; use Pebble.Ui.Windows.Stacks;
with Pebble; use Pebble;
with System;
with Pebble.Ui.Clicks; use Pebble.Ui.Clicks;
with Strings_Interface; use Strings_Interface;
with Patris.Graphics; use Patris.Graphics;
with UI_Texts;
with Patris; use Patris;
with Patris.Utils; use Patris.Utils;
with Pebble.Ui.Lights;

package body Game_Window is

   Main_Win      : Window;
   Board_Layer   : Layer;
   Score_Layer   : Layer;
   Refresh_Timer : Apptimer;
   Font          : Gfont;

   procedure Load (Win : Window) with Convention => C;
   procedure Unload (Win : Window) with Convention => C;
   procedure Appear (Win : Window) with Convention => C;
   procedure Disappear (Win : Window) with Convention => C;
   procedure Update_Board_Layer (L : Layer; Ctx : Gcontext)
     with Convention => C;
   procedure Update_Score_Layer (L : Layer; Ctx : Gcontext)
     with Convention => C;
   procedure Timer_Tick (Context : System.Address) with Convention => C;
   procedure Config_Provider (Context : System.Address) with Convention => C;
   procedure Button_Handler (Recognizer : Clickrecognizerref;
                        Context : System.Address) with Convention => C;
   procedure Long_Button_Handler (Recognizer : Clickrecognizerref;
                                  Context : System.Address)
     with Convention => C;

   ---------------------
   -- Config_Provider --
   ---------------------

   procedure Config_Provider (Context : System.Address) is
      pragma Unreferenced (Context);
   begin
      Raw_Click_Subscribe (Button_Id_Up, Button_Handler'Access, null,
                           System.Null_Address);
      Raw_Click_Subscribe (Button_Id_Down, Button_Handler'Access, null,
                           System.Null_Address);
      Single_Repeating_Click_Subscribe (Button_Id_Select, 1000,
                                        Button_Handler'Access);
      Long_Click_Subscribe (Button_Id_Select, 0,
                            Long_Button_Handler'Access, null);
   end Config_Provider;

   --------------------
   -- Button_Handler --
   --------------------

   procedure Button_Handler (Recognizer : Clickrecognizerref;
                             Context : System.Address)
   is
      pragma Unreferenced (Context);
      Button : constant Buttonid := Get_Button_Id (Recognizer);
   begin
      if Is_Repeating (Recognizer) /= 0 then
         case Button is
         when others => null;
         end case;
      else
         case Button is
            when Button_Id_Up => Action_Request (Move_Left);
            when Button_Id_Down => Action_Request (Move_Right);
            when Button_Id_Select => Action_Request (Turn_Counter_Clockwise);
            when others => null;
         end case;
      end if;
   end Button_Handler;

   --------------------
   -- Button_Handler --
   --------------------

   procedure Long_Button_Handler (Recognizer : Clickrecognizerref;
                                  Context : System.Address)
   is
      pragma Unreferenced (Context);
      Button : constant Buttonid := Get_Button_Id (Recognizer);
   begin
      if Is_Repeating (Recognizer) /= 0 then
         case Button is
         when others => null;
         end case;
      else
         case Button is
            when Button_Id_Select => Action_Request (Move_Down);
            when others => null;
         end case;
      end if;
   end Long_Button_Handler;

   ------------------------
   -- Update_Board_Layer --
   ------------------------

   procedure Update_Board_Layer (L : Layer; Ctx : Gcontext) is
      pragma Unreferenced (L);
   begin
      Draw_Board (Ctx, Cur_Board);
      Draw_Walls (Ctx);
   end Update_Board_Layer;

   ------------------------
   -- Update_Score_Layer --
   ------------------------

   procedure Update_Score_Layer (L : Layer; Ctx : Gcontext) is
      Bounds : constant Grect := Get_Bounds (L);
      Next_Box : constant Grect :=
        ((5, 5), (Bounds.Size.W - 10, Bounds.Size.W - 10));
      Score_Box : Grect :=
        ((Next_Box.Origin.X, Next_Box.Origin.Y + Next_Box.Size.H + 5),
         Next_Box.Size);
      Level_Box : Grect :=
        ((Score_Box.Origin.X, Score_Box.Origin.Y + Score_Box.Size.H + 5),
         Next_Box.Size);
      Tmp_Txt : aliased char_array := "XXXXXX";
   begin
      --  Frames
      Set_Stroke_Color (Ctx, Frames_Color);
      Set_Stroke_Width (Ctx, 1);
      Draw_Round_Rect (Ctx, Bounds, Corners_Radius);
      Draw_Round_Rect (Ctx, Next_Box, Corners_Radius);
      Draw_Round_Rect (Ctx, Score_Box, Corners_Radius);
      Draw_Round_Rect (Ctx, Level_Box, Corners_Radius);

      --  Next piece
      Draw_Shape (Ctx, Center_Point (Next_Box),
                  (Next_Piece.S, Next_Piece.D, 0, 0),
                  Preview => True);

      --  Score
      Set_Text_Color (Ctx, Colors.White);
      Draw_Text (Ctx           => Ctx,
                 Text          => UI_Texts.Get_Str (UI_Texts.ID_Score),
                 Font          => Font,
                 Box           => Score_Box,
                 Overflow_Mode => Gtextoverflowmodefill,
                 Alignment     => Gtextalignmentcenter,
                 Cache         => Null_Cacheref);

      --  Adjust box for score number
      Score_Box := ((Score_Box.Origin.X, Score_Box.Origin.Y + 16),
                    (Score_Box.Size.W, Score_Box.Size.H - 16));

      To_String (Get_Score, Tmp_Txt);
      Draw_Text (Ctx           => Ctx,
                 Text          => To_Chars_Ptr (Tmp_Txt'Unchecked_Access),
                 Font          => Font,
                 Box           => Score_Box,
                 Overflow_Mode => Gtextoverflowmodefill,
                 Alignment     => Gtextalignmentcenter,
                 Cache         => Null_Cacheref);

      --  Level
      Set_Text_Color (Ctx, Colors.White);
      Draw_Text (Ctx           => Ctx,
                 Text          => UI_Texts.Get_Str (UI_Texts.ID_Level),
                 Font          => Font,
                 Box           => Level_Box,
                 Overflow_Mode => Gtextoverflowmodefill,
                 Alignment     => Gtextalignmentcenter,
                 Cache         => Null_Cacheref);

      --  Adjust box for Level number
      Level_Box := ((Level_Box.Origin.X, Level_Box.Origin.Y + 16),
                    (Level_Box.Size.W, Level_Box.Size.H - 16));

      To_String (Get_Level, Tmp_Txt);
      Draw_Text (Ctx           => Ctx,
                 Text          => To_Chars_Ptr (Tmp_Txt'Unchecked_Access),
                 Font          => Font,
                 Box           => Level_Box,
                 Overflow_Mode => Gtextoverflowmodefill,
                 Alignment     => Gtextalignmentcenter,
                 Cache         => Null_Cacheref);
   end Update_Score_Layer;

   ----------------
   -- Timer_Tick --
   ----------------

   procedure Timer_Tick (Context : System.Address) is
      pragma Unreferenced (Context);
      Ret : U_Bool with Unreferenced;
      Redraw_Board, Redraw_Score, Redraw_Current_Piece : Boolean;
   begin
      Game_Step (Redraw_Board, Redraw_Score, Redraw_Current_Piece);
      if Redraw_Board or else Redraw_Current_Piece then
         Mark_Dirty (Board_Layer);
      end if;
      if Redraw_Score then
         Mark_Dirty (Score_Layer);
      end if;

      Refresh_Timer := Register (Timout_Ms     => unsigned (Get_Step_Interval),
                                 Callback      => Timer_Tick'Access,
                                 Callback_Data => System.Null_Address);
   end Timer_Tick;

   ----------
   -- Load --
   ----------

   procedure Load (Win : Window) is
      pragma Unreferenced (Win);
      Win_Layer  : constant Layer := Get_Root_Layer (Main_Win);
      WRect : constant Grect := Get_Bounds (Win_Layer);
      Board_Rect, Score_Rect : Grect;

   begin

      Font := Get_System_Font (To_Chars_Ptr (Font_Txt'Access));

      Board_Rect := (WRect.Origin, (2 * (WRect.Size.W / 3), WRect.Size.H));
      Score_Rect := ((WRect.Origin.X + Board_Rect.Size.W, WRect.Origin.Y),
                          (WRect.Size.W / 3, WRect.Size.H));

      --  Button handler
      Set_Click_Config_Provider (Main_Win, Config_Provider'Access);

      --  Canvas
      Board_Layer := Create (Board_Rect);
      Set_Update_Proc (Board_Layer, Update_Board_Layer'Access);
      Add_Child (Win_Layer, Board_Layer);

      Score_Layer := Create (Score_Rect);
      Set_Update_Proc (Score_Layer, Update_Score_Layer'Access);
      Add_Child (Win_Layer, Score_Layer);

      Pebble.Ui.Lights.Enable (1);
   end Load;

   ------------
   -- Unload --
   ------------

   procedure Unload (Win : Window) is
      pragma Unreferenced (Win);
   begin
      Destroy (Board_Layer);
      Destroy (Score_Layer);
      Cancel (Refresh_Timer);
      Pebble.Ui.Lights.Enable (0);
   end Unload;

   ------------
   -- Appear --
   ------------

   procedure Appear (Win : Window) is
      pragma Unreferenced (Win);
   begin
      Pebble.Ui.Lights.Enable (1);
   end Appear;

   ---------------
   -- Disappear --
   ---------------

   procedure Disappear (Win : Window) is
      pragma Unreferenced (Win);
   begin
      Pebble.Ui.Lights.Enable (0);
   end Disappear;

   ----------
   -- Push --
   ----------

   procedure Push is
   begin
      if Main_Win = Null_Window then
         Main_Win := Create;
         Set_Background_Color (Main_Win, Colors.Black);
         Set_Window_Handlers (Main_Win,
                              (Load => Load'Access,
                               Unload => Unload'Access,
                               Appear => Appear'Access,
                               Disappear => Disappear'Access));
      end if;
      Push (Main_Win, Animated => 1);
      Timer_Tick (System.Null_Address);
   end Push;

end Game_Window;
