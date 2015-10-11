package Pebble.Eventservice.Compass is
   type Magdata is record
      X : aliased Int16_T;  -- pebble.h:586
      Y : aliased Int16_T;  -- pebble.h:588
      Z : aliased Int16_T;  -- pebble.h:590
   end record;
   pragma Convention (C_Pass_By_Copy, Magdata);  -- pebble.h:591

   type Compass_Status is
     (Compassstatusdatainvalid,
      Compassstatuscalibrating,
      Compassstatuscalibrated);
   pragma Convention (C, Compass_Status);  -- pebble.h:601

   subtype Heading is Int32_T;  -- pebble.h:606

   type Heading_Data is record
      Magnetic_Heading     : aliased Heading;  -- pebble.h:611
      True_Heading         : aliased Heading;  -- pebble.h:614
      Status               : aliased Compass_Status;  -- pebble.h:616
      Is_Declination_Valid : aliased U_Bool;  -- pebble.h:618
   end record;
   pragma Convention (C_Pass_By_Copy, Heading_Data);  -- pebble.h:619

   type Heading_Handler is access procedure (Arg1 : Heading_Data);
   pragma Convention (C, Heading_Handler);  -- pebble.h:623

   function Set_Heading_Filter (Filter : Heading) return int;  -- pebble.h:633
   pragma Import (C, Set_Heading_Filter, "compass_service_set_heading_filter");

   procedure Subscribe (Handler : Heading_Handler);  -- pebble.h:641
   pragma Import (C, Subscribe, "compass_service_subscribe");

   procedure Unsubscribe;  -- pebble.h:646
   pragma Import (C, Unsubscribe, "compass_service_unsubscribe");

   function Peek
     (Data : not null access Heading_Data) return int;  -- pebble.h:651
   pragma Import (C, Peek, "compass_service_peek");

end Pebble.Eventservice.Compass;
