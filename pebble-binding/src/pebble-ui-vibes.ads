package Pebble.Ui.Vibes is

   type Duration_Array is array (Natural range <>) of Uint32_T;
   type Vibepattern is record
      Durations    : access Duration_Array;  -- pebble.h:6526
      Num_Segments : aliased Uint32_T;  -- pebble.h:6530
   end record;
   pragma Convention (C_Pass_By_Copy, Vibepattern);  -- pebble.h:6531

   procedure Cancel;  -- pebble.h:6535
   pragma Import (C, Cancel, "vibes_cancel");

   procedure Short_Pulse;  -- pebble.h:6538
   pragma Import (C, Short_Pulse, "vibes_short_pulse");

   procedure Long_Pulse;  -- pebble.h:6541
   pragma Import (C, Long_Pulse, "vibes_long_pulse");

   procedure Double_Pulse;  -- pebble.h:6545
   pragma Import (C, Double_Pulse, "vibes_double_pulse");

   procedure Enqueue_Custom_Pattern (Pattern : Vibepattern);  -- pebble.h:6550
   pragma Import (C, Enqueue_Custom_Pattern, "vibes_enqueue_custom_pattern");

end Pebble.Ui.Vibes;
