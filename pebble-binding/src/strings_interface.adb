with System;
with Ada.Unchecked_Conversion;

package body Strings_Interface is

   function To_chars_ptr is
      new Ada.Unchecked_Conversion (System.Address, Chars_Ptr);

   function Position_Of_Nul (Into : char_array) return size_t;

   ---------------------
   -- Position_Of_Nul --
   ---------------------

   function Position_Of_Nul (Into : char_array) return size_t is
   begin
      for J in Into'Range loop
         if Into (J) = nul then
            return J;
         end if;
      end loop;

      return Into'Last + 1;
   end Position_Of_Nul;

   ------------------
   -- To_Chars_Ptr --
   ------------------

   function To_Chars_Ptr
     (Item      : Char_Array_Access;
      Nul_Check : Boolean := False) return Chars_Ptr
   is
   begin
      if Item = null then
         return Null_Ptr;
      elsif Nul_Check
        and then Position_Of_Nul (Into => Item.all) > Item'Last
      then
         raise Terminator_Error;
      else
         return To_chars_ptr (Item (Item'First)'Address);
      end if;
   end To_Chars_Ptr;

end Strings_Interface;
