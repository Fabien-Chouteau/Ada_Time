package body Patris.Utils is

   ---------------
   -- To_String --
   ---------------

   procedure To_String (Val : Score_T; Buffer : out char_array) is
      Index : size_t := Buffer'First;
      Tmp : Score_T := Val;
      procedure Reverse_Str (To : size_t) is
         Start : size_t := Buffer'First;
         Stop  : size_t := To;
         C     : Interfaces.C.char;
      begin
         while Start < Stop loop
            C := Buffer (Start);
            Buffer (Start) := Buffer (Stop);
            Buffer (Stop) := C;
            Start := Start + 1;
            Stop := Stop - 1;
         end loop;
      end Reverse_Str;
   begin
      if Buffer'Length < 6 then
         return;
      end if;
      loop
         Buffer (Index) := Interfaces.C.Char
           (Character'Val (Character'Pos ('0') + Tmp mod 10));
         Index := Index + 1;
         Tmp := Tmp / 10;
         exit when Tmp = 0;
      end loop;
      Buffer (Index) := Interfaces.C.nul;
      Reverse_Str (Index - 1);
   end To_String;

end Patris.Utils;
