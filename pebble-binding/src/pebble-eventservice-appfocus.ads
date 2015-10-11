package Pebble.Eventservice.Appfocus is
   type Focus_Handler is access procedure (In_Focus : U_Bool);
   pragma Convention (C, Focus_Handler);  -- pebble.h:379

   procedure Subscribe (Handler : Focus_Handler);  -- pebble.h:388
   pragma Import (C, Subscribe, "app_focus_service_subscribe");

   procedure Unsubscribe;  -- pebble.h:392
   pragma Import (C, Unsubscribe, "app_focus_service_unsubscribe");

end Pebble.Eventservice.Appfocus;
