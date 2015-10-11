with Ada.Unchecked_Conversion;
with Pebble;

generic
   type Object (<>) is limited private;
   type Name is access Object;
package Opaque_Pointers is
   function To_Opaque is new Ada.Unchecked_Conversion
     (Source => Name,
      Target => Pebble.Opaque_Ptr);
   function From_Opaque is new Ada.Unchecked_Conversion
     (Source => Pebble.Opaque_Ptr,
      Target => Name);
end Opaque_Pointers;
