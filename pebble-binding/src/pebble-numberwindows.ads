package Pebble.Numberwindows is
   type Number_Window is private;
   Null_Number_Window : constant Number_Window;

   type Number_Window_Callback is access procedure
     (Nw      : Number_Window;
      Context : Opaque_Ptr);
   pragma Convention (C, Number_Window_Callback);  -- pebble.h:6417

   type Number_Window_Callbacks is record
      Incremented : Number_Window_Callback;  -- pebble.h:6423
      Decremented : Number_Window_Callback;  -- pebble.h:6426
      Selected    : Number_Window_Callback;  -- pebble.h:6430
   end record;
   pragma Convention
     (C_Pass_By_Copy,
      Number_Window_Callbacks);  -- pebble.h:6431

   function Create
     (Label     : Strings_Interface.Chars_Ptr;
      Callbacks : Number_Window_Callbacks;
      Context   : Opaque_Ptr) return Number_Window;  -- pebble.h:6441
   pragma Import (C, Create, "number_window_create");

   procedure Destroy (Nw : Number_Window);  -- pebble.h:6444
   pragma Import (C, Destroy, "number_window_destroy");

   procedure Set_Label
     (Nw    : Number_Window;
      Label : Strings_Interface.Chars_Ptr);  -- pebble.h:6451
   pragma Import (C, Set_Label, "number_window_set_label");

   procedure Set_Max (Nw : Number_Window; Max : Int32_T);  -- pebble.h:6457
   pragma Import (C, Set_Max, "number_window_set_max");

   procedure Set_Min (Nw : Number_Window; Min : Int32_T);  -- pebble.h:6463
   pragma Import (C, Set_Min, "number_window_set_min");

   procedure Set_Value (Nw : Number_Window; Value : Int32_T);  -- pebble.h:6469
   pragma Import (C, Set_Value, "number_window_set_value");

   procedure Set_Step_Size
     (Nw   : Number_Window;
      Step : Int32_T);  -- pebble.h:6475
   pragma Import (C, Set_Step_Size, "number_window_set_step_size");

   function Get_Value (Nw : Number_Window) return Int32_T;  -- pebble.h:6481
   pragma Import (C, Get_Value, "number_window_get_value");

   function Get_Window (Nw : Number_Window) return Window;  -- pebble.h:6486
   pragma Import (C, Get_Window, "number_window_get_window");

private
   type Number_Window is new Opaque_Ptr;
   Null_Number_Window : constant Number_Window :=
     Number_Window (Null_Opaque_Ptr);
end Pebble.Numberwindows;
