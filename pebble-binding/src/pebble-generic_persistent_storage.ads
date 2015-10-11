with Pebble.Storage;
generic
   Data_Key : Uint32_T;
   type Data_Type is private;
package Pebble.Generic_Persistent_Storage is
   pragma Compile_Time_Error
     (Data_Type'Size > Pebble.Storage.Data_Max_Length,
      "Persistant data too big");
   procedure Write (Data : Data_Type; Success : out Boolean);
   procedure Read (Data : out Data_Type; Success : out Boolean);
   function Exists return Boolean;
   procedure Erase;
end Pebble.Generic_Persistent_Storage;
