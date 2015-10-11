with Strings_Interface;

package UI_Texts is
   type Text_IDs is (ID_Score, ID_Level, ID_Menu, ID_Change_Level,
                     ID_Reset, ID_Reset_Game_Long, ID_Best_Score,
                     ID_About);

   function Get_Str (Id : Text_IDs) return Strings_Interface.Chars_Ptr;
end UI_Texts;
