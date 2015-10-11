package Pebble.Wakeup is
   subtype Wakeup_Id is Int32_T;  -- pebble.h:2334

   type Wakeup_Handler is access procedure (Id : Wakeup_Id; Cookie : Int32_T);
   pragma Convention (C, Wakeup_Handler);  -- pebble.h:2339

   procedure Subscribe (Handler : Wakeup_Handler);  -- pebble.h:2343
   pragma Import (C, Subscribe, "wakeup_service_subscribe");

   function Schedule
     (Timestamp        : Time_T;
      Cookie           : Int32_T;
      Notify_If_Missed : U_Bool) return Wakeup_Id;  -- pebble.h:2358
   pragma Import (C, Schedule, "wakeup_schedule");

   procedure Cancel (Id : Wakeup_Id);  -- pebble.h:2362
   pragma Import (C, Cancel, "wakeup_cancel");

   procedure Cancel_All;  -- pebble.h:2365
   pragma Import (C, Cancel_All, "wakeup_cancel_all");

   function Wakeup_Get_Launch_Event
     (Id     : access Wakeup_Id;
      Cookie : access Int32_T) return U_Bool;  -- pebble.h:2373
   pragma Import (C, Wakeup_Get_Launch_Event, "wakeup_get_launch_event");

   function Query
     (Id       : Wakeup_Id;
      Timestap : access Time_T) return U_Bool;  -- pebble.h:2384
   pragma Import (C, Query, "wakeup_query");

end Pebble.Wakeup;
