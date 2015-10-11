package Pebble.Walltime is
   type Weekday is
     (Today, Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday);
   pragma Convention (C, Weekday);  -- pebble.h:295

   procedure Copy_Time_String
     (Buffer : Strings_Interface.Chars_Ptr;
      Size   : Uint8_T);  -- pebble.h:303
   pragma Import (C, Copy_Time_String, "clock_copy_time_string");

   function Is_24h_Style return U_Bool;  -- pebble.h:308
   pragma Import (C, Is_24h_Style, "clock_is_24h_style");

   function To_Timestamp
     (Day    : Weekday;
      Hour   : int;
      Minute : int) return Time_T;  -- pebble.h:319
   pragma Import (C, To_Timestamp, "clock_to_timestamp");

   function Is_Timezone_Set return U_Bool;  -- pebble.h:323
   pragma Import (C, Is_Timezone_Set, "clock_is_timezone_set");

   Timezone_Name_Length : constant := 32;  --  pebble.h:326
   procedure Get_Timezone
     (Buffer : Strings_Interface.Chars_Ptr;
      Size   : Size_T);  -- pebble.h:333
   pragma Import (C, Get_Timezone, "clock_get_timezone");

end Pebble.Walltime;
