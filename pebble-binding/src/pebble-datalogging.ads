package Pebble.Datalogging is
   type Data_Logging_Session is private;  -- pebble.h:745

   subtype Data_Logging_Item is unsigned;
   Data_Logging_Byte_Array : constant Data_Logging_Item := 0;
   Data_Logging_Uint       : constant Data_Logging_Item := 2;
   Data_Logging_Int        : constant Data_Logging_Item := 3;  -- pebble.h:758

   type Data_Logging_Result is
     (Data_Logging_Success,
      Data_Logging_Busy,
      Data_Logging_Full,
      Data_Logging_Not_Found,
      Data_Logging_Closed,
      Data_Logging_Invalid_Params,
      Data_Logging_Internal_Err);
   pragma Convention (C, Data_Logging_Result);  -- pebble.h:768

   function Create
     (Arg1 : Uint32_T;
      Arg2 : Data_Logging_Item;
      Arg3 : Uint16_T;
      Arg4 : U_Bool) return Data_Logging_Session;  -- pebble.h:779
   pragma Import (C, Create, "data_logging_create");

   procedure Finish (Arg1 : Data_Logging_Session);  -- pebble.h:788
   pragma Import (C, Finish, "data_logging_finish");

   function Log
     (Arg1 : Data_Logging_Session;
      Arg2 : Opaque_Ptr;
      Arg3 : Uint32_T) return Data_Logging_Result;  -- pebble.h:812
   pragma Import (C, Log, "data_logging_log");

private
   type Data_Logging_Session is new Opaque_Ptr;
end Pebble.Datalogging;
