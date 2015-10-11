package Pebble.Storage is

   Data_Max_Length : constant := 256;  --  pebble.h:2191

   subtype Statuscode is unsigned;
   S_Success            : constant Statuscode := 0;
   E_Error              : constant Statuscode := -1;
   E_Unknown            : constant Statuscode := -2;
   E_Internal           : constant Statuscode := -3;
   E_Invalid_Argument   : constant Statuscode := -4;
   E_Out_Of_Memory      : constant Statuscode := -5;
   E_Out_Of_Storage     : constant Statuscode := -6;
   E_Out_Of_Resources   : constant Statuscode := -7;
   E_Range              : constant Statuscode := -8;
   E_Does_Not_Exist     : constant Statuscode := -9;
   E_Invalid_Operation  : constant Statuscode := -10;
   E_Busy               : constant Statuscode := -11;
   E_Again              : constant Statuscode := -12;
   S_True               : constant Statuscode := 1;
   S_False              : constant Statuscode := 0;
   S_No_More_Items      : constant Statuscode := 2;
   S_No_Action_Required : constant Statuscode := 3;  -- pebble.h:2197

   subtype Status_T is Int32_T;  -- pebble.h:2252

   function Exists (Key : Uint32_T) return U_Bool;  -- pebble.h:2257
   pragma Import (C, Exists, "persist_exists");

   function Get_Size (Key : Uint32_T) return int;  -- pebble.h:2263
   pragma Import (C, Get_Size, "persist_get_size");

   function Read_Bool (Key : Uint32_T) return U_Bool;  -- pebble.h:2269
   pragma Import (C, Read_Bool, "persist_read_bool");

   function Read_Int (Key : Uint32_T) return Int32_T;  -- pebble.h:2276
   pragma Import (C, Read_Int, "persist_read_int");

   function Read_Data
     (Key         : Uint32_T;
      Buffer      : Opaque_Ptr;
      Buffer_Size : Size_T) return int;  -- pebble.h:2285
   pragma Import (C, Read_Data, "persist_read_data");

   function Read_String
     (Key         : Uint32_T;
      Buffer      : Strings_Interface.Chars_Ptr;
      Buffer_Size : Size_T) return int;  -- pebble.h:2295
   pragma Import (C, Read_String, "persist_read_string");

   function Write_Bool
     (Key   : Uint32_T;
      Value : U_Bool) return Status_T;  -- pebble.h:2300
   pragma Import (C, Write_Bool, "persist_write_bool");

   function Write_Int
     (Key   : Uint32_T;
      Value : Int32_T) return Status_T;  -- pebble.h:2306
   pragma Import (C, Write_Int, "persist_write_int");

   function Write_Data
     (Key         : Uint32_T;
      Buffer      : Opaque_Ptr;
      Buffer_Size : Size_T) return int;  -- pebble.h:2314
   pragma Import (C, Write_Data, "persist_write_data");

   function Write_String
     (Key    : Uint32_T;
      String : Strings_Interface.Chars_Ptr) return int;  -- pebble.h:2321
   pragma Import (C, Write_String, "persist_write_string");

   function Delete (Key : Uint32_T) return Status_T;  -- pebble.h:2325
   pragma Import (C, Delete, "persist_delete");

end Pebble.Storage;
