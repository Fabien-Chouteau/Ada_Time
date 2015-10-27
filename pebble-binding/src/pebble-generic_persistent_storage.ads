with Pebble.Storage;
generic
   Data_Key : Uint32_T;
   type Data_Type is private;
package Pebble.Generic_Persistent_Storage is
   pragma Compile_Time_Error
     (Data_Type'Size > Pebble.Storage.Data_Max_Length,
      "Persistant data too big");

   procedure Write (Data : Data_Type; Success : out Boolean);
   function Write (Data : Data_Type) return Boolean;
   --  Read data associated with the key, return True on success

   procedure Read (Data : out Data_Type; Success : out Boolean);
   function Read (Data : out Data_Type) return Boolean;
   --  Read data associated with the key, return True on success

   function Exists return Boolean;
   --  Return True if there is data associated with the key

   procedure Erase;
   --  Erase data associated with the key

end Pebble.Generic_Persistent_Storage;
