with Pebble.Dictionary; use Pebble.Dictionary;
with Pebble.Appmessage; use Pebble.Appmessage;

package Pebble.Appsync is
   type Tuple_Changed_Callback is access procedure
     (Arg1 : Uint32_T;
      Arg2 : access constant Tuple;
      Arg3 : access constant Tuple;
      Arg4 : Opaque_Ptr);
   pragma Convention (C, Tuple_Changed_Callback);  -- pebble.h:1750

   type Error_Callback is access procedure
     (Arg1 : Dictionaryresult;
      Arg2 : App_Message_Result;
      Arg3 : Opaque_Ptr);
   pragma Convention (C, Error_Callback);  -- pebble.h:1760

   type Anon_2471 (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Current : Opaque_Ptr;  -- pebble.h:1765
         when others =>
            Buffer : access Uint8_T;  -- pebble.h:1766
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2471);
   pragma Unchecked_Union (Anon_2471);  -- pebble.h:1764

   type Anon_2472 is record
      Value_Changed : Tuple_Changed_Callback;  -- pebble.h:1770
      Error         : Error_Callback;  -- pebble.h:1771
      Context       : Opaque_Ptr;  -- pebble.h:1772
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2472);  -- pebble.h:1769

   type Anon2470_Anon2471_Union (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Current : Opaque_Ptr;  -- pebble.h:1765
         when others =>
            Buffer : access Uint8_T;  -- pebble.h:1766
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2470_Anon2471_Union);
   pragma Unchecked_Union (Anon2470_Anon2471_Union);
   type Anon2470_Callback_Struct is record
      Value_Changed : Tuple_Changed_Callback;  -- pebble.h:1770
      Error         : Error_Callback;  -- pebble.h:1771
      Context       : Opaque_Ptr;  -- pebble.h:1772
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2470_Callback_Struct);
   type Appsync is record
      Current_Iter : aliased Dictionary_Iterator;  -- pebble.h:1763
      Anon3539     : Anon2470_Anon2471_Union;  -- pebble.h:1767
      Buffer_Size  : aliased Uint16_T;  -- pebble.h:1768
      Callback     : aliased Anon_2472;  -- pebble.h:1773
   end record;
   pragma Convention (C_Pass_By_Copy, Appsync);  -- pebble.h:1762

   procedure Init
     (Arg1 : access Appsync;
      Arg2 : access Uint8_T;
      Arg3 : Uint16_T;
      Arg4 : Opaque_Ptr;
      Arg5 : Uint8_T;
      Arg6 : Tuple_Changed_Callback;
      Arg7 : Error_Callback;
      Arg8 : Opaque_Ptr);  -- pebble.h:1796
   pragma Import (C, Init, "app_sync_init");

   procedure Deinit (Arg1 : access Appsync);  -- pebble.h:1803
   pragma Import (C, Deinit, "app_sync_deinit");

   function Set
     (Arg1 : access Appsync;
      Arg2 : Opaque_Ptr;
      Arg3 : Uint8_T) return App_Message_Result;  -- pebble.h:1818
   pragma Import (C, Set, "app_sync_set");

   function Get
     (Arg1 : Opaque_Ptr;
      Arg2 : Uint32_T) return access constant Tuple;  -- pebble.h:1825
   pragma Import (C, Get, "app_sync_get");

end Pebble.Appsync;
