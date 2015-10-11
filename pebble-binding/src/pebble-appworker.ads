package Pebble.Appworker is
   type Appworker_Result is
     (App_Worker_Result_Success,
      App_Worker_Result_No_Worker,
      App_Worker_Result_Different_App,
      App_Worker_Result_Not_Running,
      App_Worker_Result_Already_Running,
      App_Worker_Result_Asking_Confirmation);
   pragma Convention (C, Appworker_Result);  -- pebble.h:2033

   type Appworker_Message is record
      Data0 : aliased Uint16_T;  -- pebble.h:2037
      Data1 : aliased Uint16_T;  -- pebble.h:2038
      Data2 : aliased Uint16_T;  -- pebble.h:2039
   end record;
   pragma Convention (C_Pass_By_Copy, Appworker_Message);  -- pebble.h:2040

   function Is_Running return U_Bool;  -- pebble.h:2044
   pragma Import (C, Is_Running, "app_worker_is_running");

   function Launch return Appworker_Result;  -- pebble.h:2049
   pragma Import (C, Launch, "app_worker_launch");

   function Kill return Appworker_Result;  -- pebble.h:2054
   pragma Import (C, Kill, "app_worker_kill");

   type Message_Handler is access procedure
     (Arg1 : Uint16_T;
      Arg2 : access Appworker_Message);
   pragma Convention (C, Message_Handler);  -- pebble.h:2059

   function Message_Subscribe
     (Arg1 : Message_Handler) return U_Bool;  -- pebble.h:2065
   pragma Import (C, Message_Subscribe, "app_worker_message_subscribe");

   function Message_Unsubscribe return U_Bool;  -- pebble.h:2069
   pragma Import (C, Message_Unsubscribe, "app_worker_message_unsubscribe");

   procedure Send_Message
     (Arg1 : Uint8_T;
      Arg2 : access Appworker_Message);  -- pebble.h:2074
   pragma Import (C, Send_Message, "app_worker_send_message");

end Pebble.Appworker;
