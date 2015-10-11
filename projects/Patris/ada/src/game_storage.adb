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

   function Store return Boolean is
      Data : Game_State_V2;
      Success : Boolean;
   begin
      Data.Score := Get_Score;
      Data.Level := Get_Level;
      Data.Cur_Board := Cur_Board;
      Data.Cur_Piece := Cur_Piece;
      Data.Next_Piece := Next_Piece;
      Data.Cur_State := Cur_State;
      Data.Best_Score := Get_Best_Score;
      Persist_V2.Write (Data, Success);
      return Success;
   end Store;
   function Restore return Boolean is
      Data_V1 : Game_State_V1;
      Data_V2 : Game_State_V2;
      Success : Boolean;
   begin

      if Persist_V1.Exists then
         --  Migration
         Persist_V1.Read (Data_V1, Success);
         if Success then
            Data_V2.Score      := Data_V1.Score;
            Data_V2.Best_Score := 0;
            Data_V2.Level      := Data_V1.Level;
            Data_V2.Cur_Piece  := Data_V1.Cur_Piece;
            Data_V2.Next_Piece := Data_V1.Next_Piece;
            Data_V2.Cur_State  := Data_V1.Cur_State;
            Data_V2.Cur_Board  := Data_V1.Cur_Board;
         end if;
         Persist_V1.Erase;
      else
         Persist_V2.Read (Data_V2, Success);
      end if;

      if Success then
         Set_Best_Score (Data_V2.Best_Score);
         Set_Score (Data_V2.Score);
         Set_Level (Data_V2.Level);
         Cur_Board := Data_V2.Cur_Board;
         Cur_Piece := Data_V2.Cur_Piece;
         Next_Piece := Data_V2.Next_Piece;
         Cur_State := Data_V2.Cur_State;
      end if;
      return Success;
   end Restore;

end Game_Storage;
