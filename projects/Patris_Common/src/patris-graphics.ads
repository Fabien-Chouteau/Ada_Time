with Pebble; use Pebble;
with Pebble.Graphics; use Pebble.Graphics;

package Patris.Graphics is

   Rect_Size : constant := 8;

   type Piece_Colors is record
      Inside, Light, Shade : GColor;
   end record;

   Walls_Colors : constant Piece_Colors := (Colors.LightGray,
                                            Colors.White,
                                            Colors.DarkGray);

   function Color_For_Shape (Piece : Shape) return Piece_Colors;

   procedure Draw_Shape (Ctx : GContext;
                         Pt  : GPoint;
                         P   : Piece;
                         Preview : Boolean := False);
   procedure Draw_Shape_Rect (Ctx : GContext;
                              Pt : GPoint;
                              Color : Piece_Colors);

   procedure Draw_Board
     (Ctx : GContext;
      B : Board;
      Offset : Gpoint := (0, 0));
   procedure Draw_Walls (Ctx : GContext);
end Patris.Graphics;
