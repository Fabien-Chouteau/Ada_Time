with System;
with Pebble.Storage; use Pebble.Storage;
with Opaque_Pointers;

package body Pebble.Generic_Persistent_Storage is

   Data_Size : constant Size_T := Data_Type'Object_Size / System.Storage_Unit;

   type Data_Access is access all Data_Type;
   package Opaque is new Opaque_Pointers (Data_Type, Data_Access);
   use Opaque;

   -----------
   -- Write --
   -----------

   procedure Write (Data : Data_Type; Success : out Boolean) is
      Local : aliased Data_Type := Data;
   begin
      if Write_Data (Key         => Data_Key,
                     Buffer      => To_Opaque (Local'Unchecked_Access),
                     Buffer_Size => Data_Size) = int (Data_Size)
      then
         Success := True;
      else
         Success := False;
      end if;
   end Write;

   -----------
   -- Write --
   -----------

   function Write (Data : Data_Type) return Boolean is
      Success : Boolean;
   begin
      Write (Data, Success);
      return Success;
   end Write;

   ----------
   -- Read --
   ----------

   procedure Read (Data : out Data_Type; Success : out Boolean) is
      Local : aliased Data_Type;
   begin
      if Exists (Data_Key) = 0 then
         Success := False;
         return;
      end if;
      if Read_Data (Key         => Data_Key,
                    Buffer      => To_Opaque (Local'Unchecked_Access),
                    Buffer_Size => Data_Size) = int (Data_Size)
      then
         Success := True;
         Data := Local;
      else
         Success := False;
      end if;
   end Read;

   ----------
   -- Read --
   ----------

   function Read (Data : out Data_Type) return Boolean is
      Success : Boolean;
   begin
      Read (Data, Success);
      return Success;
   end Read;

   ------------
   -- Exists --
   ------------

   function Exists return Boolean is
   begin
      return  Pebble.Storage.Exists (Data_Key) /= 0;
   end Exists;

   -----------
   -- Erase --
   -----------

   procedure Erase is
      Unref : Status_T with Unreferenced;
   begin
      Unref := Pebble.Storage.Delete (Data_Key);
   end Erase;

end Pebble.Generic_Persistent_Storage;
