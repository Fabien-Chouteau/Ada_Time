with Pebble.Graphics;  use Pebble.Graphics;
with Pebble.Ui.Layers; use Pebble.Ui.Layers;

package Pebble.Ui.Animations is

   type Animation is private;
   Null_Animation : constant Animation;

   type Animation_Array is array (Integer range <>) of Animation;
   pragma Convention (C, Animation_Array);

   subtype Animation_Progress is Int32_T;  -- pebble.h:4240

   subtype Animation_Curve is unsigned;
   Animation_Curve_Linear                      : constant Animation_Curve := 0;
   Animation_Curve_Easein                      : constant Animation_Curve := 1;
   Animation_Curve_Easeout                     : constant Animation_Curve := 2;
   Animation_Curve_Easeinout                   : constant Animation_Curve := 3;
   Animation_Curve_Default                     : constant Animation_Curve := 3;
   Animation_Curve_Customfunction              : constant Animation_Curve := 4;
   Animation_Curve_Custominterpolationfunction : constant Animation_Curve := 5;
   Animation_Curve_Reserved1                   : constant Animation_Curve := 6;
   Animation_Curve_Reserved2 : constant Animation_Curve := 7;  -- pebble.h:4261

   function Create return Animation;  -- pebble.h:4274
   pragma Import (C, Create, "animation_create");

   function Destroy (Anim : Animation) return U_Bool;  -- pebble.h:4278
   pragma Import (C, Destroy, "animation_destroy");

   function Clone (From : Animation) return Animation;  -- pebble.h:4295
   pragma Import (C, Clone, "animation_clone");

   function Sequence_Create
     (Anim_A : Animation;
      Anim_B : Animation;
      Anim_C : Animation  -- , ...
      ) return Animation;  -- pebble.h:4306
   pragma Import (C, Sequence_Create, "animation_sequence_create");

   function Sequence_Create_From_Array
     (Anim_Array : Animation_Array;
      Array_Len  : Uint32_T) return Animation;  -- pebble.h:4314
   pragma Import
     (C,
      Sequence_Create_From_Array,
      "animation_sequence_create_from_array");

   function Spawn_Create
     (Anim_A : Animation;
      Anim_B : Animation;
      Anim_C : Animation  -- , ...
      ) return Animation;  -- pebble.h:4325
   pragma Import (C, Spawn_Create, "animation_spawn_create");

   function Spawn_Create_From_Array
     (Anim_Array : Animation_Array;
      Array_Len  : Uint32_T) return Opaque_Ptr;  -- pebble.h:4333
   pragma Import
     (C,
      Spawn_Create_From_Array,
      "animation_spawn_create_from_array");

   function Set_Elapsed
     (Anim       : Animation;
      Elapsed_Ms : Uint32_T) return U_Bool;  -- pebble.h:4340
   pragma Import (C, Set_Elapsed, "animation_set_elapsed");

   function Get_Elapsed
     (Anim       : Animation;
      Elapsed_Ms : access Int32_T) return U_Bool;  -- pebble.h:4348
   pragma Import (C, Get_Elapsed, "animation_get_elapsed");

   function Set_Reverse
     (Anim     : Animation;
      Reversed : U_Bool) return U_Bool;  -- pebble.h:4357
   pragma Import (C, Set_Reverse, "animation_set_reverse");

   function Get_Reverse (Anim : Animation) return U_Bool;  -- pebble.h:4362
   pragma Import (C, Get_Reverse, "animation_get_reverse");

   function Set_Play_Count
     (Anim       : Animation;
      Play_Count : Uint32_T) return U_Bool;  -- pebble.h:4372
   pragma Import (C, Set_Play_Count, "animation_set_play_count");

   function Get_Play_Count
     (Anim : Animation) return Uint32_T;  -- pebble.h:4377
   pragma Import (C, Get_Play_Count, "animation_get_play_count");

   function Set_Duration
     (Anim        : Animation;
      Duration_Ms : Uint32_T) return U_Bool;  -- pebble.h:4387
   pragma Import (C, Set_Duration, "animation_set_duration");

   function Get_Duration
     (Anim               : Animation;
      Include_Delay      : U_Bool;
      Include_Play_Count : U_Bool) return Uint32_T;  -- pebble.h:4396
   pragma Import (C, Get_Duration, "animation_get_duration");

   function Set_Delay
     (Anim     : Animation;
      Delay_Ms : Uint32_T) return U_Bool;  -- pebble.h:4406
   pragma Import (C, Set_Delay, "animation_set_delay");

   function Get_Delay (Anim : Animation) return Uint32_T;  -- pebble.h:4411
   pragma Import (C, Get_Delay, "animation_get_delay");

   function Set_Curve
     (Anim  : Animation;
      Curve : Animation_Curve) return U_Bool;  -- pebble.h:4421
   pragma Import (C, Set_Curve, "animation_set_curve");

   function Get_Curve
     (Anim : Animation) return Animation_Curve;  -- pebble.h:4426
   pragma Import (C, Get_Curve, "animation_get_curve");

   type Animationcurvefunction is access function
     (Arg1 : Animation_Progress) return Animation_Progress;
   pragma Convention (C, Animationcurvefunction);  -- pebble.h:4431

   function Set_Custom_Curve
     (Anim : Animation;
      Arg2 : Animationcurvefunction) return U_Bool;  -- pebble.h:4441
   pragma Import (C, Set_Custom_Curve, "animation_set_custom_curve");

   function Get_Custom_Curve
     (Anim : Animation) return Animationcurvefunction;  -- pebble.h:4446
   pragma Import (C, Get_Custom_Curve, "animation_get_custom_curve");

   type Animation_Started_Handler is access procedure
     (Anim    : Animation;
      Context : Opaque_Ptr);
   pragma Convention (C, Animation_Started_Handler);  -- pebble.h:4455

   type Animation_Stopped_Handler is access procedure
     (Anim     : Animation;
      Finished : U_Bool;
      Context  : Opaque_Ptr);
   pragma Convention (C, Animation_Stopped_Handler);  -- pebble.h:4468

   type Animation_Handlers is record
      Started : Animation_Started_Handler;  -- pebble.h:4475
      Stopped : Animation_Stopped_Handler;  -- pebble.h:4477
   end record;
   pragma Convention (C_Pass_By_Copy, Animation_Handlers);  -- pebble.h:4473

   function Set_Handlers
     (Anim      : Animation;
      Callbacks : Animation_Handlers;
      Context   : Opaque_Ptr) return U_Bool;  -- pebble.h:4492
   pragma Import (C, Set_Handlers, "animation_set_handlers");

   function Get_Context (Anim : Animation) return Opaque_Ptr;  -- pebble.h:4500
   pragma Import (C, Get_Context, "animation_get_context");

   function Schedule (Anim : Animation) return U_Bool;  -- pebble.h:4515
   pragma Import (C, Schedule, "animation_schedule");

   function Unschedule (Anim : Animation) return U_Bool;  -- pebble.h:4525
   pragma Import (C, Unschedule, "animation_unschedule");

   procedure Unschedule_All;  -- pebble.h:4529
   pragma Import (C, Unschedule_All, "animation_unschedule_all");

   function Is_Scheduled (Anim : Animation) return U_Bool;  -- pebble.h:4538
   pragma Import (C, Is_Scheduled, "animation_is_scheduled");

   type Animation_Setup_Implementation_Handler is access procedure
     (Anim : Animation);
   pragma Convention
     (C,
      Animation_Setup_Implementation_Handler);  -- pebble.h:4545

   type Animation_Update_Implementation_Handler is access procedure
     (Anim     : Animation;
      Progress : Animation_Progress);
   pragma Convention
     (C,
      Animation_Update_Implementation_Handler);  -- pebble.h:4567

   type Animation_Teardown_Implementation_Handler is access procedure
     (Anim : Animation);
   pragma Convention
     (C,
      Animation_Teardown_Implementation_Handler);  -- pebble.h:4577

   type Animation_Implementation_Handlers is record
      Setup    : Animation_Setup_Implementation_Handler;  -- pebble.h:4597
      Update   : Animation_Update_Implementation_Handler;  -- pebble.h:4600
      Teardown : Animation_Teardown_Implementation_Handler;  -- pebble.h:4603
   end record;
   pragma Convention
     (C_Pass_By_Copy,
      Animation_Implementation_Handlers);  -- pebble.h:4594

   type Animation_Implementation is
     access constant Animation_Implementation_Handlers;

   function Set_Implementation
     (Anim           : Animation;
      Implementation : Animation_Implementation)
     return U_Bool;  -- pebble.h:4617
   pragma Import (C, Set_Implementation, "animation_set_implementation");

   function Get_Implementation
     (Anim : Animation) return Animation_Implementation;  -- pebble.h:4624
   pragma Import (C, Get_Implementation, "animation_get_implementation");

   type Property_Animation is private;
   Null_Property_Animation : constant Property_Animation;

   subtype Gpointreturn is Gpoint;

   subtype Grectreturn is Grect;

   type Int16setter is access procedure
     (Subject : Opaque_Ptr;
      Int16   : Int16_T);
   pragma Convention (C, Int16setter);  -- pebble.h:4805

   type Int16getter is access function (Subject : Opaque_Ptr) return Int16_T;
   pragma Convention (C, Int16getter);  -- pebble.h:4811

   type Uint32setter is access procedure
     (Subject : Opaque_Ptr;
      Uint32  : Uint32_T);
   pragma Convention (C, Uint32setter);  -- pebble.h:4816

   type Uint32getter is access function (Subjecy : Opaque_Ptr) return Uint32_T;
   pragma Convention (C, Uint32getter);  -- pebble.h:4822

   type Gpointsetter is access procedure
     (Subject : Opaque_Ptr;
      Point   : Gpoint);
   pragma Convention (C, Gpointsetter);  -- pebble.h:4827

   type Gpointgetter is access function
     (Subject : Opaque_Ptr) return Gpointreturn;
   pragma Convention (C, Gpointgetter);  -- pebble.h:4832

   type Grectsetter is access procedure (Subject : Opaque_Ptr; Rect : Grect);
   pragma Convention (C, Grectsetter);  -- pebble.h:4837

   type Grectgetter is access function
     (Subject : Opaque_Ptr) return Grectreturn;
   pragma Convention (C, Grectgetter);  -- pebble.h:4842

   type Gcolor8setter is access procedure
     (Subject : Opaque_Ptr;
      Color   : Gcolor8);
   pragma Convention (C, Gcolor8setter);  -- pebble.h:4847

   type Gcolor8getter is access function (Subject : Opaque_Ptr) return Gcolor8;
   pragma Convention (C, Gcolor8getter);  -- pebble.h:4853

   type Setter_Union (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Int16 : Int16setter;  -- pebble.h:4869
         when 1 =>
            Gpoint : Gpointsetter;  -- pebble.h:4871
         when 2 =>
            Grect : Grectsetter;  -- pebble.h:4873
         when 3 =>
            Gcolor8 : Gcolor8setter;  -- pebble.h:4875
         when others =>
            Uint32 : Uint32setter;  -- pebble.h:4877
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Setter_Union);
   pragma Unchecked_Union (Setter_Union);  -- pebble.h:4867

   type Getter_Union (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Int16 : Int16getter;  -- pebble.h:4885
         when 1 =>
            Gpoint : Gpointgetter;  -- pebble.h:4887
         when 2 =>
            Grect : Grectgetter;  -- pebble.h:4889
         when 3 =>
            Gcolor8 : Gcolor8getter;  -- pebble.h:4891
         when others =>
            Uint32 : Uint32getter;  -- pebble.h:4893
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Getter_Union);
   pragma Unchecked_Union (Getter_Union);  -- pebble.h:4883

   type Property_Animation_Accessors is record
      Setter : Setter_Union;  -- pebble.h:4878
      Getter : Getter_Union;  -- pebble.h:4894
   end record;
   pragma Convention
     (C_Pass_By_Copy,
      Property_Animation_Accessors);  -- pebble.h:4895

   type Property_Animation_Implementation is record
      Base      : aliased Animation_Implementation_Handlers;  -- pebble.h:4902
      Accessors : aliased Property_Animation_Accessors;  -- pebble.h:4904
   end record;
   pragma Convention
     (C_Pass_By_Copy,
      Property_Animation_Implementation);  -- pebble.h:4900

   function Create_Layer_Frame
     (L          : Layer;
      From_Frame : access Grect;
      To_Frame   : access Grect) return Property_Animation;  -- pebble.h:4699
   pragma Import
     (C,
      Create_Layer_Frame,
      "property_animation_create_layer_frame");

   function Create_Bounds_Origin
     (L    : Layer;
      From : access Gpoint;
      To   : access Gpoint) return Property_Animation;  -- pebble.h:4710
   pragma Import
     (C,
      Create_Bounds_Origin,
      "property_animation_create_bounds_origin");

   function Create
     (Implementation : Property_Animation_Implementation;
      Subject        : Opaque_Ptr;
      From_Value     : Opaque_Ptr;
      To_Value       : Opaque_Ptr) return Property_Animation with
      Import        => True,
      Convention    => C,
      External_Name => "property_animation_create";  -- pebble.h:4730

   procedure Destroy (Pa : Property_Animation) with
      Import        => True,
      Convention    => C,
      External_Name => "property_animation_destroy";  -- pebble.h:4735

   procedure Update_Int16
     (Pa                  : Property_Animation;
      Distance_Normalized : Uint32_T);  -- pebble.h:4748
   pragma Import (C, Update_Int16, "property_animation_update_int16");

   procedure Update_Uint32
     (Pa                  : Property_Animation;
      Distance_Normalized : Uint32_T);  -- pebble.h:4762
   pragma Import (C, Update_Uint32, "property_animation_update_uint32");

   procedure Update_Gpoint
     (Pa                  : Property_Animation;
      Distance_Normalized : Uint32_T);  -- pebble.h:4777
   pragma Import (C, Update_Gpoint, "property_animation_update_gpoint");

   procedure Update_Grect
     (Pa                  : Property_Animation;
      Distance_Normalized : Uint32_T);  -- pebble.h:4791
   pragma Import (C, Update_Grect, "property_animation_update_grect");

   function Get_Animation
     (Pa : Property_Animation) return Animation;  -- pebble.h:4910
   pragma Import (C, Get_Animation, "property_animation_get_animation");

   function Subject
     (Pa      : Property_Animation;
      Subject : access Opaque_Ptr;
      Set     : U_Bool) return U_Bool;  -- pebble.h:5020
   pragma Import (C, Subject, "property_animation_subject");

   function From
     (Pa   : Property_Animation;
      From : Opaque_Ptr;
      Size : Size_T;
      Set  : U_Bool) return U_Bool;  -- pebble.h:5028
   pragma Import (C, From, "property_animation_from");

   function To
     (Pa   : Property_Animation;
      To   : Opaque_Ptr;
      Size : Size_T;
      Set  : U_Bool) return U_Bool;  -- pebble.h:5037
   pragma Import (C, To, "property_animation_to");

private
   type Animation is new Opaque_Ptr;
   Null_Animation : constant Animation := Animation (Null_Opaque_Ptr);
   type Property_Animation is new Opaque_Ptr;
   Null_Property_Animation : constant Property_Animation :=
     Property_Animation (Null_Opaque_Ptr);

   for Animation_Array'Component_Size use 32;
end Pebble.Ui.Animations;
