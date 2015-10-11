with Patris.Clock; use Patris.Clock;
package Patris.Clock_Graphics is
   Max_Piece_Per_Sequence : constant := 13;
   type Sequence_Range is range 1.. Max_Piece_Per_Sequence;
   type Drop_Sequence is array (Sequence_Range range <>) of Piece;

   Num_1_Seq : constant Drop_Sequence :=
     ((L, East,  5, 0),
      (I, East,  5, 0),
      (I, East,  4, 0),
      (L, West,  6, 0),
      (O, North, 6, 0));
   Num_2_Seq : constant Drop_Sequence :=
     ((I, North, 3, 0),
      (I, East,  0, 0),
      (L, East,  2, 0),
      (J, South, 5, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0),
      (O, South, 6, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0));
   Num_3_Seq : constant Drop_Sequence :=
     ((O, North, 2, 0),
      (J, North, 4, 0),
      (J, West,  5, 0),
      (I, West,  6, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0),
      (O, South, 6, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0));
   Num_4_Seq : constant Drop_Sequence :=
     ((O, North, 6, 0),
      (O, North, 6, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0),
      (I, West,  6, 0),
      (J, West,  2, 0),
      (I, West,  5, 0),
      (J, East,  1, 0));
   Num_5_Seq : constant Drop_Sequence :=
     ((O, North, 2, 0),
      (J, North, 4, 0),
      (J, West,  5, 0),
      (I, West,  6, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0),
      (O, South, 2, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0));
   Num_6_Seq : constant Drop_Sequence :=
     ((J, North, 2, 0),
      (T, North, 5, 0),
      (J, North, 3, 0),
      (I, West,  1, 0),
      (S, East,  5, 0),
      (T, West,  6, 0),
      (S, North, 4, 0),
      (J, East,  2, 0),
      (L, East,  1, 0),
      (L, West,  2, 0));
   Num_7_Seq : constant Drop_Sequence :=
     ((O, South, 6, 0),
      (J, West,  6, 0),
      (J, East,  5, 0),
      (O, South, 6, 0),
      (I, North, 3, 0),
      (L, South, 2, 0),
      (J, South, 5, 0));
   Num_8_Seq : constant Drop_Sequence :=
     ((J, North, 2, 0),
      (L, North, 5, 0),
      (S, North, 5, 0),
      (Z, North, 2, 0),
      (L, East,  1, 0),
      (J, West,  6, 0),
      (I, North, 3, 0),
      (L, North, 4, 0),
      (T, West,  2, 0),
      (I, West,  6, 0),
      (T, North, 3, 0),
      (J, East,  1, 0),
      (L, West,  5, 0));

   Num_9_Seq : constant Drop_Sequence :=
     ((J, West,  6, 0),
      (J, East,  5, 0),
      (I, North, 3, 0),
      (T, East,  1, 0),
      (S, East,  1, 0),
      (L, North, 4, 0),
      (I, West,  6, 0),
      (J, South, 4, 0),
      (J, South, 5, 0),
      (T, South, 2, 0));
   Num_0_Seq : constant Drop_Sequence :=
     ((J, West,  6, 0),
      (I, East,  0, 0),
      (S, North, 4, 0),
      (T, East,  2, 0),
      (T, West,  2, 0),
      (Z, East,  5, 0),
      (Z, East,  1, 0),
      (Z, East,  5, 0),
      (T, East,  1, 0),
      (T, East,  5, 0),
      (Z, North, 3, 0),
      (J, South, 5, 0));

end Patris.Clock_Graphics;
