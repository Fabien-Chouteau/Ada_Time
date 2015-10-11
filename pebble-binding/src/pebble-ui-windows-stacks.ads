package Pebble.Ui.Windows.Stacks is
   procedure Push (Win : Window; Animated : U_Bool);  -- pebble.h:4186
   pragma Import (C, Push, "window_stack_push");

   function Pop (Animated : U_Bool) return Window;  -- pebble.h:4191
   pragma Import (C, Pop, "window_stack_pop");

   procedure Pop_All (Animated : U_Bool);  -- pebble.h:4195
   pragma Import (C, Pop_All, "window_stack_pop_all");

   function Remove
     (Win      : Window;
      Animated : U_Bool) return U_Bool;  -- pebble.h:4209
   pragma Import (C, Remove, "window_stack_remove");

   function Get_Top_Window return Window;  -- pebble.h:4214
   pragma Import (C, Get_Top_Window, "window_stack_get_top_window");

   function Contains_Window (Win : Window) return U_Bool;  -- pebble.h:4219
   pragma Import (C, Contains_Window, "window_stack_contains_window");

end Pebble.Ui.Windows.Stacks;
