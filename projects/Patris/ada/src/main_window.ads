package Main_Window is

   procedure Init;
   pragma Export (C, Init, "ada_init");
   procedure Deinit;
   pragma Export (C, Deinit, "ada_deinit");

   procedure Last_Chance_Handler;
   pragma Export (C, Last_Chance_Handler, "__gnat_last_chance_handler");

end Main_Window;
