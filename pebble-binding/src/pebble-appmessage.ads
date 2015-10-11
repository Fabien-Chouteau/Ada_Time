with Pebble.Dictionary; use Pebble.Dictionary;
package Pebble.Appmessage is
   subtype App_Message_Result is unsigned;
   App_Msg_Ok                          : constant App_Message_Result := 0;
   App_Msg_Send_Timeout                : constant App_Message_Result := 2;
   App_Msg_Send_Rejected               : constant App_Message_Result := 4;
   App_Msg_Not_Connected               : constant App_Message_Result := 8;
   App_Msg_App_Not_Running             : constant App_Message_Result := 16;
   App_Msg_Invalid_Args                : constant App_Message_Result := 32;
   App_Msg_Busy                        : constant App_Message_Result := 64;
   App_Msg_Buffer_Overflow             : constant App_Message_Result := 128;
   App_Msg_Already_Released            : constant App_Message_Result := 512;
   App_Msg_Callback_Already_Registered : constant App_Message_Result := 1024;
   App_Msg_Callback_Not_Registered     : constant App_Message_Result := 2048;
   App_Msg_Out_Of_Memory               : constant App_Message_Result := 4096;
   App_Msg_Closed                      : constant App_Message_Result := 8192;
   App_Msg_Internal_Error              : constant App_Message_Result := 16384;
   --  pebble.h:1496

   function Open
     (Arg1 : Uint32_T;
      Arg2 : Uint32_T) return App_Message_Result;  -- pebble.h:1511
   pragma Import (C, Open, "app_message_open");

   procedure Deregister_Callbacks;  -- pebble.h:1515
   pragma Import (C, Deregister_Callbacks, "app_message_deregister_callbacks");

   type Inbox_Received_Callback is access procedure
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Opaque_Ptr);
   pragma Convention (C, Inbox_Received_Callback);  -- pebble.h:1528

   type Inbox_Dropped_Callback is access procedure
     (Arg1 : App_Message_Result;
      Arg2 : Opaque_Ptr);
   pragma Convention (C, Inbox_Dropped_Callback);  -- pebble.h:1542

   type Outbox_Sent_Callback is access procedure
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Opaque_Ptr);
   pragma Convention (C, Outbox_Sent_Callback);  -- pebble.h:1554

   type Outbox_Failed_Callback is access procedure
     (Arg1 : access Dictionary_Iterator;
      Arg2 : App_Message_Result;
      Arg3 : Opaque_Ptr);
   pragma Convention (C, Outbox_Failed_Callback);  -- pebble.h:1574

   function Get_Context return Opaque_Ptr;  -- pebble.h:1580
   pragma Import (C, Get_Context, "app_message_get_context");

   function Set_Context
     (Arg1 : Opaque_Ptr) return Opaque_Ptr;  -- pebble.h:1588
   pragma Import (C, Set_Context, "app_message_set_context");

   function Register_Inbox_Received
     (Received_Callback : Inbox_Received_Callback)
      return Inbox_Received_Callback;  -- pebble.h:1600
   pragma Import
     (C,
      Register_Inbox_Received,
      "app_message_register_inbox_received");

   function Register_Inbox_Dropped
     (Dropped_Callback : Inbox_Dropped_Callback)
     return Inbox_Dropped_Callback;  -- pebble.h:1612
   pragma Import
     (C,
      Register_Inbox_Dropped,
      "app_message_register_inbox_dropped");

   function Register_Outbox_Sent
     (Sent_Callback : Outbox_Sent_Callback)
     return Outbox_Sent_Callback;  -- pebble.h:1625
   pragma Import (C, Register_Outbox_Sent, "app_message_register_outbox_sent");

   function Register_Outbox_Failed
     (Failed_Callback : Outbox_Failed_Callback)
     return Outbox_Failed_Callback;  -- pebble.h:1638
   pragma Import
     (C,
      Register_Outbox_Failed,
      "app_message_register_outbox_failed");

   function Inbox_Size_Maximum return Uint32_T;  -- pebble.h:1647
   pragma Import (C, Inbox_Size_Maximum, "app_message_inbox_size_maximum");

   function Outbox_Size_Maximum return Uint32_T;  -- pebble.h:1656
   pragma Import (C, Outbox_Size_Maximum, "app_message_outbox_size_maximum");

   function Outbox_Begin
     (Arg1 : Opaque_Ptr) return App_Message_Result;  -- pebble.h:1670
   pragma Import (C, Outbox_Begin, "app_message_outbox_begin");

   function Outbox_Send return App_Message_Result;  -- pebble.h:1681
   pragma Import (C, Outbox_Send, "app_message_outbox_send");

   Inbox_Size_Minimum : constant := 124;  --  pebble.h:1688

   Outbox_Size_Minimum : constant := 636;  --  pebble.h:1695

end Pebble.Appmessage;
