Require Import BenB.
Require Import BenB2.

(* ====================================================================== *)

(* 
   Title: 
   
    ##############
    # Safe Wheel #
    ##############
   
   Authors:
   Todd Bellavia - s1032723
   Bayu Fransz - s1043904
   Nikola Beerkens - s1041042
   Vamsi Yerramsetti - s1032599
*)

(* ====================================================================== *)



(*
   Abstract:
   =========

   (* Managed to prove it.
      It did change from what we had originally planned, but only in minor things,
        for example: we opted to use a battery instead of a wire connected to a car battery and
        we also added a switch to be able to turn the device on/off. *)

*)

(*
   Focus:

   Modeling Goal:
   ==============
   Verification model


   Fragment of reality:
   ====================
   Safe Wheel: steering wheel, person's hands, automobile


   Perspective:
   ============
   LEDs and Buzzers switch on when a driver has at least one of their hands off the wheel for a short
   duration of time, and switch off when both hands are back on the wheel.

*)


(*
   Abstractions or simplifications:
   ================================
   [
     -Both blue and red LEDs are considered the same.
     -Wire clenchers hold the wires together and completes the circuit inside.
     -We also assume that the wheel is already on a car.
     -The battery has power.
   ]

*)

(* ====================================================================== *)

(* Domain model *)

(* Domains (including their meaning) *)

Variable SW: Set.
    (* The set of all Safewheel cases. 
    Note that this is just the cover of the whole system, not the entire SafeWheel itself. *)
    
Definition T := R.
    (* Time in seconds in real numbers. *)
    
Variable B: Set.
    (* The set of all buttons. *)
    
Variable Bu: Set.
    (* The set of all buzzers. *)
    
Variable L: Set.
    (* The set of all LED lights. *)
    
Variable Ti: Set.
    (* The set of all timers. *)
    
Variable Swi: Set.
    (* The set of all switched. *)

(* Predicates (including their meaning and measurements) *)

Variable batteryPowered (* s t *): SW -> T -> Prop.
    (* The battery has power at time t in Safewheel cover s. *)
    (* Check with a multimeter if output is live. *)
    
Variable switchOn (* swi s t *):Swi -> SW -> T -> Prop.
    (* Switch swi is turned on at time t in SafeWheel cover s. *)
    (* Check if the switch is flipped to "ON". *)

Variable buttonIsPressedBotLeft (* b s t *):B -> SW -> T -> Prop.
    (* On the left side of SafeWheel cover s, at time t the bottom left button b is pressed. *)
    (* Look to check if the button is pushed in. *)
    
Variable buttonIsPressedTopLeft (* b s t *):B -> SW -> T -> Prop.
    (* On the left side of SafeWheel cover s, at time t the top left button b is pressed. *)
    (* Look to check if the button is pushed in. *)    
    
Variable buttonIsPressedBotRight (* b s t *):B -> SW -> T -> Prop.
    (* On the right side of SafeWheel cover s, at time t the bottom right button b is pressed. *)
    (* Look to check if the button is pushed in. *)    

Variable buttonIsPressedTopRight (* b s t *):B -> SW -> T -> Prop.
    (* On the right side of SafeWheel cover s, at time t top right button b is pressed. *)
    (* Look to check if the button is pushed in. *)
    
