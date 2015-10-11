with Pebble.Resources; use Pebble.Resources;

package Pebble.Graphics is

   type Gcontext is private;
   Null_Gcontext : constant Gcontext;
   type Gbitmap is private;
   Null_Gbitmap : constant Gbitmap;
   type Gbitmapsequence is private;
   Null_Gbitmapsequence : constant Gbitmapsequence;
   type Gdrawcommand is private;
   Null_Gdrawcommand : constant Gdrawcommand;
   type Gdrawcommandframe is private;
   Null_Gdrawcommandframe : constant Gdrawcommandframe;
   type Gdrawcommandimage is private;
   Null_Gdrawcommandimage : constant Gdrawcommandimage;
   type Gdrawcommandlist is private;
   Null_Gdrawcommandlist : constant Gdrawcommandlist;
   type Gdrawcommandsequence is private;
   Null_Gdrawcommandsequence : constant Gdrawcommandsequence;

   type Anon_2590 is record
      B : Extensions.Unsigned_2;  -- pebble.h:2437
      G : Extensions.Unsigned_2;  -- pebble.h:2438
      R : Extensions.Unsigned_2;  -- pebble.h:2439
      A : Extensions.Unsigned_2;  -- pebble.h:2440
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_2590);
   pragma Pack (Anon_2590);  -- pebble.h:2436

   type Gcolor8;
   type Color_Component_Struct is record
      B : Extensions.Unsigned_2;  -- pebble.h:2437
      G : Extensions.Unsigned_2;  -- pebble.h:2438
      R : Extensions.Unsigned_2;  -- pebble.h:2439
      A : Extensions.Unsigned_2;  -- pebble.h:2440
   end record;
   pragma Convention (C_Pass_By_Copy, Color_Component_Struct);
   type Gcolor8 (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Argb : aliased Uint8_T;  -- pebble.h:2435
         when others =>
            Comp : aliased Color_Component_Struct;  -- pebble.h:2441
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Gcolor8);
   pragma Unchecked_Union (Gcolor8);  -- pebble.h:2434

   package Colors is
      Black : constant Gcolor8 := (Discr => 0, Argb => 2#11000000#);
      Oxfordblue : constant Gcolor8 := (Discr => 0, Argb => 2#11000001#);
      Dukeblue : constant Gcolor8 := (Discr => 0, Argb => 2#11000010#);
      Blue : constant Gcolor8 := (Discr => 0, Argb => 2#11000011#);
      Darkgreen : constant Gcolor8 := (Discr => 0, Argb => 2#11000100#);
      Midnightgreen : constant Gcolor8 := (Discr => 0, Argb => 2#11000101#);
      Cobaltblue : constant Gcolor8 := (Discr => 0, Argb => 2#11000110#);
      Bluemoon : constant Gcolor8 := (Discr => 0, Argb => 2#11000111#);
      Islamicgreen : constant Gcolor8 := (Discr => 0, Argb => 2#11001000#);
      Jaegergreen : constant Gcolor8 := (Discr => 0, Argb => 2#11001001#);
      Tiffanyblue : constant Gcolor8 := (Discr => 0, Argb => 2#11001010#);
      Vividcerulean : constant Gcolor8 := (Discr => 0, Argb => 2#11001011#);
      Green : constant Gcolor8 := (Discr => 0, Argb => 2#11001100#);
      Malachite : constant Gcolor8 := (Discr => 0, Argb => 2#11001101#);
      Mediumspringgreen : constant Gcolor8 :=
        (Discr => 0, Argb => 2#11001110#);
      Cyan : constant Gcolor8 := (Discr => 0, Argb => 2#11001111#);
      Bulgarianrose : constant Gcolor8 := (Discr => 0, Argb => 2#11010000#);
      Imperialpurple : constant Gcolor8 := (Discr => 0, Argb => 2#11010001#);
      Indigo : constant Gcolor8 := (Discr => 0, Argb => 2#11010010#);
      Electricultramarine : constant Gcolor8 :=
        (Discr => 0, Argb => 2#11010011#);
      Armygreen : constant Gcolor8 := (Discr => 0, Argb => 2#11010100#);
      Darkgray : constant Gcolor8 := (Discr => 0, Argb => 2#11010101#);
      Liberty : constant Gcolor8 := (Discr => 0, Argb => 2#11010110#);
      Verylightblue : constant Gcolor8 := (Discr => 0, Argb => 2#11010111#);
      Kellygreen : constant Gcolor8 := (Discr => 0, Argb => 2#11011000#);
      Maygreen : constant Gcolor8 := (Discr => 0, Argb => 2#11011001#);
      Cadetblue : constant Gcolor8 := (Discr => 0, Argb => 2#11011010#);
      Pictonblue : constant Gcolor8 := (Discr => 0, Argb => 2#11011011#);
      Brightgreen : constant Gcolor8 := (Discr => 0, Argb => 2#11011100#);
      Screamingreen : constant Gcolor8 := (Discr => 0, Argb => 2#11011101#);
      Mediumaquamarine : constant Gcolor8 := (Discr => 0, Argb => 2#11011110#);
      Electricblue : constant Gcolor8 := (Discr => 0, Argb => 2#11011111#);
      Darkcandyapplered : constant Gcolor8 :=
        (Discr => 0, Argb => 2#11100000#);
      Jazzberryjam : constant Gcolor8 := (Discr => 0, Argb => 2#11100001#);
      Purple : constant Gcolor8 := (Discr => 0, Argb => 2#11100010#);
      Vividviolet : constant Gcolor8 := (Discr => 0, Argb => 2#11100011#);
      Windsortan : constant Gcolor8 := (Discr => 0, Argb => 2#11100100#);
      Rosevale : constant Gcolor8 := (Discr => 0, Argb => 2#11100101#);
      Purpureus : constant Gcolor8 := (Discr => 0, Argb => 2#11100110#);
      Lavenderindigo : constant Gcolor8 := (Discr => 0, Argb => 2#11100111#);
      Limerick : constant Gcolor8 := (Discr => 0, Argb => 2#11101000#);
      Brass : constant Gcolor8 := (Discr => 0, Argb => 2#11101001#);
      Lightgray : constant Gcolor8 := (Discr => 0, Argb => 2#11101010#);
      Babyblueeyes : constant Gcolor8 := (Discr => 0, Argb => 2#11101011#);
      Springbud : constant Gcolor8 := (Discr => 0, Argb => 2#11101100#);
      Inchworm : constant Gcolor8 := (Discr => 0, Argb => 2#11101101#);
      Mintgreen : constant Gcolor8 := (Discr => 0, Argb => 2#11101110#);
      Celeste : constant Gcolor8 := (Discr => 0, Argb => 2#11101111#);
      Red : constant Gcolor8 := (Discr => 0, Argb => 2#11110000#);
      Folly : constant Gcolor8 := (Discr => 0, Argb => 2#11110001#);
      Fashionmagenta : constant Gcolor8 := (Discr => 0, Argb => 2#11110010#);
      Magenta : constant Gcolor8 := (Discr => 0, Argb => 2#11110011#);
      Orange : constant Gcolor8 := (Discr => 0, Argb => 2#11110100#);
      Sunsetorange : constant Gcolor8 := (Discr => 0, Argb => 2#11110101#);
      Brilliantrose : constant Gcolor8 := (Discr => 0, Argb => 2#11110110#);
      Shockingpink : constant Gcolor8 := (Discr => 0, Argb => 2#11110111#);
      Chromeyellow : constant Gcolor8 := (Discr => 0, Argb => 2#11111000#);
      Rajah : constant Gcolor8 := (Discr => 0, Argb => 2#11111001#);
      Melon : constant Gcolor8 := (Discr => 0, Argb => 2#11111010#);
      Richbrilliantlavender : constant Gcolor8 :=
        (Discr => 0, Argb => 2#11111011#);
      Yellow       : constant Gcolor8 := (Discr => 0, Argb => 2#11111100#);
      Icterine     : constant Gcolor8 := (Discr => 0, Argb => 2#11111101#);
      Pastelyellow : constant Gcolor8 := (Discr => 0, Argb => 2#11111110#);
      White        : constant Gcolor8 := (Discr => 0, Argb => 2#11111111#);
   end Colors;

   subtype Gcolor is Gcolor8;

   function Gcolor_Equal
     (Arg1 : Gcolor8;
      Arg2 : Gcolor8) return U_Bool;  -- pebble.h:2449
   pragma Import (C, Gcolor_Equal, "gcolor_equal");
   function Gcolor_Legible_Over
     (Background : Gcolor8
     ) return Gcolor8;  -- pebble.h:2457
   pragma Import (C, Gcolor_Legible_Over, "gcolor_legible_over");

   type Gpoint is record
      X : aliased Int16_T;  -- pebble.h:2461
      Y : aliased Int16_T;  -- pebble.h:2463
   end record;
   pragma Convention (C_Pass_By_Copy, Gpoint);  -- pebble.h:2459

   function Gpoint_Equal
     (Arg1 : Opaque_Ptr;
      Arg2 : Opaque_Ptr) return U_Bool;  -- pebble.h:2476
   pragma Import (C, Gpoint_Equal, "gpoint_equal");

   type Gsize is record
      W : aliased Int16_T;  -- pebble.h:2481
      H : aliased Int16_T;  -- pebble.h:2483
   end record;
   pragma Convention (C_Pass_By_Copy, Gsize);  -- pebble.h:2479

   function Gsize_Equal
     (Arg1 : Opaque_Ptr;
      Arg2 : Opaque_Ptr) return U_Bool;  -- pebble.h:2496
   pragma Import (C, Gsize_Equal, "gsize_equal");

   type Grect is record
      Origin : aliased Gpoint;  -- pebble.h:2502
      Size   : aliased Gsize;  -- pebble.h:2504
   end record;
   pragma Convention (C_Pass_By_Copy, Grect);  -- pebble.h:2500

   function Equal
     (A, B : access constant Grect) return U_Bool;  -- pebble.h:2517
   pragma Import (C, Equal, "grect_equal");
   function "=" (A, B : access constant Grect) return U_Bool renames Equal;

   function Is_Empty
     (Rect : access constant Grect) return U_Bool;  -- pebble.h:2524
   pragma Import (C, Is_Empty, "grect_is_empty");

   procedure Standardize (Rect : access Grect);  -- pebble.h:2533
   pragma Import (C, Standardize, "grect_standardize");

   procedure Clip
     (Rect_To_Clip : access Grect;
      Rect_Clipper : access constant Grect);  -- pebble.h:2540
   pragma Import (C, Clip, "grect_clip");

   function Contains_Point
     (Rect  : access constant Grect;
      Point : access constant Gpoint) return U_Bool;  -- pebble.h:2546
   pragma Import (C, Contains_Point, "grect_contains_point");

   function Center_Point
     (Rect : access constant Grect) return Gpoint;  -- pebble.h:2552
   pragma Import (C, Center_Point, "grect_center_point");

   function Center_Point
     (Rect : Grect) return Gpoint is
     (Rect.Origin.X + Rect.Size.W / 2, Rect.Origin.Y + Rect.Size.H / 2);
   function Crop
     (Rect         : Grect;
      Crop_Size_Px : Int32_T) return Grect;  -- pebble.h:2562
   pragma Import (C, Crop, "grect_crop");

   type Gbitmapformat is
     (Gbitmapformat1bit,
      Gbitmapformat8bit,
      Gbitmapformat1bitpalette,
      Gbitmapformat2bitpalette,
      Gbitmapformat4bitpalette);
   pragma Convention (C, Gbitmapformat);  -- pebble.h:2571

  --<! 1-bit black and white. 0 = black, 1 = white.
  --<! 6-bit color + 2 bit alpha channel. See \ref GColor8 for pixel format.

   function Get_Bytes_Per_Row
     (Bitmap : Gbitmap) return Uint16_T;  -- pebble.h:2591
   pragma Import (C, Get_Bytes_Per_Row, "gbitmap_get_bytes_per_row");

   function Get_Format
     (Bitmap : Gbitmap) return Gbitmapformat;  -- pebble.h:2596
   pragma Import (C, Get_Format, "gbitmap_get_format");

   function Get_Data
     (Bitmap : Gbitmap) return access Uint8_T;  -- pebble.h:2604
   pragma Import (C, Get_Data, "gbitmap_get_data");

   procedure Set_Data
     (Bitmap          : Gbitmap;
      Data            : access Uint8_T;
      Format          : Gbitmapformat;
      Row_Size_Bytes  : Uint16_T;
      Free_On_Destroy : U_Bool);  -- pebble.h:2615
   pragma Import (C, Set_Data, "gbitmap_set_data");

   function Get_Bounds (Bitmap : Gbitmap) return Grect;  -- pebble.h:2623
   pragma Import (C, Get_Bounds, "gbitmap_get_bounds");

   procedure Set_Bounds (Bitmap : Gbitmap; Bounds : Grect);  -- pebble.h:2629
   pragma Import (C, Set_Bounds, "gbitmap_set_bounds");

   function Get_Palette
     (Bitmap : Gbitmap) return access Gcolor;  -- pebble.h:2635
   pragma Import (C, Get_Palette, "gbitmap_get_palette");

   procedure Set_Palette
     (Bitmap          : Gbitmap;
      Palette         : access Gcolor;
      Free_On_Destroy : U_Bool);  -- pebble.h:2646
   pragma Import (C, Set_Palette, "gbitmap_set_palette");

   function Create_With_Resource
     (Id : Uint32_T) return Gbitmap;  -- pebble.h:2653
   pragma Import (C, Create_With_Resource, "gbitmap_create_with_resource");

   function Create_With_Data
     (Data : access Uint8_T) return Gbitmap;  -- pebble.h:2668
   pragma Import (C, Create_With_Data, "gbitmap_create_with_data");

   function Create_As_Sub_Bitmap
     (Base_Bitmap : Gbitmap;
      Rect        : Grect) return Gbitmap;  -- pebble.h:2684
   pragma Import (C, Create_As_Sub_Bitmap, "gbitmap_create_as_sub_bitmap");

   function Create_From_Png_Data
     (Png_Data      : access Uint8_T;
      Png_Data_Size : Size_T) return Gbitmap;  -- pebble.h:2694
   pragma Import (C, Create_From_Png_Data, "gbitmap_create_from_png_data");

   function Create_Blank
     (Size   : Gsize;
      Format : Gbitmapformat) return Gbitmap;  -- pebble.h:2704
   pragma Import (C, Create_Blank, "gbitmap_create_blank");

   function Create_Blank_With_Palette
     (Size            : Gsize;
      Format          : Gbitmapformat;
      Palette         : access Gcolor;
      Free_On_Destroy : U_Bool) return Gbitmap;  -- pebble.h:2719
   pragma Import
     (C,
      Create_Blank_With_Palette,
      "gbitmap_create_blank_with_palette");

   function Create_Palettized_From_1bit
     (Src_Bitmap : Gbitmap) return Gbitmap;  -- pebble.h:2729
   pragma Import
     (C,
      Create_Palettized_From_1bit,
      "gbitmap_create_palettized_from_1bit");

   procedure Destroy (Bitmap : Gbitmap);  -- pebble.h:2739
   pragma Import (C, Destroy, "gbitmap_destroy");

   function Create_With_Resource
     (Resource_Id : Uint32_T) return Gbitmapsequence with
      Import        => True,
      Convention    => C,
     External_Name => "gbitmap_sequence_create_with_resource";
   --  pebble.h:2744

   function Update_Bitmap_Next_Frame
     (Bitmap_Sequence : Gbitmapsequence;
      Bitmap          : Gbitmap;
      Delay_Ms        : access Uint32_T) return U_Bool;  -- pebble.h:2756
   pragma Import
     (C,
      Update_Bitmap_Next_Frame,
      "gbitmap_sequence_update_bitmap_next_frame");

   function Update_Bitmap_By_Elapsed
     (Bitmap_Sequence : Gbitmapsequence;
      Bitmap          : Gbitmap;
      Elapsed_Ms      : Uint32_T) return U_Bool;  -- pebble.h:2773
   pragma Import
     (C,
      Update_Bitmap_By_Elapsed,
      "gbitmap_sequence_update_bitmap_by_elapsed");

   procedure Destroy (Bitmap_Sequence : Gbitmapsequence) with
      Import        => True,
      Convention    => C,
      External_Name => "gbitmap_sequence_destroy";
   --  pebble.h:2778

   function Restart
     (Bitmap_Sequence : Gbitmapsequence) return U_Bool;  -- pebble.h:2783
   pragma Import (C, Restart, "gbitmap_sequence_restart");

   function Get_Current_Frame_Idx
     (Bitmap_Sequence : Gbitmapsequence) return Int32_T;  -- pebble.h:2788
   pragma Import
     (C,
      Get_Current_Frame_Idx,
      "gbitmap_sequence_get_current_frame_idx");
   function Get_Total_Num_Frames
     (Bitmap_Sequence : Gbitmapsequence) return Uint32_T;  -- pebble.h:2793
   pragma Import
     (C,
      Get_Total_Num_Frames,
      "gbitmap_sequence_get_total_num_frames");
   function Get_Play_Count
     (Bitmap_Sequence : Gbitmapsequence) return Uint32_T;  -- pebble.h:2800
   pragma Import (C, Get_Play_Count, "gbitmap_sequence_get_play_count");
   procedure Set_Play_Count
     (Bitmap_Sequence : Gbitmapsequence;
      Play_Count      : Uint32_T);  -- pebble.h:2807
   pragma Import (C, Set_Play_Count, "gbitmap_sequence_set_play_count");
   function Get_Bitmap_Size
     (Bitmap_Sequence : Gbitmapsequence) return Gsize;  -- pebble.h:2814
   pragma Import (C, Get_Bitmap_Size, "gbitmap_sequence_get_bitmap_size");

   type Galign is
     (Galigncenter,
      Galigntopleft,
      Galigntopright,
      Galigntop,
      Galignleft,
      Galignbottom,
      Galignright,
      Galignbottomright,
      Galignbottomleft);
   pragma Convention (C, Galign);  -- pebble.h:2819

   procedure Align
     (Rect        : access Grect;
      Inside_Rect : access constant Grect;
      Alignment   : Galign;
      Clip        : U_Bool);  -- pebble.h:2850
   pragma Import (C, Align, "grect_align");

   type Gcompop is
     (Gcompopassign,
      Gcompopassigninverted,
      Gcompopor,
      Gcompopand,
      Gcompopclear,
      Gcompopset);
   pragma Convention (C, Gcompop);  -- pebble.h:2901

   procedure Set_Stroke_Color
     (Ctx   : Gcontext;
      Color : Gcolor);  -- pebble.h:2937
   pragma Import (C, Set_Stroke_Color, "graphics_context_set_stroke_color");
   procedure Set_Fill_Color (Ctx : Gcontext; Color : Gcolor);  -- pebble.h:2942
   pragma Import (C, Set_Fill_Color, "graphics_context_set_fill_color");
   procedure Set_Text_Color (Ctx : Gcontext; Color : Gcolor);  -- pebble.h:2947
   pragma Import (C, Set_Text_Color, "graphics_context_set_text_color");
   procedure Set_Compositing_Mode
     (Ctx  : Gcontext;
      Mode : Gcompop);  -- pebble.h:2958
   pragma Import
     (C,
      Set_Compositing_Mode,
      "graphics_context_set_compositing_mode");
   procedure Set_Antialiased
     (Ctx    : Gcontext;
      Enable : U_Bool);  -- pebble.h:2964
   pragma Import (C, Set_Antialiased, "graphics_context_set_antialiased");
   procedure Set_Stroke_Width
     (Ctx          : Gcontext;
      Stroke_Width : Uint8_T);  -- pebble.h:2973
   pragma Import (C, Set_Stroke_Width, "graphics_context_set_stroke_width");

   subtype Gcornermask is unsigned;
   Gcornernone        : constant Gcornermask := 0;
   Gcornertopleft     : constant Gcornermask := 1;
   Gcornertopright    : constant Gcornermask := 2;
   Gcornerbottomleft  : constant Gcornermask := 4;
   Gcornerbottomright : constant Gcornermask := 8;
   Gcornersall        : constant Gcornermask := 15;
   Gcornerstop        : constant Gcornermask := 3;
   Gcornersbottom     : constant Gcornermask := 12;
   Gcornersleft       : constant Gcornermask := 5;
   Gcornersright      : constant Gcornermask := 10;  -- pebble.h:3020
   procedure Draw_Pixel (Ctx : Gcontext; Point : Gpoint);  -- pebble.h:3025
   pragma Import (C, Draw_Pixel, "graphics_draw_pixel");
   procedure Draw_Line
     (Ctx : Gcontext;
      P0  : Gpoint;
      P1  : Gpoint);  -- pebble.h:3031
   pragma Import (C, Draw_Line, "graphics_draw_line");
   procedure Draw_Rect (Ctx : Gcontext; Rect : Grect);  -- pebble.h:3036
   pragma Import (C, Draw_Rect, "graphics_draw_rect");
   procedure Fill_Rect
     (Ctx           : Gcontext;
      Rect          : Grect;
      Corner_Radius : Uint16_T;
      Corner_Mask   : Gcornermask);  -- pebble.h:3044
   pragma Import (C, Fill_Rect, "graphics_fill_rect");
   procedure Draw_Circle
     (Ctx    : Gcontext;
      Point  : Gpoint;
      Radius : Uint16_T);  -- pebble.h:3050
   pragma Import (C, Draw_Circle, "graphics_draw_circle");
   procedure Fill_Circle
     (Ctx    : Gcontext;
      Point  : Gpoint;
      Radius : Uint16_T);  -- pebble.h:3056
   pragma Import (C, Fill_Circle, "graphics_fill_circle");
   procedure Draw_Round_Rect
     (Ctx    : Gcontext;
      Rect   : Grect;
      Radius : Uint16_T);  -- pebble.h:3062
   pragma Import (C, Draw_Round_Rect, "graphics_draw_round_rect");
   procedure Draw_Bitmap_In_Rect
     (Ctx    : Gcontext;
      Bitmap : Gbitmap;
      Rect   : Grect);  -- pebble.h:3075
   pragma Import (C, Draw_Bitmap_In_Rect, "graphics_draw_bitmap_in_rect");
   function Capture_Frame_Buffer
     (Ctx : Gcontext) return Gbitmap;  -- pebble.h:3079
   pragma Import (C, Capture_Frame_Buffer, "graphics_capture_frame_buffer");
   function Capture_Frame_Buffer_Format
     (Ctx    : Gcontext;
      Format : Gbitmapformat) return Gbitmap;  -- pebble.h:3103
   pragma Import
     (C,
      Capture_Frame_Buffer_Format,
      "graphics_capture_frame_buffer_format");
   function Release_Frame_Buffer
     (Ctx    : Gcontext;
      Buffer : Gbitmap) return U_Bool;  -- pebble.h:3113
   pragma Import (C, Release_Frame_Buffer, "graphics_release_frame_buffer");
   function Frame_Buffer_Is_Captured
     (Ctx : Gcontext) return U_Bool;  -- pebble.h:3120
   pragma Import
     (C,
      Frame_Buffer_Is_Captured,
      "graphics_frame_buffer_is_captured");
   procedure Draw_Rotated_Bitmap
     (Ctx      : Gcontext;
      Src      : Gbitmap;
      Src_Ic   : Gpoint;
      Rotation : int;
      Dest_Ic  : Gpoint);  -- pebble.h:3132
   pragma Import (C, Draw_Rotated_Bitmap, "graphics_draw_rotated_bitmap");

   type Gdrawcommandlistiteratorcb is access function
     (Command : Gdrawcommand;
      Index   : Uint32_T;
      Context : Opaque_Ptr) return U_Bool;
   pragma Convention (C, Gdrawcommandlistiteratorcb);  -- pebble.h:3196
   type Gdrawcommandtype is
     (Gdrawcommandtypeinvalid,
      Gdrawcommandtypepath,
      Gdrawcommandtypecircle,
      Gdrawcommandtypeprecisepath);
   pragma Convention (C, Gdrawcommandtype);  -- pebble.h:3208
   procedure Draw (Ctx : Gcontext; Command : Gdrawcommand);  -- pebble.h:3213
   pragma Import (C, Draw, "gdraw_command_draw");
   function Get_Type
     (Command : Gdrawcommand) return Gdrawcommandtype;  -- pebble.h:3218
   pragma Import (C, Get_Type, "gdraw_command_get_type");
   procedure Set_Fill_Color (Command : Gdrawcommand; Fill_Color : Gcolor) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_set_fill_color";
   --  pebble.h:3223

   function Get_Fill_Color
     (Command : Gdrawcommand) return Gcolor;  -- pebble.h:3228
   pragma Import (C, Get_Fill_Color, "gdraw_command_get_fill_color");
   procedure Set_Stroke_Color (Command : Gdrawcommand; Color : Gcolor) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_set_stroke_color";
   --  pebble.h:3233
   function Get_Stroke_Color
     (Command : Gdrawcommand) return Gcolor;  -- pebble.h:3238
   pragma Import (C, Get_Stroke_Color, "gdraw_command_get_stroke_color");
   procedure Set_Stroke_Width
     (Command      : Gdrawcommand;
      Stroke_Width : Uint8_T) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_set_stroke_width";
   --  pebble.h:3243
   function Get_Stroke_Width
     (Command : Gdrawcommand) return Uint8_T;  -- pebble.h:3248
   pragma Import (C, Get_Stroke_Width, "gdraw_command_get_stroke_width");
   function Get_Num_Points
     (Command : Gdrawcommand) return Uint16_T;  -- pebble.h:3251
   pragma Import (C, Get_Num_Points, "gdraw_command_get_num_points");
   procedure Set_Point
     (Command   : Gdrawcommand;
      Point_Idx : Uint16_T;
      Point     : Gpoint);  -- pebble.h:3257
   pragma Import (C, Set_Point, "gdraw_command_set_point");
   function Get_Point
     (Command   : Gdrawcommand;
      Point_Idx : Uint16_T) return Gpoint;  -- pebble.h:3264
   pragma Import (C, Get_Point, "gdraw_command_get_point");
   procedure Set_Radius
     (Command : Gdrawcommand;
      Radius  : Uint16_T);  -- pebble.h:3270
   pragma Import (C, Set_Radius, "gdraw_command_set_radius");
   function Get_Radius
     (Command : Gdrawcommand) return Uint16_T;  -- pebble.h:3276
   pragma Import (C, Get_Radius, "gdraw_command_get_radius");
   procedure Set_Path_Open
     (Command   : Gdrawcommand;
      Path_Open : U_Bool);  -- pebble.h:3283
   pragma Import (C, Set_Path_Open, "gdraw_command_set_path_open");
   function Get_Path_Open
     (Command : Gdrawcommand) return U_Bool;  -- pebble.h:3290
   pragma Import (C, Get_Path_Open, "gdraw_command_get_path_open");
   procedure Set_Hidden
     (Command : Gdrawcommand;
      Hiddeb  : U_Bool);  -- pebble.h:3296
   pragma Import (C, Set_Hidden, "gdraw_command_set_hidden");
   function Get_Hidden
     (Command : Gdrawcommand) return U_Bool;  -- pebble.h:3301
   pragma Import (C, Get_Hidden, "gdraw_command_get_hidden");
   procedure Frame_Draw
     (Ctx      : Gcontext;
      Sequence : Gdrawcommandsequence;
      Frame    : Gdrawcommandframe;
      Point    : Gpoint);  -- pebble.h:3308
   pragma Import (C, Frame_Draw, "gdraw_command_frame_draw");
   procedure Frame_Set_Duration
     (Frame    : Gdrawcommandframe;
      Duration : Uint32_T);  -- pebble.h:3314
   pragma Import (C, Frame_Set_Duration, "gdraw_command_frame_set_duration");
   function Frame_Get_Duration
     (Frame : Gdrawcommandframe) return Uint32_T;  -- pebble.h:3319
   pragma Import (C, Frame_Get_Duration, "gdraw_command_frame_get_duration");
   function Image_Create_With_Resource
     (Resource_Id : Uint32_T) return Opaque_Ptr;  -- pebble.h:3324
   pragma Import
     (C,
      Image_Create_With_Resource,
      "gdraw_command_image_create_with_resource");
   function Clone
     (Image : Gdrawcommandimage) return Gdrawcommandimage;  -- pebble.h:3329
   pragma Import (C, Clone, "gdraw_command_image_clone");
   procedure Destroy (Image : Gdrawcommandimage) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_image_destroy";
   --  pebble.h:3333
   procedure Draw
     (Ctx    : Gcontext;
      Image  : Gdrawcommandimage;
      Offset : Gpoint) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_image_draw";
   --  pebble.h:3339
   function Get_Bounds_Size
     (Image : Gdrawcommandimage) return Gsize;  -- pebble.h:3345
   pragma Import (C, Get_Bounds_Size, "gdraw_command_image_get_bounds_size");
   procedure Set_Bounds_Size
     (Image : Gdrawcommandimage;
      Size  : Gsize);  -- pebble.h:3351
   pragma Import (C, Set_Bounds_Size, "gdraw_command_image_set_bounds_size");
   function Get_Command_List
     (Image : Gdrawcommandimage) return Gdrawcommandlist;  -- pebble.h:3356
   pragma Import (C, Get_Command_List, "gdraw_command_image_get_command_list");
   procedure List_Iterate
     (Command_List   : Gdrawcommandlist;
      Handle_Command : Gdrawcommandlistiteratorcb;
      Context        : Opaque_Ptr);  -- pebble.h:3362
   pragma Import (C, List_Iterate, "gdraw_command_list_iterate");
   procedure List_Draw
     (Ctx          : Gcontext;
      Command_List : Gdrawcommandlist);  -- pebble.h:3368
   pragma Import (C, List_Draw, "gdraw_command_list_draw");
   function Get_Command
     (Command_List : Gdrawcommandlist;
      Index        : Uint16_T) return Opaque_Ptr;  -- pebble.h:3375
   pragma Import (C, Get_Command, "gdraw_command_list_get_command");
   function Get_Num_Commands
     (Command_List : Gdrawcommandlist) return Uint32_T;  -- pebble.h:3380
   pragma Import (C, Get_Num_Commands, "gdraw_command_list_get_num_commands");
   function Create_With_Resource
     (Arg1 : Uint32_T) return Gdrawcommandsequence with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_sequence_create_with_resource";
   --  pebble.h:3385
   function Clone
     (Sequence : Gdrawcommandsequence) return Gdrawcommandsequence with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_sequence_clone";
   --  pebble.h:3394
   procedure Destroy (Sequence : Gdrawcommandsequence) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_sequence_destroy";
   function Get_Frame_By_Elapsed
     (Sequence   : Gdrawcommandsequence;
      Elapsed_Ms : Uint32_T) return Gdrawcommandframe;  -- pebble.h:3401
   pragma Import
     (C,
      Get_Frame_By_Elapsed,
      "gdraw_command_sequence_get_frame_by_elapsed");
   function Get_Frame_By_Index
     (Sequence : Gdrawcommandsequence;
      Index    : Uint32_T) return Gdrawcommandframe;  -- pebble.h:3408
   pragma Import
     (C,
      Get_Frame_By_Index,
      "gdraw_command_sequence_get_frame_by_index");
   function Get_Bounds_Size (Sequence : Gdrawcommandsequence) return Gsize with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_sequence_get_bounds_size";
   --  pebble.h:3416
   procedure Set_Bounds_Size
     (Sequence : Gdrawcommandsequence;
      Size     : Gsize) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_sequence_set_bounds_size";
   --  pebble.h:3423
   function Get_Play_Count
     (Sequence : Gdrawcommandsequence) return Uint32_T with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_sequence_get_play_count";
   --  pebble.h:3428
   procedure Set_Play_Count
     (Sequence : Gdrawcommandsequence;
      Arg2     : Uint32_T) with
      Import        => True,
      Convention    => C,
      External_Name => "gdraw_command_sequence_set_play_count";
   --  pebble.h:3433
   function Get_Total_Duration
     (Sequence : Gdrawcommandsequence) return Uint32_T;  -- pebble.h:3438
   pragma Import
     (C,
      Get_Total_Duration,
      "gdraw_command_sequence_get_total_duration");
   function Get_Num_Frames
     (Sequence : Gdrawcommandsequence) return Uint32_T;  -- pebble.h:3443
   pragma Import (C, Get_Num_Frames, "gdraw_command_sequence_get_num_frames");

   type Gpoint_Array is array (Uint32_T range <>) of Gpoint;
   pragma Convention (C, Gpoint_Array);

   type Gpathinfo is record
      Num_Points : aliased Uint32_T;  -- pebble.h:3488
      Points     : access Gpoint;  -- pebble.h:3490
   end record;
   pragma Convention (C_Pass_By_Copy, Gpathinfo);  -- pebble.h:3486

   type Gpath is private;
   Null_Gpath : constant Gpath;

   function Create
     (Init : access constant Gpathinfo) return Gpath;  -- pebble.h:3516
   pragma Import (C, Create, "gpath_create");

   procedure Destroy (Path : Gpath) with
      Import        => True,
      Convention    => C,
      External_Name => "gpath_destroy";
   --  pebble.h:3519

   procedure Draw_Filled (Ctx : Gcontext; Path : Gpath);  -- pebble.h:3526
   pragma Import (C, Draw_Filled, "gpath_draw_filled");

   procedure Draw_Outline (Ctx : Gcontext; Path : Gpath);  -- pebble.h:3535
   pragma Import (C, Draw_Outline, "gpath_draw_outline");

   procedure Rotate_To (Path : Gpath; Angle : Int32_T);  -- pebble.h:3545
   pragma Import (C, Rotate_To, "gpath_rotate_to");

   procedure Move_To (Arg1 : Gpath; Pt : Gpoint);  -- pebble.h:3554
   pragma Import (C, Move_To, "gpath_move_to");

   procedure Draw_Outline_Open
     (Ctx  : Gcontext;
      Path : Gpath);  -- pebble.h:3563
   pragma Import (C, Draw_Outline_Open, "gpath_draw_outline_open");

   type Gfont is private;  -- pebble.h:3578

   function Get_System_Font
     (Str : Strings_Interface.Chars_Ptr) return Gfont;  -- pebble.h:3585
   pragma Import (C, Get_System_Font, "fonts_get_system_font");

   function Load_Custom_Font
     (Handle : Reshandle) return Gfont;  -- pebble.h:3595
   pragma Import (C, Load_Custom_Font, "fonts_load_custom_font");

   procedure Unload_Custom_Font (Font : Gfont);  -- pebble.h:3602
   pragma Import (C, Unload_Custom_Font, "fonts_unload_custom_font");

   type Gtextoverflowmode is
     (Gtextoverflowmodewordwrap,
      Gtextoverflowmodetrailingellipsis,
      Gtextoverflowmodefill);
   pragma Convention (C, Gtextoverflowmode);  -- pebble.h:3628

   type Gtextalignment is
     (Gtextalignmentleft, Gtextalignmentcenter, Gtextalignmentright);
   pragma Convention (C, Gtextalignment);  -- pebble.h:3640

   type Gtextlayoutcacheref is new Opaque_Ptr;  -- pebble.h:3646
   Null_Cacheref : constant Gtextlayoutcacheref :=
     Gtextlayoutcacheref (System.Null_Address);

   procedure Draw_Text
     (Ctx           : Gcontext;
      Text          : Strings_Interface.Chars_Ptr;
      Font          : Gfont;
      Box           : Grect;
      Overflow_Mode : Gtextoverflowmode;
      Alignment     : Gtextalignment;
      Cache         : Gtextlayoutcacheref);  -- pebble.h:3658
   pragma Import (C, Draw_Text, "graphics_draw_text");

   function Graphics_Text_Layout_Get_Content_Size
     (Arg1 : Strings_Interface.Chars_Ptr;
      Arg2 : Gfont;
      Arg3 : Grect;
      Arg4 : Gtextoverflowmode;
      Arg5 : Gtextalignment) return Gsize;  -- pebble.h:3667
   pragma Import
     (C,
      Graphics_Text_Layout_Get_Content_Size,
      "graphics_text_layout_get_content_size");

private
   type Gfont is new Opaque_Ptr;  -- pebble.h:3578
   type Gpath is new Opaque_Ptr;
   Null_Gpath : constant Gpath := Gpath (System.Null_Address);

   type Gcontext is new Opaque_Ptr;
   type Gbitmap is new Opaque_Ptr;
   type Gbitmapsequence is new Opaque_Ptr;
   type Gdrawcommand is new Opaque_Ptr;
   type Gdrawcommandframe is new Opaque_Ptr;
   type Gdrawcommandimage is new Opaque_Ptr;
   type Gdrawcommandlist is new Opaque_Ptr;
   type Gdrawcommandsequence is new Opaque_Ptr;

   Null_Gcontext        : constant Gcontext := Gcontext (Null_Opaque_Ptr);
   Null_Gbitmap         : constant Gbitmap := Gbitmap (Null_Opaque_Ptr);
   Null_Gbitmapsequence : constant Gbitmapsequence :=
     Gbitmapsequence (Null_Opaque_Ptr);
   Null_Gdrawcommand : constant Gdrawcommand := Gdrawcommand (Null_Opaque_Ptr);
   Null_Gdrawcommandframe : constant Gdrawcommandframe :=
     Gdrawcommandframe (Null_Opaque_Ptr);
   Null_Gdrawcommandimage : constant Gdrawcommandimage :=
     Gdrawcommandimage (Null_Opaque_Ptr);
   Null_Gdrawcommandlist : constant Gdrawcommandlist :=
     Gdrawcommandlist (Null_Opaque_Ptr);
   Null_Gdrawcommandsequence : constant Gdrawcommandsequence :=
     Gdrawcommandsequence (Null_Opaque_Ptr);

end Pebble.Graphics;
