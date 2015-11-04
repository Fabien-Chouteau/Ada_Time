with Interfaces.C; use Interfaces.C;
with Strings_Interface; use Strings_Interface;

package body UI_Texts is

   package En_US is
      Str_Score        : aliased char_array :=
        "Score" & char (ASCII.NUL);
      Str_Level        : aliased char_array :=
        "Level" & char (ASCII.NUL);
      Str_Menu         : aliased char_array :=
        "Menu" & char (ASCII.NUL);
      Str_Change_Level : aliased char_array :=
        "change level  : " & char (ASCII.NUL);
      Str_Reset        : aliased char_array :=
        "Restart game" & char (ASCII.NUL);
      Str_Reset_Long   : aliased char_array :=
        "Erase board and score" & char (ASCII.NUL);
      Str_Best_Score   : aliased char_array :=
        "Best score" & char (ASCII.NUL);
      Str_About        : aliased char_array :=
        "About" & char (ASCII.NUL);
      Str_Game_Over    : aliased char_array :=
        "GAME OVER" & char (ASCII.NUL);

      Strings : constant array (Text_IDs) of Char_Array_Access :=
        (ID_Score => Str_Score'Access,
         ID_Level => Str_Level'Access,
         ID_Menu  => Str_Menu'Access,
         ID_Change_Level => Str_Change_Level'Access,
         ID_Reset => Str_Reset'Access,
         ID_Reset_Game_Long => Str_Reset_Long'Access,
         ID_Best_Score => Str_Best_Score'Access,
         ID_About => Str_About'Access,
         ID_Game_Over => Str_Game_Over'Access
        );
   end En_US;

   function Get_Str (Id : Text_IDs) return Strings_Interface.Chars_Ptr is
   begin
      return To_Chars_Ptr (En_US.Strings (Id));
   end Get_Str;

end UI_Texts;
