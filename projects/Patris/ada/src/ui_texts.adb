with Interfaces.C; use Interfaces.C;
with Strings_Interface; use Strings_Interface;

package body UI_Texts is

   package En_US is
      Str_Score : aliased char_array := "Score";
      Str_Level : aliased char_array := "Level";
      Str_Menu : aliased char_array := "Menu";
      Str_Change_Level : aliased char_array := "change level:";
      Str_Reset : aliased char_array := "Restart game";
      Str_Reset_Long : aliased char_array := "Erase board and score";
      Str_Best_Score : aliased char_array := "Best score";
      Str_About : aliased char_array := "About";
      Strings : constant array (Text_IDs) of Char_Array_Access :=
        (ID_Score => Str_Score'Access,
         ID_Level => Str_Level'Access,
         ID_Menu  => Str_Menu'Access,
         ID_Change_Level => Str_Change_Level'Access,
         ID_Reset => Str_Reset'Access,
         ID_Reset_Game_Long => Str_Reset_Long'Access,
         ID_Best_Score => Str_Best_Score'Access,
         ID_About => Str_About'Access
        );

   end En_US;
   function Get_Str (Id : Text_IDs) return Strings_Interface.Chars_Ptr is
   begin
      return To_Chars_Ptr (En_US.Strings (Id));
   end Get_Str;

end UI_Texts;
