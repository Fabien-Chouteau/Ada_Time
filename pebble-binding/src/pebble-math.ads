package Pebble.Math is
   function Sin_Lookup (Arg1 : Int32_T) return Int32_T;  -- pebble.h:264
   pragma Import (C, Sin_Lookup, "sin_lookup");

   function Cos_Lookup (Arg1 : Int32_T) return Int32_T;  -- pebble.h:270
   pragma Import (C, Cos_Lookup, "cos_lookup");

   function Atan2_Lookup
     (Arg1 : Int16_T;
      Arg2 : Int16_T) return Int32_T;  -- pebble.h:274
   pragma Import (C, Atan2_Lookup, "atan2_lookup");

end Pebble.Math;
