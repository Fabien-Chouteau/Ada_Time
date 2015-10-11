package Pebble.Eventservice.Bluetoothconnection is
   type Bluetooth_Connection_Handler is access procedure (Arg1 : U_Bool);
   pragma Convention (C, Bluetooth_Connection_Handler);  -- pebble.h:350

   function Peek return U_Bool;  -- pebble.h:354
   pragma Import (C, Peek, "bluetooth_connection_service_peek");

   procedure Subscribe
     (Handler : Bluetooth_Connection_Handler);  -- pebble.h:359
   pragma Import (C, Subscribe, "bluetooth_connection_service_subscribe");

   procedure Unsubscribe;  -- pebble.h:363
   pragma Import (C, Unsubscribe, "bluetooth_connection_service_unsubscribe");

end Pebble.Eventservice.Bluetoothconnection;
