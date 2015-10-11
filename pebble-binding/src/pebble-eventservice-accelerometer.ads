package Pebble.Eventservice.Accelerometer is
   type Accel_Data is record
      X           : aliased Int16_T;  -- pebble.h:453
      Y           : aliased Int16_T;  -- pebble.h:455
      Z           : aliased Int16_T;  -- pebble.h:457
      Did_Vibrate : aliased U_Bool;  -- pebble.h:460
      Timestamp   : aliased Uint64_T;  -- pebble.h:463
   end record;
   pragma Convention (C_Pass_By_Copy, Accel_Data);  -- pebble.h:451

   type Accel_Raw_Data is record
      X : aliased Int16_T;  -- pebble.h:469
      Y : aliased Int16_T;  -- pebble.h:471
      Z : aliased Int16_T;  -- pebble.h:473
   end record;
   pragma Convention (C_Pass_By_Copy, Accel_Raw_Data);  -- pebble.h:474

   type Axis_Type is (Accel_Axis_X, Accel_Axis_Y, Accel_Axis_Z);
   pragma Convention (C, Axis_Type);  -- pebble.h:487

   type Data_Handler is access procedure
     (Arg1 : access Accel_Data;
      Arg2 : Uint32_T);
   pragma Convention (C, Data_Handler);  -- pebble.h:492

   type Raw_Data_Handler is access procedure
     (Arg1 : access Accel_Raw_Data;
      Arg2 : Uint32_T;
      Arg3 : Uint64_T);
   pragma Convention (C, Raw_Data_Handler);  -- pebble.h:498

   type Tap_Handler is access procedure (Arg1 : Axis_Type; Arg2 : Int32_T);
   pragma Convention (C, Tap_Handler);  -- pebble.h:503

   subtype Sampling_Rate is unsigned;
   Accel_Sampling_10hz  : constant Sampling_Rate := 10;
   Accel_Sampling_25hz  : constant Sampling_Rate := 25;
   Accel_Sampling_50hz  : constant Sampling_Rate := 50;
   Accel_Sampling_100hz : constant Sampling_Rate := 100;  -- pebble.h:515

   function Service_Peek
     (Arg1 : access Accel_Data) return int;  -- pebble.h:522
   pragma Import (C, Service_Peek, "accel_service_peek");

   function Service_Set_Sampling_Rate
     (Rate : Sampling_Rate) return int;  -- pebble.h:526
   pragma Import
     (C,
      Service_Set_Sampling_Rate,
      "accel_service_set_sampling_rate");

   function Service_Set_Samples_Per_Update
     (Sample_Per_Update : Uint32_T) return int;  -- pebble.h:530
   pragma Import
     (C,
      Service_Set_Samples_Per_Update,
      "accel_service_set_samples_per_update");

   procedure Data_Service_Subscribe
     (Samples_Per_Update : Uint32_T;
      Handler            : Data_Handler);  -- pebble.h:537
   pragma Import (C, Data_Service_Subscribe, "accel_data_service_subscribe");

   procedure Data_Service_Unsubscribe;  -- pebble.h:541
   pragma Import
     (C,
      Data_Service_Unsubscribe,
      "accel_data_service_unsubscribe");

   procedure Tap_Service_Subscribe (Handler : Tap_Handler);  -- pebble.h:546
   pragma Import (C, Tap_Service_Subscribe, "accel_tap_service_subscribe");

   procedure Tap_Service_Unsubscribe;  -- pebble.h:550
   pragma Import (C, Tap_Service_Unsubscribe, "accel_tap_service_unsubscribe");

   procedure Raw_Data_Service_Subscribe
     (Sample_Per_Update : Uint32_T;
      Handler           : Raw_Data_Handler);  -- pebble.h:557
   pragma Import
     (C,
      Raw_Data_Service_Subscribe,
      "accel_raw_data_service_subscribe");

end Pebble.Eventservice.Accelerometer;
