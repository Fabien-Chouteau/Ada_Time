package Pebble.Eventservice.Batterystate is
   type Charge_State is record
      Charge_Percent : aliased Uint8_T;  -- pebble.h:411
      Is_Charging    : aliased U_Bool;  -- pebble.h:413
      Is_Plugged     : aliased U_Bool;  -- pebble.h:415
   end record;
   pragma Convention (C_Pass_By_Copy, Charge_State);  -- pebble.h:416

   type Battery_State_Handler is access procedure (State : Charge_State);
   pragma Convention (C, Battery_State_Handler);  -- pebble.h:420

   procedure Subscribe (Arg1 : Battery_State_Handler);  -- pebble.h:425
   pragma Import (C, Subscribe, "battery_state_service_subscribe");

   procedure Unsubscribe;  -- pebble.h:429
   pragma Import (C, Unsubscribe, "battery_state_service_unsubscribe");

   function Peek return Charge_State;  -- pebble.h:433
   pragma Import (C, Peek, "battery_state_service_peek");

end Pebble.Eventservice.Batterystate;
