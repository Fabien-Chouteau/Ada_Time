package Pebble.Resources is
   type Reshandle is new Opaque_Ptr;  -- pebble.h:1953

   function Resource_Get_Handle
     (Arg1 : Uint32_T) return Reshandle;  -- pebble.h:1982
   pragma Import (C, Resource_Get_Handle, "resource_get_handle");

   function Resource_Size (Arg1 : Reshandle) return Size_T;  -- pebble.h:1987
   pragma Import (C, Resource_Size, "resource_size");

   function Resource_Load
     (Arg1 : Reshandle;
      Arg2 : access Uint8_T;
      Arg3 : Size_T) return Size_T;  -- pebble.h:1994
   pragma Import (C, Resource_Load, "resource_load");

   function Resource_Load_Byte_Range
     (Arg1 : Reshandle;
      Arg2 : Uint32_T;
      Arg3 : access Uint8_T;
      Arg4 : Size_T) return Size_T;  -- pebble.h:2002
   pragma Import (C, Resource_Load_Byte_Range, "resource_load_byte_range");

end Pebble.Resources;
