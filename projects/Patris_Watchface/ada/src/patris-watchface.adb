with Pebble; use Pebble;
with System;
with Pebble.Ui.Windows; use Pebble.Ui.Windows;
with Pebble.Ui.Windows.Stacks; use Pebble.Ui.Windows.Stacks;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;
with Pebble.Graphics; use Pebble.Graphics;
with Pebble.Eventservice.Ticktimer; use Pebble.Eventservice.Ticktimer;
with Patris.Clock; use Patris.Clock;
with Pebble.Timer; use Pebble.Timer;

package body Patris.Watchface is

   Main_Win : Window;
   Canvas_Layer : Layer;
   Last_Digits : array (Digit) of Value := (others => 0);

   procedure Load (Win : Window) with Convention => C;
   procedure Unload (Win : Window) with Convention => C;
   procedure Appear (Win : Window) with Convention => C;
   procedure Disappear (Win : Window) with Convention => C;
   procedure Minute_Handler (Tick_Time : access Tm; arg2 : Time_Units)
     with Convention => C;
   procedure Update_Canvas_Layer (L : Layer; Ctx : Gcontext)
     with Convention => C;
   procedure Step_Tick (Context : System.Address) with Convention => C;

   ----------------
   -- Step_Tick --
   ----------------

   procedure Step_Tick (Context : System.Address) is
      pragma Unreferenced (Context);
      Refresh_Timer : Apptimer;
      pragma Unreferenced (Refresh_Timer);
   begin
      Mark_Dirty (Canvas_Layer);
      if Patris.Clock.Step then
         Refresh_Timer := Register (Timout_Ms     => 50,
                                    Callback      => Step_Tick'Access,
                                    Callback_Data => System.Null_Address);
      end if;
   end Step_Tick;

   -------------------------
   -- Update_Canvas_Layer --
   -------------------------

   procedure Update_Canvas_Layer (L : Layer; Ctx : Gcontext) is
      pragma Unreferenced (L);
   begin
      Patris.Clock.Draw (Ctx);
   end Update_Canvas_Layer;

   ----------
   -- Load --
   ----------

   procedure Load (Win : Window) is
      pragma Unreferenced (Win);
      Win_Layer  : constant Layer := Get_Root_Layer (Main_Win);
      Bounds : aliased constant Grect := Get_Bounds (Win_Layer);
   begin
      --  Canvas
      Canvas_Layer := Create (Bounds);
      Set_Update_Proc (Canvas_Layer, Update_Canvas_Layer'Access);
      Add_Child (Win_Layer, Canvas_Layer);

      Drop (0, 0);
      Drop (1, 0);
      Drop (2, 0);
      Drop (3, 0);
      Last_Digits := (others => 0);
      Step_Tick (System.Null_Address);
   end Load;

   ------------
   -- Unload --
   ------------

   procedure Unload (Win : Window) is
      pragma Unreferenced (Win);
   begin
      Destroy (Canvas_Layer);
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

   --------------------
   -- Minute_Handler --
   --------------------

   procedure Minute_Handler (Tick_Time : access Tm; arg2 : Time_Units) is
      pragma Unreferenced (arg2);

   begin
      if Value (Tick_Time.Tm_Min mod 10) /= Last_Digits (3) then
         Last_Digits (3) := Value (Tick_Time.Tm_Min mod 10);
         Drop (3, Last_Digits (3));
      end if;
      if Value (Tick_Time.Tm_Min / 10) /= Last_Digits (2) then
         Last_Digits (2) := Value (Tick_Time.Tm_Min / 10);
         Drop (2, Last_Digits (2));
      end if;
      if Value (Tick_Time.Tm_Hour mod 10) /= Last_Digits (1) then
         Last_Digits (1) := Value (Tick_Time.Tm_Hour mod 10);
         Drop (1, Last_Digits (1));
      end if;
      if Value (Tick_Time.Tm_Hour / 10) /= Last_Digits (0) then
         Last_Digits (0) := Value (Tick_Time.Tm_Hour / 10);
         Drop (0, Last_Digits (0));
      end if;
      Step_Tick (System.Null_Address);
   end Minute_Handler;

   ----------
   -- Init --
   ----------

   procedure Init is
   begin
      Main_Win := Create;
      Set_Background_Color (Main_Win, Colors.Black);
      Set_Window_Handlers (Main_Win,
                           (Load      => Load'Access,
                            Unload    => Unload'Access,
                            Appear    => Appear'Access,
                            Disappear => Disappear'Access));
      Push (Main_Win, Animated => 1);

      Subscribe (Minute_Unit, Minute_Handler'Access);
   end Init;

   ------------
   -- Deinit --
   ------------

   procedure Deinit is
   begin
      Destroy (Main_Win);
   end Deinit;

   -------------------------
   -- Last_Chance_Handler --
   -------------------------

   procedure Last_Chance_Handler is
   begin
      null;
   end Last_Chance_Handler;
end Patris.Watchface;
