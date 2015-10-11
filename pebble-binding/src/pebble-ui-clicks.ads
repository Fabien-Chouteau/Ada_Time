package Pebble.Ui.Clicks is
   type Clickrecognizerref is private;  -- pebble.h:3685

   type Clickhandler is access procedure
     (Recognizer : Clickrecognizerref;
      Context    : Opaque_Ptr);
   pragma Convention (C, Clickhandler);  -- pebble.h:3692

   type Clickconfigprovider is access procedure (Context : Opaque_Ptr);
   pragma Convention (C, Clickconfigprovider);  -- pebble.h:3705

   function Number_Of_Clicks_Counted
     (Recognizer : Clickrecognizerref) return Uint8_T;  -- pebble.h:3712
   pragma Import
     (C,
      Number_Of_Clicks_Counted,
      "click_number_of_clicks_counted");

   function Get_Button_Id
     (Recognizer : Clickrecognizerref) return Buttonid;  -- pebble.h:3718
   pragma Import (C, Get_Button_Id, "click_recognizer_get_button_id");

   function Is_Repeating
     (Recognizer : Clickrecognizerref) return U_Bool;  -- pebble.h:3724
   pragma Import (C, Is_Repeating, "click_recognizer_is_repeating");

private
   type Clickrecognizerref is new Opaque_Ptr;  -- pebble.h:3685
end Pebble.Ui.Clicks;