Variable buzzes (* bu s t *):Bu -> SW -> T -> Prop.
    (* Buzzer bu buzzes at time t in SafeWheel cover s. *)
    (* Listen to hear if there's a buzzing sound. *)
    
Variable illuminates (* l s t *):L -> SW -> T -> Prop.
    (* Leds l light up at time t in SafeWheel cover s. *)
    (* Look and see if there's light being emitted. *)
    
Variable signal1 (* s t *): SW -> T -> Prop.
    (* A signal is let through in SafeWheel cover s, at time t when the bottom left button is pressed. *)
    (* Check and see if the signal is activated with a multimeter. *)
    
Variable signal2 (* s t *):  SW -> T -> Prop.
    (* A signal is let through in SafeWheel cover s, at time t when the bottom right button is pressed. *)
    (* Check and see if the signal is activated with a multimeter. *)
    
Variable signal3 (* s t *):  SW -> T -> Prop.
    (* A signal is let through in SafeWheel cover s, at time t when the top left button is pressed. *)
    (* Check and see if the signal is activated with a multimeter. *)
    
Variable signal4 (* s t *): SW -> T -> Prop.
    (* A signal is let through in SafeWheel cover s, at time t when the top right button is pressed. *)
    (* Check and see if the signal is activated with a multimeter. *)    

Variable buzzerIsPowered (* bu s t *):Bu -> SW -> T -> Prop.
    (* Buzzer bu, in SafeWheel cover s, at time t is being powered. *)
    (* Check to see if the buzzer is powered with a multimeter. *)
    
Variable timerIsPowered (* ti s t *): Ti -> SW -> T -> Prop.
    (* Timer ti, in SafeWheel cover s, at time t is being powered. *)
    (* Check to see if the timer is powered with a multimeter. *)
    
Variable ledIsPowered (* l s t*):L -> SW ->T -> Prop.
    (*  LED light l , in SafeWheel cover s, at time t is being powered. *)
    (*  Check to see if the LEDs are powered with a multimeter. *)
    
Variable switchIsPowered  (* swi s t *): Swi -> SW -> T -> Prop.
    (* Swtich swi, in SafeWheel cover s, at time t is being powered. *)
    (* Check with a multimeter if it is recieving power. *)
    
Variable switchSignal (* swi s t *): Swi -> SW -> T -> Prop.
    (* A signal is let through in SafeWheel cover s, at time t from switch swi. *)
    (* Check to see if the switch outputs power with a multimeter. *)
    
Variable timerSignal (* ti s t *): Ti -> SW -> T -> Prop.
    (* A signal is let though in SafeWheel cover s, at time t from timer ti. *)
    (* Use a multimeter to check if timer outputs a signal. *)
    
Variable isButtonTopLeft (* b *): Bu -> Prop.
    (* This is the top left button b. *)
    (* Look to see where it is positioned at. *)
    
Variable isButtonTopRight (* b *): Bu -> Prop.
    (* This is the top right button b. *)
    (* Look to see where it is positioned at. *)
    
Variable isButtonBottomLeft (* b *): Bu -> Prop.
    (* This is the bottom left button b. *)
    (* Look to see where it is positioned at. *)
    
Variable isButtonBottomRight (* b *): Bu -> Prop.
    (* This is the bottom right button b. *)
    (* Look to see where it is positioned at. *)    
(* ====================================================================== *)

(* Auxiliary predicates (including their meaning) *)

Definition buttonBotLeft (* t *) (t:T) :=
    forall s:SW,
            (
                forall b:B,
                    ~buttonIsPressedBotLeft b s t
            )        
        ->
            ~signal1 s t
. 
(* When the bottom left button b isn't pressed at time t, in SafeWheel cover s, 
   there is no signal1 going through, at the same time, in the same cover. *)


Definition buttonBotRight (* t *) (t:T) :=
    forall s:SW,
            (
                forall b:B,
                    ~buttonIsPressedBotRight b s t
            )        
        ->
            ~signal2 s t
. 
(* When the bottom right button b isn't pressed at time t, in SafeWheel cover s, 
   there is no signal2 going through, at the same time, in the same cover. *)


Definition buttonTopLeft (* t *) (t:T) :=
    forall s:SW,
            (
                forall b:B,
                    ~buttonIsPressedTopLeft b s t
            )        
        ->
            ~signal3 s t
. 
(* When the top left button b isn't pressed at time t, in SafeWheel cover s, 
   there is no signal3 going through, at the same time, in the same cover. *)


Definition buttonTopRight (* t *) (t:T)  :=
    forall s:SW,
            (
                forall b:B,
                    ~buttonIsPressedTopRight b s t
            )        
        ->
            ~signal4 s t
.  
(* When the top right button b isn't pressed at time t, in SafeWheel cover s, 
   there is no signal4 going through, at the same time, in the same cover. *)
(* See if the button isn't pressed and measure the signal to check for voltage with a multimeter. *)

Definition notHandsOnWheel (* t *) (t:T) :=
    forall s:SW,
                (
                    forall b : B, 
                        ~ buttonIsPressedTopLeft b s t
                )
            /\
                (
                    forall b : B, 
                        ~ buttonIsPressedBotLeft b s t
                )
            /\
                (
                    forall b : B, 
                        ~ buttonIsPressedBotRight b s t
                )
            /\
                (
                    forall b : B, 
                        ~ buttonIsPressedTopRight b s t
                )
            /\
                buttonBotLeft t 
            /\
                buttonBotRight t 
            /\
                buttonTopLeft t 
            /\
                buttonTopRight t 
                    
        ->
                ~(
                        (       signal1 s t
                            \/
                                signal2 s t
                        )
                    /\    
                        (       signal3 s t
                            \/
                                signal4 s t
                        )
                )
.
(* If the top right button b isn't being pressed at time t in SafeWheel cover s and the bottom left button b isn't
   being pressed at the same time in the same cover and the bottom right button b isn't being pressed at the same time in the same cover
   and the top right button isn't being pressed at the same time in the same cover and buttonBotLeft holds at the same time and buttonBotRight
   holds at the same time and buttonTopLeft holds at the same time and buttonTopRight holds at the same time, then it shouldn't hold that 
   signal1 or signal2 hold at the same time in the same cover, and signal 3 or signal4 hold at the same time in the same cover. *)


(* ====================================================================== *)

(* Components *)

   
Definition battery :=
    forall t:T,
        forall s:SW,
                batteryPowered s t
            ->
                    (forall bu:Bu,
                        buzzerIsPowered bu s t)
                /\
                    (forall ti:Ti,
                        timerIsPowered ti s t)
                /\
                    (forall l:L,
                        ledIsPowered l s t)
                /\
                    (forall swi:Swi,
                        switchIsPowered swi s t)
.
(* If at time t, in SafeWheel cover s battery is powered, then buzzer bu, timer ti, leds l 
   and switch swi are powered at the same time, in the same SafeWheel cover. *)

        
Definition switch :=
    forall t:T,
        forall s:SW,
            forall swi:Swi,
                        switchIsPowered swi s t
                    /\
                        switchOn swi s t
                ->
                    switchSignal swi s t
.
(* If switch swi is powered and is on at time t, in SafeWheel cover s then switch swi sends a signal
   at the same time, in the same SafeWheel cover. *)


Definition buzzer := 
    forall t:T,
        forall s:SW,
            forall bu:Bu,
                            buzzerIsPowered bu s t
                        /\
                            (forall swi:Swi,
                                switchSignal swi s t)
                        /\
                            (forall ti:Ti,
                                timerSignal ti s t)
                    ->
                        buzzes bu s t
. 
(* If buzzer bu is powered, switch swi is giving a signal and timer ti is giving a signal at time t,
   in SafeWheel cover s, then buzzer bu buzzes at the same time, in the same SafeWheel cover. *)


Definition leds :=
    forall t:T,
        forall s:SW,
            forall l:L,
                        ledIsPowered l s t
                    /\
                        (forall swi:Swi,
                            switchSignal swi s t)
                    /\
                        (forall ti:Ti,
                            timerSignal ti s t)
                ->
                    illuminates l s t
.
(* If leds l are powered, switch swi is giving a signal and timer ti is giving a signal at time t,
   in SafeWheel cover s,
    then leds l illuminates at the same time, in the same SafeWheel cover. *)


Definition timer :=
    forall t:T,
        forall s:SW,
            forall ti:Ti,
                            timerIsPowered ti s t
                        /\
                            (forall swi:Swi,
                                switchSignal swi s t)
                        /\
                            (
                                forall t1:T,
                                        t1 in [t,t+3)
                                    ->
                                        (notHandsOnWheel t1)
                            )
                    ->
                        timerSignal ti s (t+3)
.
(* If timer ti is powered, switch swi is giving a signal at time t, in SafeWheel cover s,
   and in the next 3 seconds after t there aren't hands on wheel then timer ti will send
   a signal 3 seconds after t. *)



(* ====================================================================== *)

(* Specification of the overall system *)
Definition safeWheels :=
(* If between time t and t+3 the battery is powered and switch swi is on in SafeWheel cover s, and
    the buttons b1, b2, b3, b4 are being pressed on the top half or the bottom half at time t in SafeWheel
    cover s and one of the buttons on the used side (top or bottom) isn't being pressed, then
    the same cover buzzes and illuminates 3 seconds after that time. *)
    forall s:SW,
        forall t:T,
                    (
                        forall tx:T,
                                tx in [t, t+3]
                            ->    
                                    batteryPowered s tx
                                /\
                                    (
                                        forall swi:Swi,
                                            switchOn swi s tx
                                    )
                    )
                /\
                    ~(
                                (
                                    forall b1:B,
                                        buttonIsPressedBotLeft b1 s t
                                )
                            /\
                                (
                                    forall b2:B,
                                        buttonIsPressedBotRight b2 s t
                                )
                        \/
                                (
                                    forall b3:B,
                                        buttonIsPressedTopLeft b3 s t
                                )
                            /\
                                (
                                    forall b4:B,
                                        buttonIsPressedTopRight b4 s t
                                )
                    )                    
                            
            ->
                    (   
                        forall bu:Bu,
                            buzzes bu s (t+3)
                    )        
                /\
                    (
                        forall l:L,
                            illuminates l s (t+3)
                    )        
.

(*
   We used an implication instead of an equivalence, because someone can spill liquids
   on the SafeWheel and then it has a chance to not work as expected.
*)

(* ====================================================================== *)


(* Correctness theorem *)

Theorem CorTheorem:
            battery
        /\
            switch
        /\
            leds
        /\
            buzzer
        /\
            timer
    ->
        safeWheels
.

Proof.
(* BEGINNING *)
(* This is where we split all the assumptions up and added them to the assumptions list. *)
splitAss.
unfold battery.
unfold switch.
unfold leds.
unfold buzzer.
unfold timer.
unfold safeWheels.
imp_i battery1.
imp_i switch1.
imp_i leds1.
imp_i buzzer1.
imp_i timer1.
all_i x.
all_i y.
imp_i sw.
con_i.
all_i bz.

(* Here we proved buzzes by using the buzzer1 assumption. *)

imp_e (buzzerIsPowered bz x (y+3) /\ 
            (forall swi : Swi, switchSignal swi x (y+3)) /\
            (forall ti : Ti, timerSignal ti x (y+3))).
all_e (forall bu : Bu,
            buzzerIsPowered bu x (y+3) /\
            (forall swi : Swi, switchSignal swi x (y+3)) /\
            (forall ti : Ti, timerSignal ti x (y+3)) -> 
            buzzes bu x (y+3)) bz.
all_e (forall s:SW, forall bu : Bu,
   buzzerIsPowered bu s (y + 3) /\
   (forall swi : Swi, switchSignal swi s (y + 3)) /\
   (forall ti : Ti, timerSignal ti s (y + 3)) -> buzzes bu s (y + 3)) x.
all_e (forall t:T, forall s:SW, forall bu : Bu, buzzerIsPowered bu s t /\
            (forall swi : Swi, switchSignal swi s t) /\
            (forall ti : Ti, timerSignal ti s t) -> 
            buzzes bu s t) (y+3).
hyp buzzer1.

(* Here we proved that the buzzer is powered by using the battery assumption. *)

con_i.
all_e (forall bu:Bu, buzzerIsPowered bu x (y + 3)) bz.
con_e1 ((forall ti : Ti, timerIsPowered ti x (y + 3)) /\
             (forall l : L, ledIsPowered l x (y + 3)) /\
             (forall swi : Swi, switchIsPowered swi x (y + 3))).
imp_e (batteryPowered x (y+3)).
all_e (forall s:SW, batteryPowered s (y+3) ->
             (forall bu : Bu, buzzerIsPowered bu s (y+3)) /\
             (forall ti : Ti, timerIsPowered ti s (y+3)) /\
             (forall l : L, ledIsPowered l s (y+3)) /\
             (forall swi : Swi, switchIsPowered swi s (y+3))) x.
all_e (forall t:T,  forall s:SW,  batteryPowered s t ->
             (forall bu : Bu, buzzerIsPowered bu s t) /\
             (forall ti : Ti, timerIsPowered ti s t) /\
             (forall l : L, ledIsPowered l s t) /\
             (forall swi : Swi, switchIsPowered swi s t)) (y+3).         
hyp battery1.

(* Here we proved that the battery is powered by using the sw assumption. *)

con_e1 (forall swi : Swi, switchOn swi x (y+3)).
imp_e ( (y+3) in  [y, y + 3]).
all_e (forall tx : T, tx in  [y, y + 3] ->
   batteryPowered x tx /\ (forall swi : Swi, switchOn swi x tx)) (y+3).
con_e1 ( ~
       ((forall b1 : B, buttonIsPressedBotLeft b1 x y) /\
        (forall b2 : B, buttonIsPressedBotRight b2 x y) \/
        (forall b3 : B, buttonIsPressedTopLeft b3 x y) /\
        (forall b4 : B, buttonIsPressedTopRight b4 x y))).
hyp sw.

(* Here we proved that our project works linearly in time by solving the interval. *)

interval.
con_i.
lin_solve.
lin_solve.

(* Here we proved that there is a switch signal by using the assumption switch1. *)

con_i.
all_i swz.
imp_e (switchIsPowered swz x (y+3) /\ switchOn swz x (y+3)).
all_e (forall swi:Swi,  switchIsPowered swi x (y + 3) /\ switchOn swi x (y + 3) ->
   switchSignal swi x (y + 3)) swz.
all_e (forall s:SW, forall swi:Swi,  switchIsPowered swi s (y + 3) /\ switchOn swi s (y + 3) ->
   switchSignal swi s (y + 3)) x.
all_e (forall t:T,  forall s:SW, forall swi:Swi,  switchIsPowered swi s t /\ switchOn swi s t ->
   switchSignal swi s t)  (y+3).
hyp switch1.

(* Here we proved that the switch is powered by using the battery1 assumption. *)

con_i.
all_e (forall swi:Swi, switchIsPowered swi x (y + 3)) swz.
con_e2 ( forall l : L, ledIsPowered l x (y+3) ).
con_e2 (  forall ti : Ti, timerIsPowered ti x (y+3)). 
con_e2 ( forall bu : Bu, buzzerIsPowered bu x (y+3)  ).

imp_e (batteryPowered x (y+3)).
all_e (forall s:SW,batteryPowered s (y + 3) ->
    (forall bu : Bu, buzzerIsPowered bu s (y + 3)) /\
    (forall ti : Ti, timerIsPowered ti s (y + 3)) /\
    (forall l : L, ledIsPowered l s (y + 3)) /\
   (forall swi : Swi, switchIsPowered swi s (y + 3)) ) x.
all_e (forall t:T, forall s:SW,batteryPowered s t ->
    (forall bu : Bu, buzzerIsPowered bu s t) /\
    (forall ti : Ti, timerIsPowered ti s t) /\
    (forall l : L, ledIsPowered l s t) /\
   (forall swi : Swi, switchIsPowered swi s t) )  (y+3).
hyp battery1.

(* Here once again we proved that the battery is indeed powered by using the sw assumption. *)

con_e1 (forall swi : Swi, switchOn swi x (y+3)).
imp_e ( (y+3) in  [y, y + 3]).
all_e (forall tx : T, tx in  [y, y + 3] ->
   batteryPowered x tx /\ (forall swi : Swi, switchOn swi x tx)) (y+3).
con_e1 ( ~
       ((forall b1 : B, buttonIsPressedBotLeft b1 x y) /\
        (forall b2 : B, buttonIsPressedBotRight b2 x y) \/
        (forall b3 : B, buttonIsPressedTopLeft b3 x y) /\
        (forall b4 : B, buttonIsPressedTopRight b4 x y))).
hyp sw.

(* Here we proved once again that our project works linearly in time by solving the interval. *)

interval.
con_i.
lin_solve.
lin_solve.

(* Here we proved that the switch is turned on using the sw assumption. *)

all_e (forall swi:Swi, switchOn swi x (y + 3)) swz.
con_e2 (batteryPowered x (y+3)).
imp_e    ( (y+3) in  [y, y + 3]).
all_e (forall tx:T, tx in  [y, y + 3] ->
    batteryPowered x tx /\ (forall swi : Swi, switchOn swi x tx) ) (y+3).
con_e1 (~
       ((forall b1 : B, buttonIsPressedBotLeft b1 x y) /\
        (forall b2 : B, buttonIsPressedBotRight b2 x y) \/
        (forall b3 : B, buttonIsPressedTopLeft b3 x y) /\
        (forall b4 : B, buttonIsPressedTopRight b4 x y))).
hyp sw.  

(* Here we proved once again that our project works linearly in time by solving the interval. *)

interval.
con_i.
lin_solve.
lin_solve.

(* Here we proved that there is a switch signal by using the timer1 assumption. *)

all_i ti2.
imp_e (timerIsPowered ti2 x y /\
           (forall swi : Swi, switchSignal swi x y) /\
           (forall t1 : T, t1 in  [y, y + 3) ->  notHandsOnWheel t1)) .
all_e (forall ti:Ti, timerIsPowered ti x y /\
   (forall swi : Swi, switchSignal swi x y) /\
   (forall t1 : T, t1 in  [y, y + 3) ->  notHandsOnWheel t1) ->
   timerSignal ti x (y + 3)) ti2.
all_e (forall s:SW,    forall ti : Ti,
   timerIsPowered ti s y /\
   (forall swi : Swi, switchSignal swi s y) /\
   (forall t1 : T, t1 in  [y, y + 3) -> notHandsOnWheel t1) ->
   timerSignal ti s (y + 3)) x.
all_e (forall t:T,  forall (s : SW) (ti : Ti),
   timerIsPowered ti s t /\
   (forall swi : Swi, switchSignal swi s t) /\
   (forall t1 : T, t1 in  [t, t + 3) ->  notHandsOnWheel t1) ->
   timerSignal ti s (t + 3)) y.
hyp timer1.

(* Here we proved that the timer is powered using the battery1 assumption. *)

con_i.
all_e (forall ti : Ti, timerIsPowered ti x y) ti2.
con_e1 ((forall l : L, ledIsPowered l x y) /\
             (forall swi : Swi, switchIsPowered swi x y)).
con_e2 (forall bu : Bu, buzzerIsPowered bu x y).
imp_e (batteryPowered x y).
all_e (forall s : SW,
             batteryPowered s y ->
             (forall bu : Bu, buzzerIsPowered bu s y) /\
             (forall ti : Ti, timerIsPowered ti s y) /\
             (forall l : L, ledIsPowered l s y) /\
             (forall swi : Swi, switchIsPowered swi s y)) x.
all_e (forall t : T, forall s : SW,
             batteryPowered s t ->
             (forall bu : Bu, buzzerIsPowered bu s t) /\
             (forall ti : Ti, timerIsPowered ti s t) /\
             (forall l : L, ledIsPowered l s t) /\
             (forall swi : Swi, switchIsPowered swi s t)) y.
hyp battery1.

(* Here once again we proved that the battery is indeed powered by using the sw assumption. *)

con_e1 (forall swi : Swi, switchOn swi x y).
imp_e ( y in  [y, y + 3]).
all_e (forall tx : T, tx in  [y, y + 3] ->
   batteryPowered x tx /\ (forall swi : Swi, switchOn swi x tx)) y.
con_e1 ( ~
       ((forall b1 : B, buttonIsPressedBotLeft b1 x y) /\
        (forall b2 : B, buttonIsPressedBotRight b2 x y) \/
        (forall b3 : B, buttonIsPressedTopLeft b3 x y) /\
        (forall b4 : B, buttonIsPressedTopRight b4 x y))).
hyp sw.

(* Here we proved once again that our project works linearly in time by solving the interval. *)

interval.
con_i.
lin_solve.
lin_solve.

(* Here we proved that there is a switch signal by using the switch1 assumption. *)

con_i.
all_i sw1.
imp_e (switchIsPowered sw1 x y /\ switchOn sw1 x y).
all_e (forall swi : Swi,
            switchIsPowered swi x y /\ switchOn swi x y ->
            switchSignal swi x y) sw1.
all_e (forall s : SW, forall swi : Swi,
            switchIsPowered swi s y /\ switchOn swi s y ->
            switchSignal swi s y) x.
all_e (forall t:T, forall s : SW, forall swi : Swi,
            switchIsPowered swi s t /\ switchOn swi s t ->
            switchSignal swi s t) y.
hyp switch1.

(* Here we proved that the switch is powered using the battery1 assumption. *)

con_i.
all_e (forall swi : Swi, switchIsPowered swi x y) sw1.
con_e2 (forall l : L, ledIsPowered l x y).
con_e2 (forall ti : Ti, timerIsPowered ti x y).
con_e2 (forall bu : Bu, buzzerIsPowered bu x y).
imp_e (batteryPowered x y).
all_e (forall s : SW,
             batteryPowered s y ->
             (forall bu : Bu, buzzerIsPowered bu s y) /\
             (forall ti : Ti, timerIsPowered ti s y) /\
             (forall l : L, ledIsPowered l s y) /\
             (forall swi : Swi, switchIsPowered swi s y)) x.
all_e (forall t : T, forall s : SW,
             batteryPowered s t ->
             (forall bu : Bu, buzzerIsPowered bu s t) /\
             (forall ti : Ti, timerIsPowered ti s t) /\
             (forall l : L, ledIsPowered l s t) /\
             (forall swi : Swi, switchIsPowered swi s t)) y.
hyp battery1.

(* Here once again we proved that the battery is indeed powered by using the sw assumption. *)

con_e1 (forall swi : Swi, switchOn swi x y).
imp_e ( y in  [y, y + 3]).
all_e (forall tx : T, tx in  [y, y + 3] ->
   batteryPowered x tx /\ (forall swi : Swi, switchOn swi x tx)) y.
con_e1 ( ~
       ((forall b1 : B, buttonIsPressedBotLeft b1 x y) /\
        (forall b2 : B, buttonIsPressedBotRight b2 x y) \/
        (forall b3 : B, buttonIsPressedTopLeft b3 x y) /\
        (forall b4 : B, buttonIsPressedTopRight b4 x y))).
hyp sw.

(* Here we proved once again that our project works linearly in time by solving the interval. *)

interval.
con_i.
lin_solve.
lin_solve.

(* Here we proved that the switch is on, again. *)
all_e ((forall swi : Swi, switchOn swi x y)) sw1.
con_e2 (batteryPowered x y).
imp_e (y in  [y, y + 3]).
all_e (forall tx : T,
        tx in  [y, y + 3] ->
        batteryPowered x tx /\ forall swi : Swi, switchOn swi x tx) y.
con_e1 (~
       ((forall b1 : B, buttonIsPressedBotLeft b1 x y) /\
        (forall b2 : B, buttonIsPressedBotRight b2 x y) \/
        (forall b3 : B, buttonIsPressedTopLeft b3 x y) /\
        (forall b4 : B, buttonIsPressedTopRight b4 x y))).
hyp sw.

(* And the linear part again. *)

interval.
con_i.
lin_solve.
lin_solve.

(* Here we proved notHandsOnWheel using unfolds and negations. *)

