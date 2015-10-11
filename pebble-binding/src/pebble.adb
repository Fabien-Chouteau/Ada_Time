package body Pebble is

   function Gnat_Malloc (Size : Interfaces.C.size_t) return System.Address is
      function Malloc (Arg1 : Interfaces.C.size_t) return System.Address;
      pragma Import (C, Malloc, "malloc");
   begin
      return Malloc (Size);
   end Gnat_Malloc;

   ---------------
   -- Gnat_Free --
   ---------------

   procedure Gnat_Free (Ptr : Opaque_Ptr) is
      procedure Free (Arg1 : System.Address);
      pragma Import (C, Free, "free");
   begin
      Free (Ptr);
   end Gnat_Free;

end Pebble;
