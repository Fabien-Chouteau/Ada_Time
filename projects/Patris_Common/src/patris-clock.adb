with Patris.Clock_Graphics; use Patris.Clock_Graphics;
with Patris.Graphics; use Patris.Graphics;
with Interfaces.C; use Interfaces.C;
with Pebble.Graphics; use Pebble.Graphics;

package body Patris.Clock is

   Digit_Board : array (Digit) of Board :=
     (others => (others => (others => Empty)));
   Digit_Sequence : array (Digit, Sequence_Range) of Piece;
   Digit_Sequence_Lenght : array (Digit) of Natural := (others => 0);
   Cur_Index : array (Digit) of Natural := (others => 0);

   ----------------------------
   -- Include_Piece_In_Board --
   ----------------------------

   procedure Include_Piece_In_Board (B : in out Board; P : Piece) is
   begin
      case P.S is
         when O =>
            B (P.Y) (P.X)         := P.S;
            B (P.Y + 1) (P.X)     := P.S;
            B (P.Y) (P.X + 1)     := P.S;
            B (P.Y + 1) (P.X + 1) := P.S;

         when I =>
            --  intermediate assertion needed for proof
            pragma Assert
              (for all YY in I_Delta =>
                 (for all XX in I_Delta =>
                    (if Possible_I_Shapes (P.D) (YY, XX) then
                       Is_Empty (B, P.Y + YY, P.X + XX))));

            for Y in I_Delta loop
               for X in I_Delta loop
                  if Possible_I_Shapes (P.D) (Y, X) then
                     B (P.Y + Y) (P.X + X) := P.S;
                  end if;
               end loop;
            end loop;

         when Three_Shape =>
            --  intermediate assertion needed for proof
            pragma Assert
              (for all YY in Three_Delta =>
                 (for all XX in Three_Delta =>
                    (if Possible_Three_Shapes (P.S, P.D) (YY, XX) then
                       Is_Empty (B, P.Y + YY, P.X + XX))));

            for Y in Three_Delta loop
               for X in Three_Delta loop
                  if Possible_Three_Shapes (P.S, P.D) (Y, X) then
                     B (P.Y + Y) (P.X + X) := P.S;
                  end if;
               end loop;
            end loop;
      end case;

      --  update current state
   end Include_Piece_In_Board;

   function Step return Boolean is
      P, Candidate : Piece;
      Index : Sequence_Range;
      Finished : Boolean := True;
   begin
      for D in Digit loop
         if Cur_Index (D) /= 0 then
            Index := Sequence_Range (Cur_Index (D));
            P := Digit_Sequence (D, Index);
            Candidate := Move (P, Move_Down);

            if No_Overlap (Digit_Board (D), Candidate) then
               Digit_Sequence (D, Index) := Candidate;
               Finished := False;
            else
               Include_Piece_In_Board (Digit_Board (D), P);
               if Cur_Index (D) < Digit_Sequence_Lenght (D) then
                  Cur_Index (D) := Cur_Index (D) + 1;
                  Finished := False;
               else
                  Cur_Index (D) := 0;
               end if;
            end if;
         end if;
      end loop;
      return not Finished;
   end Step;

   procedure Drop (D : Digit; V : Value) is
      L : Natural := 0;
   begin
      case V is
         when 0 =>
            for P of Num_0_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 1 =>
            for P of Num_1_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 2 =>
            for P of Num_2_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 3 =>
            for P of Num_3_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 4 =>
            for P of Num_4_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 5 =>
            for P of Num_5_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 6 =>
            for P of Num_6_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 7 =>
            for P of Num_7_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 8 =>
            for P of Num_8_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
         when 9 =>
            for P of Num_9_Seq loop
               L := L + 1;
               Digit_Sequence (D, Sequence_Range (L)) := P;
            end loop;
      end case;

      Digit_Sequence_Lenght (D) := L;
      Cur_Index (D)   := 1;
      Digit_Board (D) := (others => (others => Empty));
   end Drop;

   procedure Draw (Ctx : Gcontext) is
      Offsets : constant array (Digit) of Gpoint
        := ((Rect_Size / 2, -10 * Rect_Size),
            (8 * Rect_Size - Rect_Size / 2, -10 * Rect_Size),
            (Rect_Size / 2, 1 * Rect_Size),
            (8 * Rect_Size - Rect_Size / 2, 1 * Rect_Size));
   begin
      for D in Digit loop
         Draw_Board (Ctx, Digit_Board (D), Offsets (D));
         if Cur_Index (D) /= 0 then
            Draw_Shape (Ctx     => Ctx,
                        Pt      => (Offsets (D).X, Offsets (D).Y - Rect_Size),
                        P       => Digit_Sequence (D, Sequence_Range (Cur_Index (D))),
                        Preview => False);
         end if;
      end loop;
   end Draw;

end Patris.Clock;
