package Pebble.Timer is
   procedure Psleep (Arg1 : int);  -- pebble.h:2124
   pragma Import (C, Psleep, "psleep");

   type Apptimer is private;

   type Apptimercallback is access procedure (Context : Opaque_Ptr);
   pragma Convention (C, Apptimercallback);  -- pebble.h:2131

   function Register
     (Timout_Ms     : Uint32_T;
      Callback      : Apptimercallback;
      Callback_Data : Opaque_Ptr) return Apptimer;  -- pebble.h:2138
   pragma Import (C, Register, "app_timer_register");

   function Reschedule
     (Timer      : Apptimer;
      Timeout_Ms : Uint32_T) return U_Bool;  -- pebble.h:2144
   pragma Import (C, Reschedule, "app_timer_reschedule");

   procedure Cancel (Timer : Apptimer);  -- pebble.h:2148
   pragma Import (C, Cancel, "app_timer_cancel");

private
   type Apptimer is new Opaque_Ptr;
end Pebble.Timer;
