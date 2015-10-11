with Pebble.Ui.Windows; use Pebble.Ui.Windows;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;
with Pebble.Graphics; use Pebble.Graphics;
with Pebble.Ui.Windows.Stacks; use Pebble.Ui.Windows.Stacks;
with Pebble; use Pebble;
with System;
with Interfaces.C; use Interfaces.C;
with Strings_Interface; use Strings_Interface;
with Pebble.Menulayers; use Pebble.Menulayers;
with Pebble.Numberwindows; use Pebble.Numberwindows;
with Patris.Graphics; use Patris.Graphics;
with UI_Texts;
with Confirm_Windows; use Confirm_Windows;
with Patris.Utils; use Patris.Utils;
with Patris; use Patris;
with Game_Window;

package body Menu_Window is

   Frames_Color     : constant Gcolor := Colors.Blue;
   pragma Unreferenced (Frames_Color);
   Main_Win         : Window;
   Menu_Layer       : Menulayers.Menulayer;
   Num_Win          : Number_Window;
   Confirm          : Confirm_Window;

   function Get_Number_Of_Sections
     (ML : Menulayer;
      Context : System.Address) return Uint16_T with Convention => C;
   function Get_Number_Of_Rows_In_Sections
     (ML : Menulayer;
      Section_Index : Uint16_T;
      Context : System.Address) return Uint16_T with Convention => C;
   function Get_Header_Height
     (ML : Menulayer;
      Section_Index : Uint16_T;
      Context : System.Address) return Int16_T with Convention => C;
   function Get_Separator_Height
     (ML : Menulayer;
      Cell_Index : access Menuindex;
      Context : System.Address) return Int16_T with Convention => C;
   procedure Draw_Row
     (Ctx : Gcontext;
      Cell_Layer : Layer;
      Cell_Index : access Menuindex;
      Context : System.Address) with Convention => C;
   procedure Draw_Header
     (Ctx : Gcontext;
      Cell_Layer : Layer;
      Section_Index : Uint16_T;
      Context : System.Address) with Convention => C;
   procedure Draw_Separator
     (Ctx : Gcontext;
      Cell_Layer : Layer;
      Cell_Index : access Menuindex;
      Context : System.Address) with Convention => C;
   procedure Select_Callback
     (ML : Menulayer;
      Cell_Index : access Menuindex;
      Context : System.Address) with Convention => C;
   procedure Draw_Background
     (Ctx : Gcontext;
      Bg_Layer : Layer;
      HighLight : U_Bool;
      Context : System.Address) with Convention => C;
   pragma Unreferenced (Draw_Background);

   Menulayer_callbacks : aliased constant Menulayercallbacks :=
     (Get_Num_Sections => Get_Number_Of_Sections'Access,
      Get_Num_Rows => Get_Number_Of_Rows_In_Sections'Access,
      Get_Cell_Height => null,
      Get_Header_Height => Get_Header_Height'Access,
      Draw_Row => Draw_Row'Access,
      Draw_Header => Draw_Header'Access,
      Select_Click => Select_Callback'Access,
      Select_Long_Click => null,
      Selection_Changed => null,
      Get_Separator_Height => Get_Separator_Height'Access,
      Draw_Separator => Draw_Separator'Access,
      Selection_Will_Change => null,
      Draw_Background => null
     );

   procedure Number_Window_Selected
     (Nw      : Number_Window;
      Context : System.Address) with Convention => C;
   procedure Confirm_Handler (Cw : Confirm_Window; Confirmed : Boolean);
   procedure Load (Win : Window) with Convention => C;
   procedure Unload (Win : Window) with Convention => C;
   procedure Appear (Win : Window) with Convention => C;
   procedure Disappear (Win : Window) with Convention => C;

   function Get_Number_Of_Sections
     (ML : Menulayer;
      Context : System.Address) return Uint16_T is
      pragma Unreferenced (ML, Context);
   begin
      return 1;
   end Get_Number_Of_Sections;

   function Get_Number_Of_Rows_In_Sections
     (ML : Menulayer;
      Section_Index : Uint16_T;
      Context : System.Address) return Uint16_T is
      pragma Unreferenced (ML, Context);
   begin
      case Section_Index is
         when 0 => return 3;
         when others => return 0;
      end case;
   end Get_Number_Of_Rows_In_Sections;

   function Get_Header_Height
     (ML : Menulayer;
      Section_Index : Uint16_T;
      Context : System.Address) return Int16_T is
      pragma Unreferenced (ML, Section_Index, Context);
   begin
      return Menu_Cell_Basic_Header_Height;
   end Get_Header_Height;
   function Get_Separator_Height
     (ML : Menulayer;
      Cell_Index : access Menuindex;
      Context : System.Address) return Int16_T is
      pragma Unreferenced (ML, Cell_Index, Context);
   begin
      return Rect_Size;
   end Get_Separator_Height;

   procedure Draw_Header
     (Ctx : Gcontext;
      Cell_Layer : Layer;
      Section_Index : Uint16_T;
      Context : System.Address) is
      pragma Unreferenced (Context);
   begin
      case Section_Index is
         when 0 =>
            Menu_Cell_Basic_Header_Draw
              (Ctx, Cell_Layer, UI_Texts.Get_Str (UI_Texts.ID_Menu));
         when others => null;
      end case;
   end Draw_Header;

   procedure Draw_Row
     (Ctx : Gcontext;
      Cell_Layer : Layer;
      Cell_Index : access Menuindex;
      Context : System.Address) is
      pragma Unreferenced (Context);
   begin
      case Cell_Index.Section is
         when 0 =>
            case Cell_Index.Row is
            when 0 =>
               declare
                  Tmp_Txt : aliased char_array := "XXXXXX";
               begin
                  To_String (Get_Level, Tmp_Txt);
                  Basic_Draw (Ctx, Cell_Layer,
                              UI_Texts.Get_Str (UI_Texts.ID_Change_Level),
                              To_Chars_Ptr (Tmp_Txt'Unchecked_Access),
                              System.Null_Address);
               end;
            when 1 =>
               Basic_Draw (Ctx, Cell_Layer,
                           UI_Texts.Get_Str (UI_Texts.ID_Reset),
                           UI_Texts.Get_Str (UI_Texts.ID_Reset_Game_Long),
                           System.Null_Address);
            when 2 =>
               declare
               begin
                  Basic_Draw (Ctx, Cell_Layer,
                              UI_Texts.Get_Str (UI_Texts.ID_About),
                              To_Chars_Ptr
                                (Game_Window.Version_Txt'Unchecked_Access),
                              System.Null_Address);
               end;
            when others => null;
            end case;
         when others => null;
      end case;
   end Draw_Row;

   procedure Draw_Separator
     (Ctx : Gcontext;
      Cell_Layer : Layer;
      Cell_Index : access Menuindex;
      Context : System.Address) is
      pragma Unreferenced (Cell_Index, Context);
      Box : constant Grect := Get_Bounds (Cell_Layer);
   begin
      Set_Fill_Color (Ctx, Colors.Black);
      Fill_Rect (Ctx, (Box.Origin, (Box.Size.W, Rect_Size)), 0, Gcornernone);

      for Cnt in 0 .. (Box.Size.W / Rect_Size) - 1 loop
         Draw_Shape_Rect (Ctx,
                          (Box.Origin.X + Cnt * Rect_Size, Box.Origin.Y),
                          Walls_Colors);
      end loop;
   end Draw_Separator;
   procedure Select_Callback
     (ML : Menulayer;
      Cell_Index : access Menuindex;
      Context : System.Address) is
      pragma Unreferenced (ML, Context);
   begin
      if Cell_Index.Section /= 0 then
         return;
      end if;
      case Cell_Index.Row is
         when 0 =>
            --  We can't let the user select a lower level than the current one
            --  otherwise it would be easy to go to the menu a lower the level
            --  in the middle of a game.
            Set_Min (Num_Win, Interfaces.C.int (Get_Level));
            Set_Value (Num_Win, Interfaces.C.int (Get_Level));
            Push (Get_Window (Num_Win), 1);
         when 1 =>
            Push (Get_Window (Confirm), 1);
         when others => null;
      end case;
   end Select_Callback;
   procedure Draw_Background
     (Ctx : Gcontext;
      Bg_Layer : Layer;
      HighLight : U_Bool;
      Context : System.Address) is
   begin
      null;
   end Draw_Background;

   procedure Number_Window_Selected
     (Nw      : Number_Window;
      Context : System.Address)
   is
      pragma Unreferenced (Nw, Context);
      Unref : Window with Unreferenced;
   begin
      Set_Level (Score_T (Get_Value (Num_Win)));
      Unref := Pop (1);
   end Number_Window_Selected;

   procedure Confirm_Handler (Cw : Confirm_Window; Confirmed : Boolean) is
      pragma Unreferenced (Cw);
      Unref : Window with Unreferenced;
   begin
      if Confirmed then
         Game_Reset;
      end if;
      Unref := Pop (1);
   end Confirm_Handler;

   ----------
   -- Load --
   ----------

   procedure Load (Win : Window) is
      pragma Unreferenced (Win);
      Win_Layer  : constant Layer := Get_Root_Layer (Main_Win);
      WRect : constant Grect := Get_Bounds (Win_Layer);

   begin
      Menu_Layer := Create (WRect);
      Set_Callbacks (Menu_Layer,
                     System.Null_Address,
                     Menulayer_callbacks);
      Set_Click_Config_Onto_Window (Menu_Layer, Main_Win);
      Set_Normal_Colors (Menu_Layer,
                         Background => Colors.White,
                         Foreground => Colors.Black);
      Set_Highlight_Colors (Menu_Layer,
                            Background => Colors.Black,
                            Foreground => Colors.White);
      Pad_Bottom_Enable (Menu_Layer, 1);
      Add_Child (Win_Layer, Get_Layer (Menu_Layer));

      --  Number window
      Num_Win := Create
        (Label     => UI_Texts.Get_Str (UI_Texts.ID_Level),
         Callbacks => (Selected => Number_Window_Selected'Access,
                       others => null),
         Context   => System.Null_Address);
      Set_Min (Num_Win, 0);
      Set_Max (Num_Win, 10);
      Set_Step_Size (Num_Win, 1);

      --  Confirmation window
      Confirm := Create (Confirm_Handler'Access);
   end Load;

   ------------
   -- Unload --
   ------------

   procedure Unload (Win : Window) is
      pragma Unreferenced (Win);
   begin
      Destroy (Menu_Layer);
      Destroy (Num_Win);
      Destroy (Confirm);
   end Unload;

   ------------
   -- Appear --
   ------------

   procedure Appear (Win : Window) is
   begin
      null;
   end Appear;

   ---------------
   -- Disappear --
   ---------------

   procedure Disappear (Win : Window) is
   begin
      null;
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
   end Push;

end Menu_Window;
