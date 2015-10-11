package Pebble.Eventservice.Ticktimer is
   subtype Time_Units is unsigned;
   Second_Unit : constant Time_Units := 1;
   Minute_Unit : constant Time_Units := 2;
   Hour_Unit   : constant Time_Units := 4;
   Day_Unit    : constant Time_Units := 8;
   Month_Unit  : constant Time_Units := 16;
   Year_Unit   : constant Time_Units := 32;  -- pebble.h:678

   type Tick_Handler is access procedure (Arg1 : access Tm; Arg2 : Time_Units);
   pragma Convention (C, Tick_Handler);  -- pebble.h:683

   procedure Subscribe
     (Tick_Unit : Time_Units;
      Handler   : Tick_Handler);  -- pebble.h:691
   pragma Import (C, Subscribe, "tick_timer_service_subscribe");

   procedure Unsubscribe;  -- pebble.h:695
   pragma Import (C, Unsubscribe, "tick_timer_service_unsubscribe");

end Pebble.Eventservice.Ticktimer;
