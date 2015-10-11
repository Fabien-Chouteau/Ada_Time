with Pebble.Graphics; use Pebble.Graphics;

package Patris.Clock is
   type Value is mod 10;
   type Digit is mod 4;

   function Step return Boolean;
   procedure Drop (D : Digit; V : Value);
   procedure Draw (Ctx : Gcontext);
end Patris.Clock;
