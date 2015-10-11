package Pebble.Logging is

   subtype Apploglevel is Uint8_T;
   Log_Level_Error         : constant Apploglevel := 1;
   Log_Level_Warning       : constant Apploglevel := 50;
   Log_Level_Info          : constant Apploglevel := 100;
   Log_Level_Debug         : constant Apploglevel := 200;
   Log_Level_Debug_Verbose : constant Apploglevel := 255;  -- pebble.h:921

   procedure Log
     (Log_Level    : Apploglevel;
      Src_Filename : Strings_Interface.Chars_Ptr;
      Src_Line     : int;
      Fmt          : Strings_Interface.Chars_Ptr);  -- pebble.h:899
   pragma Import (C, Log, "app_log");

end Pebble.Logging;
