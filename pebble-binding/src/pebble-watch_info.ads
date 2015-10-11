package Pebble.Watch_Info is
   type Watchinfomodel is
     (Watch_Info_Model_Unknown,
      Watch_Info_Model_Pebble_Original,
      Watch_Info_Model_Pebble_Steel,
      Watch_Info_Model_Pebble_Time,
      Watch_Info_Model_Pebble_Time_Steel);
   pragma Convention (C, Watchinfomodel);  -- pebble.h:203

   type Watchinfocolor is
     (Watch_Info_Color_Unknown,
      Watch_Info_Color_Black,
      Watch_Info_Color_White,
      Watch_Info_Color_Red,
      Watch_Info_Color_Orange,
      Watch_Info_Color_Gray,
      Watch_Info_Color_Stainless_Steel,
      Watch_Info_Color_Matte_Black,
      Watch_Info_Color_Blue,
      Watch_Info_Color_Green,
      Watch_Info_Color_Pink,
      Watch_Info_Color_Time_White,
      Watch_Info_Color_Time_Black,
      Watch_Info_Color_Time_Red,
      Watch_Info_Color_Time_Steel_Silver,
      Watch_Info_Color_Time_Steel_Black,
      Watch_Info_Color_Time_Steel_Gold);
   pragma Convention (C, Watchinfocolor);  -- pebble.h:224

   type Watchinfoversion is record
      Major : aliased Uint8_T;  -- pebble.h:230
      Minor : aliased Uint8_T;  -- pebble.h:231
      Patch : aliased Uint8_T;  -- pebble.h:232
   end record;
   pragma Convention (C_Pass_By_Copy, Watchinfoversion);  -- pebble.h:233

   function Get_Model return Watchinfomodel;  -- pebble.h:237
   pragma Import (C, Get_Model, "watch_info_get_model");

   function Get_Firmware_Version return Watchinfoversion;  -- pebble.h:241
   pragma Import (C, Get_Firmware_Version, "watch_info_get_firmware_version");

   function Get_Color return Watchinfocolor;  -- pebble.h:245
   pragma Import (C, Get_Color, "watch_info_get_color");

end Pebble.Watch_Info;
