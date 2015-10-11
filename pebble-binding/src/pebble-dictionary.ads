package Pebble.Dictionary is
   subtype Dictionaryresult is unsigned;
   Dict_Ok                     : constant Dictionaryresult := 0;
   Dict_Not_Enough_Storage     : constant Dictionaryresult := 2;
   Dict_Invalid_Args           : constant Dictionaryresult := 4;
   Dict_Internal_Inconsistency : constant Dictionaryresult := 8;
   Dict_Malloc_Failed : constant Dictionaryresult := 16;  -- pebble.h:1030

   type Tupletype is (Tuple_Byte_Array, Tuple_Cstring, Tuple_Uint, Tuple_Int);
   pragma Convention (C, Tupletype);  -- pebble.h:1044

   type Anon2299_Data_Array is array (0 .. 0) of aliased Uint8_T;
   subtype Anon2299_Cstring_Array is Interfaces.C.char_array (0 .. 0);
   type Anon_2299 (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Data : aliased Anon2299_Data_Array;  -- pebble.h:1064
         when 1 =>
            Cstring : aliased Anon2299_Cstring_Array;  -- pebble.h:1066
         when 2 =>
            Uint8 : aliased Uint8_T;  -- pebble.h:1069
         when 3 =>
            Uint16 : aliased Uint16_T;  -- pebble.h:1072
         when 4 =>
            Uint32 : aliased Uint32_T;  -- pebble.h:1075
         when 5 =>
            Int8 : aliased Int8_T;  -- pebble.h:1078
         when 6 =>
            Int16 : aliased Int16_T;  -- pebble.h:1081
         when others =>
            Int32 : aliased Int32_T;  -- pebble.h:1084
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2299);
   pragma Unchecked_Union (Anon_2299);  -- pebble.h:1062

   type Tuple_Value_Array is array (0 .. 0) of aliased Anon_2299;
   type Tuple is record
      Key    : aliased Uint32_T;  -- pebble.h:1051
      C_Type : aliased unsigned_char;  -- pebble.h:1053
      Length : aliased Uint16_T;  -- pebble.h:1055
      Value  : aliased Tuple_Value_Array;  -- pebble.h:1085
   end record;
   pragma Convention (C_Pass_By_Copy, Tuple);  -- pebble.h:1086

   type Dictionary_Iterator is record
      The_Dictionary : Opaque_Ptr;  -- pebble.h:1097
      C_End          : Opaque_Ptr;  -- pebble.h:1098
      Cursor         : access Tuple;  -- pebble.h:1103
   end record;
   pragma Convention (C_Pass_By_Copy, Dictionary_Iterator);  -- pebble.h:1104

   function Calc_Buffer_Size (Arg1 : Uint8_T  -- , ...
   ) return Uint32_T;  -- pebble.h:1117
   pragma Import (C, Calc_Buffer_Size, "dict_calc_buffer_size");

   function Size
     (Arg1 : access Dictionary_Iterator) return Uint32_T;  -- pebble.h:1124
   pragma Import (C, Size, "dict_size");

   function Write_Begin
     (Arg1 : access Dictionary_Iterator;
      Arg2 : access Uint8_T;
      Arg3 : Uint16_T) return Dictionaryresult;  -- pebble.h:1134
   pragma Import (C, Write_Begin, "dict_write_begin");

   function Write_Data
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : access Uint8_T;
      Arg4 : Uint16_T) return Dictionaryresult;  -- pebble.h:1144
   pragma Import (C, Write_Data, "dict_write_data");

   function Write_Cstring
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Strings_Interface.Chars_Ptr)
     return Dictionaryresult;  -- pebble.h:1153
   pragma Import (C, Write_Cstring, "dict_write_cstring");

   function Write_Int
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Opaque_Ptr;
      Arg4 : Uint8_T;
      Arg5 : U_Bool) return Dictionaryresult;  -- pebble.h:1164
   pragma Import (C, Write_Int, "dict_write_int");

   function Write_Uint8
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Uint8_T) return Dictionaryresult;  -- pebble.h:1176
   pragma Import (C, Write_Uint8, "dict_write_uint8");

   function Write_Uint16
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Uint16_T) return Dictionaryresult;  -- pebble.h:1178
   pragma Import (C, Write_Uint16, "dict_write_uint16");

   function Write_Uint32
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Uint32_T) return Dictionaryresult;  -- pebble.h:1180
   pragma Import (C, Write_Uint32, "dict_write_uint32");

   function Write_Int8
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Int8_T) return Dictionaryresult;  -- pebble.h:1182
   pragma Import (C, Write_Int8, "dict_write_int8");

   function Write_Int16
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Int16_T) return Dictionaryresult;  -- pebble.h:1184
   pragma Import (C, Write_Int16, "dict_write_int16");

   function Write_Int32
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Uint32_T;
      Arg3 : Int32_T) return Dictionaryresult;  -- pebble.h:1186
   pragma Import (C, Write_Int32, "dict_write_int32");

   function Write_End
     (Arg1 : access Dictionary_Iterator) return Uint32_T;  -- pebble.h:1192
   pragma Import (C, Write_End, "dict_write_end");

   function Read_Begin_From_Buffer
     (Arg1 : access Dictionary_Iterator;
      Arg2 : access Uint8_T;
      Arg3 : Uint16_T) return access Tuple;  -- pebble.h:1200
   pragma Import (C, Read_Begin_From_Buffer, "dict_read_begin_from_buffer");

   function Read_Next
     (Arg1 : access Dictionary_Iterator) return access Tuple;  -- pebble.h:1205
   pragma Import (C, Read_Next, "dict_read_next");

   function Read_First
     (Arg1 : access Dictionary_Iterator) return access Tuple;  -- pebble.h:1210
   pragma Import (C, Read_First, "dict_read_first");

   type Anon_2374 is record
      Data   : access Uint8_T;  -- pebble.h:1231
      Length : aliased Uint16_T;  -- pebble.h:1233
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2374);  -- pebble.h:1229

   type Anon_2375 is record
      Data   : Strings_Interface.Chars_Ptr;  -- pebble.h:1238
      Length : aliased Uint16_T;  -- pebble.h:1240
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2375);  -- pebble.h:1236

   type Anon_2376 is record
      Storage : aliased Uint32_T;  -- pebble.h:1246
      Width   : aliased Uint16_T;  -- pebble.h:1248
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2376);  -- pebble.h:1243

   type Anon2373_Bytes_Struct is record
      Data   : access Uint8_T;  -- pebble.h:1231
      Length : aliased Uint16_T;  -- pebble.h:1233
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2373_Bytes_Struct);
   type Anon2373_Cstring_Struct is record
      Data   : Strings_Interface.Chars_Ptr;  -- pebble.h:1238
      Length : aliased Uint16_T;  -- pebble.h:1240
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2373_Cstring_Struct);
   type Anon2373_Integer_Struct is record
      Storage : aliased Uint32_T;  -- pebble.h:1246
      Width   : aliased Uint16_T;  -- pebble.h:1248
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2373_Integer_Struct);
   type Anon_2373 (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Bytes : aliased Anon_2374;  -- pebble.h:1234
         when 1 =>
            Cstring : aliased Anon_2375;  -- pebble.h:1241
         when others =>
            Integer : aliased Anon_2376;  -- pebble.h:1249
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2373);
   pragma Unchecked_Union (Anon_2373);  -- pebble.h:1227

   type Anon2372_Bytes_Struct is record
      Data   : access Uint8_T;  -- pebble.h:1231
      Length : aliased Uint16_T;  -- pebble.h:1233
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2372_Bytes_Struct);
   type Anon2372_Cstring_Struct is record
      Data   : Strings_Interface.Chars_Ptr;  -- pebble.h:1238
      Length : aliased Uint16_T;  -- pebble.h:1240
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2372_Cstring_Struct);
   type Anon2372_Integer_Struct is record
      Storage : aliased Uint32_T;  -- pebble.h:1246
      Width   : aliased Uint16_T;  -- pebble.h:1248
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2372_Integer_Struct);
   type Anon2372_Anon2373_Union (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Bytes : aliased Anon_2374;  -- pebble.h:1234
         when 1 =>
            Cstring : aliased Anon_2375;  -- pebble.h:1241
         when others =>
            Integer : aliased Anon_2376;  -- pebble.h:1249
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Anon2372_Anon2373_Union);
   pragma Unchecked_Union (Anon2372_Anon2373_Union);
   type Tuplet is record
      C_Type   : aliased Tupletype;  -- pebble.h:1221
      Key      : aliased Uint32_T;  -- pebble.h:1223
      Anon3428 : Anon2372_Anon2373_Union;  -- pebble.h:1250
   end record;
   pragma Convention (C_Pass_By_Copy, Tuplet);  -- pebble.h:1218

   type Serialize_Callback is access procedure
     (Arg1 : access Uint8_T;
      Arg2 : Uint16_T;
      Arg3 : Opaque_Ptr);
   pragma Convention (C, Serialize_Callback);  -- pebble.h:1277

   function Serialize_Tuplets
     (Arg1 : Serialize_Callback;
      Arg2 : Opaque_Ptr;
      Arg3 : Opaque_Ptr;
      Arg4 : Uint8_T) return Dictionaryresult;  -- pebble.h:1288
   pragma Import (C, Serialize_Tuplets, "dict_serialize_tuplets");

   function Serialize_Tuplets_To_Buffer
     (Arg1 : Opaque_Ptr;
      Arg2 : Uint8_T;
      Arg3 : access Uint8_T;
      Arg4 : access Uint32_T) return Dictionaryresult;  -- pebble.h:1298
   pragma Import
     (C,
      Serialize_Tuplets_To_Buffer,
      "dict_serialize_tuplets_to_buffer");

   function Serialize_Tuplets_To_Buffer_With_Iter
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Opaque_Ptr;
      Arg3 : Uint8_T;
      Arg4 : access Uint8_T;
      Arg5 : access Uint32_T) return Dictionaryresult;  -- pebble.h:1308
   pragma Import
     (C,
      Serialize_Tuplets_To_Buffer_With_Iter,
      "dict_serialize_tuplets_to_buffer_with_iter");

   function Write_Tuplet
     (Arg1 : access Dictionary_Iterator;
      Arg2 : Opaque_Ptr) return Dictionaryresult;  -- pebble.h:1314
   pragma Import (C, Write_Tuplet, "dict_write_tuplet");

   function Calc_Buffer_Size_From_Tuplets
     (Arg1 : Opaque_Ptr;
      Arg2 : Uint8_T) return Uint32_T;  -- pebble.h:1323
   pragma Import
     (C,
      Calc_Buffer_Size_From_Tuplets,
      "dict_calc_buffer_size_from_tuplets");

   type Key_Updated_Callback is access procedure
     (Arg1 : Uint32_T;
      Arg2 : access constant Tuple;
      Arg3 : access constant Tuple;
      Arg4 : Opaque_Ptr);
   pragma Convention (C, Key_Updated_Callback);  -- pebble.h:1338

   function Merge
     (Arg1 : access Dictionary_Iterator;
      Arg2 : access Uint32_T;
      Arg3 : access Dictionary_Iterator;
      Arg4 : U_Bool;
      Arg5 : Key_Updated_Callback;
      Arg6 : Opaque_Ptr) return Dictionaryresult;  -- pebble.h:1350
   pragma Import (C, Merge, "dict_merge");

   function Find
     (Arg1 : access constant Dictionary_Iterator;
      Arg2 : Uint32_T) return access Tuple;  -- pebble.h:1359
   pragma Import (C, Find, "dict_find");

end Pebble.Dictionary;
