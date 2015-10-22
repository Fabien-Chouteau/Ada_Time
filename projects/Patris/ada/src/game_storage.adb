with Pebble.Generic_Persistent_Storage;
with Patris; use Patris;

package body Game_Storage is
   type Game_State_V1 is record
      Score      : Score_T;
      Level      : Score_T;
      Cur_Piece  : Piece;
      Next_Piece : Piece;
      Cur_State  : State;
      Cur_Board  : Board;
   end record;
   package Persist_V1 is new Pebble.Generic_Persistent_Storage
     (1, Game_State_V1);

   --  Add best score
   type Game_State_V2 is record
      Score      : Score_T;
      Best_Score : Score_T;
      Level      : Score_T;
      Cur_Piece  : Piece;
      Next_Piece : Piece;
      Cur_State  : State;
      Cur_Board  : Board;
   end record;
   package Persist_V2 is new Pebble.Generic_Persistent_Storage
     (2, Game_State_V2);

   --  Add line counter
   type Game_State_V3 is record
      V2       : Game_State_V2;
      Line_Cnt : Score_T;
   end record;
   package Persist_V3 is new Pebble.Generic_Persistent_Storage
     (3, Game_State_V3);

   function Store return Boolean is
      Data : Game_State_V3;
      Success : Boolean;
   begin
      Data.V2.Score := Get_Score;
      Data.V2.Level := Get_Level;
      Data.V2.Cur_Board := Get_Board;
      Data.V2.Cur_Piece := Get_Piece;
      Data.V2.Next_Piece := Get_Next_Piece;
      Data.V2.Cur_State := Get_State;
      Data.V2.Best_Score := Get_Best_Score;
      Data.Line_Cnt   := Get_Line_Counter;
      Persist_V3.Write (Data, Success);
      return Success;
   end Store;

   function Restore return Boolean is
      Data_V1 : Game_State_V1;
      Data_V3 : Game_State_V3;
      Success : Boolean;
   begin

      if Persist_V1.Exists then

         --  Migration V1 -> V3
         Persist_V1.Read (Data_V1, Success);
         if Success then
            Data_V3.V2.Score      := Data_V1.Score;
            Data_V3.V2.Level      := Data_V1.Level;
            Data_V3.V2.Cur_Piece  := Data_V1.Cur_Piece;
            Data_V3.V2.Next_Piece := Data_V1.Next_Piece;
            Data_V3.V2.Cur_State  := Data_V1.Cur_State;
            Data_V3.V2.Cur_Board  := Data_V1.Cur_Board;
            Data_V3.V2.Best_Score := 0;
            Data_V3.Line_Cnt   := 0;
         end if;
         Persist_V1.Erase;

      elsif Persist_V2.Exists then

         --  Migration V2 -> V3
         Persist_V2.Read (Data_V3.V2, Success);
         Data_V3.Line_Cnt   := 0;

         Persist_V2.Erase;

      else
         Persist_V3.Read (Data_V3, Success);
      end if;

      if Success then

         --  Check Set_Game_State precondition
         if Valid_Configuration (Data_V3.V2.Cur_Board,
                                 Data_V3.V2.Cur_State,
                                 Data_V3.V2.Cur_Piece)
         then
            Set_Game_State (Data_V3.V2.Cur_Board,
                            Data_V3.V2.Cur_State,
                            Data_V3.V2.Cur_Piece,
                            Data_V3.V2.Next_Piece);
            Set_Best_Score (Data_V3.V2.Best_Score);
            Set_Score (Data_V3.V2.Score);
            Set_Level (Data_V3.V2.Level);
            Set_Line_Counter (Data_V3.Line_Cnt);
         else
            Game_Reset;
         end if;
      end if;
      return Success;
   end Restore;

end Game_Storage;
