with Interfaces.C; use Interfaces.C;

package body Patris.Graphics is

   ---------------------
   -- Color_For_Shape --
   ---------------------

   function Color_For_Shape (Piece : Shape) return Piece_Colors is
      use Colors;
   begin
      case Piece is
         when I => return (Red, Folly, DarkCandyAppleRed);
         when O => return (Blue, VividCerulean, DukeBlue);
         when J => return (WindsorTan, ChromeYellow, BulgarianRose);
         when L => return (Purple, Purpureus, ImperialPurple);
         when S => return (Green, SpringBud, JaegerGreen);
         when T => return (Yellow, Icterine, Limerick);
         when Z => return (Cyan, Celeste, TiffanyBlue);
      end case;
   end Color_For_Shape;

   ---------------------
   -- Draw_Shape_Rect --
   ---------------------

   procedure Draw_Shape_Rect (Ctx : GContext; Pt : GPoint; Color : Piece_Colors) is
   begin
      Set_Stroke_Width (Ctx, 1);

      --  Sunny sides (Top and Left)
      Set_Stroke_Color (Ctx, Color.Light);
      draw_line (Ctx, Pt, (Pt.x, Pt.y + Rect_Size - 1));
      draw_line (Ctx, Pt, (Pt.x + Rect_Size - 1, Pt.y));


      --  Shadow sides (Bottom and Right)
      Set_Stroke_Color (Ctx, Color.Shade);
      draw_line (Ctx, (Pt.x  + Rect_Size - 1, Pt.y + Rect_Size - 1),
                 (Pt.x, Pt.y + Rect_Size - 1));
      draw_line (Ctx, (Pt.x  + Rect_Size - 1, Pt.y + Rect_Size - 1),
                 (Pt.x + Rect_Size - 1, Pt.y));

      Set_Fill_Color (Ctx, Color.Inside);
      Fill_Rect (Ctx           => Ctx,
                 Rect          => ((Pt.x + 1, Pt.y + 1),
                                   (Rect_Size - 3, Rect_Size - 3)),
                 Corner_Radius => 0,
                 Corner_Mask   => GCornerNone);
   end Draw_Shape_Rect;

   ----------------
   -- Draw_Shape --
   ----------------

   procedure Draw_Shape
     (Ctx : GContext;
      Pt  : GPoint;
      P   : Piece;
      Preview : Boolean := False)
   is
      Color : constant Piece_Colors := Color_For_Shape (P.S);
      Coord : GPoint;

      procedure Draw is
      begin
         --  Adjust the coordinates for next piece preview
         if Preview then
            case P.S is
            when O =>
               Coord.x := Coord.x - Rect_Size;
               Coord.y := Coord.y - Rect_Size;
            when I =>
               Coord.x := Coord.x - 2 * Rect_Size;
               Coord.y := Coord.y - 2 * Rect_Size;
            when Three_Shape =>
               Coord.x := Coord.x - 1 * Rect_Size - Rect_Size / 2;
               Coord.y := Coord.y - 1 * Rect_Size - Rect_Size / 2;
            end case;

         end if;
         Draw_Shape_Rect (Ctx, Coord, Color);
      end Draw;
   begin
      case P.S is
         when O =>
            Coord := (Pt.x + Rect_Size * int16_t (P.X),
                      Pt.y + Rect_Size * int16_t (P.Y));
            Draw;
            Coord := (Pt.x + Rect_Size * int16_t (P.X),
                      Pt.y + Rect_Size * int16_t (P.Y + 1));
            Draw;

            Coord := (Pt.x + Rect_Size * int16_t (P.X + 1),
                      Pt.y + Rect_Size * int16_t (P.Y));
            Draw;

            Coord := (Pt.x + Rect_Size * int16_t (P.X + 1),
                      Pt.y + Rect_Size * int16_t (P.Y + 1));
            Draw;

         when I =>
            for Y in I_Delta loop
               for X in I_Delta loop
                  if Possible_I_Shapes (P.D) (Y, X) then
                     Coord := (Pt.x + Rect_Size * int16_t (P.X + X),
                               Pt.y + Rect_Size * int16_t (P.Y + Y));
                     Draw;
                  end if;
               end loop;
            end loop;

         when Three_Shape =>
            for Y in Three_Delta loop
               for X in Three_Delta loop
                  if Possible_Three_Shapes (P.S, P.D) (Y, X) then
                     Coord := (Pt.x + Rect_Size * int16_t (P.X + X),
                               Pt.y + Rect_Size * int16_t (P.Y + Y));
                     Draw;
                  end if;
               end loop;
            end loop;
      end case;
   end Draw_Shape;


   procedure Draw_Board
     (Ctx : GContext;
      B : Board;
      Offset : Gpoint := (0, 0))
   is
   begin
      if Cur_State = Piece_Falling then
         Draw_Shape (Ctx, (Offset.X, Offset.Y - Rect_Size), Cur_Piece);
      end if;

      for Y in Y_Coord loop
         for X in X_Coord loop
            if B (Y)(X) /= Empty then
               Draw_Shape_Rect (Ctx,
                                (Offset.X + Rect_Size * int16_t (X),
                                 Offset.Y + Rect_Size * int16_t (Y - 1)),
                                Color_For_Shape (B (Y)(X)));
            end if;
         end loop;
      end loop;
   end Draw_Board;

   procedure Draw_Walls (Ctx : GContext) is
   begin
      --  Bottom
      for X in X_Coord'First - 1 .. X_Coord'Last + 1 loop
         Draw_Shape_Rect (Ctx,
                          (Rect_Size * int16_t (X),
                           Rect_Size * int16_t (Y_Coord'Last)),
                          Walls_Colors);
      end loop;
      --  Sides
      for Y in Y_Coord'First .. Y_Coord'Last + 1 loop
         Draw_Shape_Rect (Ctx,
                          (Rect_Size * int16_t (X_Coord'Last + 1),
                           Rect_Size * int16_t (Y - 1)),
                          Walls_Colors);
         Draw_Shape_Rect (Ctx,
                          (Rect_Size * int16_t (X_Coord'First - 1),
                           Rect_Size * int16_t (Y - 1)),
                          Walls_Colors);
      end loop;
   end Draw_Walls;

end Patris.Graphics;
