(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 4/15/23
* 
* Description of Module: 
* Provides a user interface for intaking what rotational physics variables are given and being asked to solve for,
* after which it recommends the best formula to solve for the asked variable
*
* Key for variables:
* theta            - angular position
* s                - arc length
* r                - radius
* r_vector         - radius vector
* deltaTheta       - change in angular position
* theta_f          - final angular position
* theta_i          - initial angular position
* T                - time
* deltaTime        - change in time
* v                - velocity
* v_vector         - velocity vector
* w                - angular velocity
* deltaW           - change in angular velocity
* w_f              - final angular velocity
* w_i              - initial angular velocity
* averageW         - average angular velocity
* functionW        - angular velocity as a function of time
* functionTheta    - angular position as a function of time
* a                - acceleration
* alpha            - angular acceleration
* averageAlpha     - average angular acceleration
* functionAlpha    - angular acceleration as a function of time
* period           - period of circular motion
* K                - rotational kinetic energy
* I                - moment of inertia
* I_com            - moment of inertia at center of mass (used mainly for parallel axis theorem)
* m                - mass
* h                - distance between parallel rotation axes (used mainly for parallel axis theorem)
* torque_vector    - torque vector
* F_vector         - force vector
* r_vector         - radius/distance vector
* torque_magnitude - magnitude of torque
* torque_net       - net torque
* functionTorque   - torque as a function of time
* F                - force
* L                - angular momentum
* L_vector         - angular momentum vector
* L_magnitude      - mangitude of angular momentum
* functionL        - angular momentum as a function of time
*/

/*
* Defines a template for each variable within the rotational physics formulas
* @slot name                  the name of the variable
* @slot value                 the value indicating whether this variable exists within a given formula,
*                             with 'G' indicating that it is given and 'S' indicating that it needs to 
*                             be solved for, otherwise 'N' if it does not apply
*/
(deftemplate variable (slot name) (slot value))

(do-backward-chaining variable)     ; enable backward chaining using the variable template

/*****
* Rules either starting or ending the animal game based on certain conditions
* such as exceeding the question limit or running out of questions to ask
*/
(defrule startProgram "Begins the expert system"
   (declare (salience 100))
=>
   (printline)
   (printline "Welcome to the 20 questions animal game! ")
   (printline "Please think of an animal and respond honestly to the following questions with anything starting with either 'yes' ('y'), 'no' ('n'), or 'unknown' ('u')!")
   (printline "Feel free to use Google or other resources to learn more about your own animal in the process.")
   (printline "Ready? Let's begin! ")
   (printline)
)  

(defrule giveUp "Ends the game and notifies the user that we were unable to suggest a formula based on the given variables"
   (declare (salience -100))
=>
   (haltGame)
   (printline "I'm not sure which formula to use... It seems like your problem might be too complex for our purposes!")
   (printline "Sorry about that, and we wish you the best of luck in solving your problem!")
)  

(defrule angularPosition
   (or (and (variable (name theta) (value ?theta & S)) (variable (name s) (value ?s & G)) (variable (name r) (value ?r & G)))
       (and (variable (name theta) (value ?theta & G)) (variable (name s) (value ?s & S)) (variable (name r) (value ?r & G))) 
       (and (variable (name theta) (value ?theta & G)) (variable (name s) (value ?s & G)) (variable (name r) (value ?r & S))))
=>
   (printline "Conclusion: Use theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularDisplacement
   (or (and (variable (name deltaTheta) (value ?deltaTheta & S)) (variable (name theta_f) (value ?theta_f & G)) 
            (variable (name theta_i) (value ?theta_i & G)))
       (and (variable (name deltaTheta) (value ?deltaTheta & G)) (variable (name theta_f) (value ?theta_f & S)) 
            (variable (name theta_i) (value ?theta_i & G)))
       (and (variable (name deltaTheta) (value ?deltaTheta & G)) (variable (name theta_f) (value ?theta_f & G)) 
            (variable (name theta_i) (value ?theta_i & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule changeInAngularVelocity
   (or (and (variable (name deltaW) (value ?deltaW & S)) (variable (name w_f) (value ?w_f & G)) 
            (variable (name w_i) (value ?w_i & G)))
       (and (variable (name deltaW) (value ?deltaW & G)) (variable (name w_f) (value ?w_f & S))
            (variable (name w_i) (value ?w_i & G)))
       (and (variable (name deltaW) (value ?deltaW & G)) (variable (name w_f) (value ?w_f & G)) 
            (variable (name w_i) (value ?w_i & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularVelocity
   (or (and (variable (name averageW) (value ?averageW & S)) (variable (name deltaTheta) (value ?deltaTheta & G)) 
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageW) (value ?averageW & G)) (variable (name deltaTheta) (value ?deltaTheta & S)) 
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageW) (value ?averageW & G)) (variable (name deltaTheta) (value ?deltaTheta & G)) 
            (variable (name deltaTime) (value ?deltaTime & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule functionAngularVelocity
   (or (and (variable (name functionW) (value ?functionW & S)) (variable (name functionTheta) (value ?functionTheta & G)))
       (and (variable (name functionW) (value ?functionW & G)) (variable (name functionTheta) (value ?functionTheta & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularAcceleration
   (or (and (variable (name averageAlpha) (value ?averageAlpha & S)) (variable (name deltaW) (value ?deltaW & G))
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageAlpha) (value ?averageAlpha & G)) (variable (name deltaW) (value ?deltaW & S)) 
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageAlpha) (value ?averageAlpha & G)) (variable (name deltaW) (value ?deltaW & G)) 
            (variable (name deltaTime) (value ?deltaTime & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule functionAngularAccelerationWithAngularVelocity
   (or (and (variable (name functionAlpha) (value ?functionAlpha & S)) (variable (name functionW) (value ?functionW & G)))
       (and (variable (name functionAlpha) (value ?functionAlpha & G)) (variable (name functionW) (value ?functionW & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule functionAngularAccelerationWithAngularPosition
   (or (and (variable (name functionAlpha) (value ?functionAlpha & S)) (variable (name functionTheta) (value ?functionTheta & G)))
       (and (variable (name functionAlpha) (value ?functionAlpha & G)) (variable (name functionTheta) (value ?functionTheta & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearVelocity
   (or (and (variable (name v) (value ?v & S)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & G)))
       (and (variable (name v) (value ?v & G)) (variable (name w) (value ?w & S)) (variable (name r) (value ?r & G)))
       (and (variable (name v) (value ?v & G)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearAcceleration
   (or (and (variable (name a) (value ?a & S)) (variable (name alpha) (value ?alpha & G)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name alpha) (value ?alpha & S)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name alpha) (value ?alpha & G)) (variable (name r) (value ?r & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule radialAccelerationWithAngularVelocity
   (or (and (variable (name a) (value ?a & S)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name w) (value ?w & S)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule radialAccelerationWithLinearVelocity
   (or (and (variable (name a) (value ?a & S)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name v) (value ?v & S)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule periodWithLinearVelocity
   (or (and (variable (name period) (value ?period & S)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & G)))
       (and (variable (name period) (value ?period & G)) (variable (name v) (value ?v & S)) (variable (name r) (value ?r & G)))
       (and (variable (name period) (value ?period & G)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & S))))
=>

)

(defrule periodWithAngularVelocity
   (or (and (variable (name period) (value ?period & S)) (variable (name w) (value ?w & G)))
       (and (variable (name period) (value ?period & G)) (variable (name w) (value ?w & S))))
=>

)

(defrule rotationalKineticEnergy
   (or (and (variable (name K) (value ?K & S)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & G)))
       (and (variable (name K) (value ?K & G)) (variable (name I) (value ?I & S)) (variable (name w) (value ?w & G)))
       (and (variable (name K) (value ?K & G)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule parallelAxisTheorem
   (or (and (variable (name I) (value ?I & S)) (variable (name I_com) (value ?I_com & G)) 
            (variable (name m) (value ?m & G)) (variable (name h) (value ?h & G)))
       (and (variable (name I) (value ?I & G)) (variable (name I_com) (value ?I_com & S)) 
            (variable (name m) (value ?m & G)) (variable (name h) (value ?h & G)))
       (and (variable (name I) (value ?I & G)) (variable (name I_com) (value ?I_com & G)) 
            (variable (name m) (value ?m & S)) (variable (name h) (value ?h & G)))
       (and (variable (name I) (value ?I & G)) (variable (name I_com) (value ?I_com & G)) 
            (variable (name m) (value ?m & G)) (variable (name h) (value ?h & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueVector
   (or (and (variable (name torque_vector) (value ?torque_vector & S)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name F_vector) (value ?F_vector & G)))
       (and (variable (name torque_vector) (value ?torque_vector & G)) (variable (name r_vector) (value ?r_vector & S)) 
            (variable (name F_vector) (value ?F_vector & G)))
       (and (variable (name torque_vector) (value ?torque_vector & G)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name F_vector) (value ?F_vector & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueMagnitude
   (or (and (variable (name torque_magnitude) (value ?torque_magnitude & S)) (variable (name r) (value ?r & G)) 
            (variable (name F) (value ?F & G)) (variable (name theta) (value ?theta & G)))
       (and (variable (name torque_magnitude) (value ?torque_magnitude & G)) (variable (name r) (value ?r & S)) 
            (variable (name F) (value ?F & G)) (variable (name theta) (value ?theta & G)))
       (and (variable (name torque_magnitude) (value ?torque_magnitude & G)) (variable (name r) (value ?r & G)) 
            (variable (name F) (value ?F & S)) (variable (name theta) (value ?theta & G)))
       (and (variable (name torque_magnitude) (value ?torque_magnitude & G)) (variable (name r) (value ?r & G)) 
            (variable (name F) (value ?F & G)) (variable (name theta) (value ?theta & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule netTorque
   (or (and (variable (name torque_net) (value ?torque_net & S)) (variable (name I) (value ?I & G)) 
            (variable (name alpha) (value ?alpha & G)))
       (and (variable (name torque_net) (value ?torque_net & G)) (variable (name I) (value ?I & S)) 
            (variable (name alpha) (value ?alpha & G)))
       (and (variable (name torque_net) (value ?torque_net & G)) (variable (name I) (value ?I & G)) 
            (variable (name alpha) (value ?alpha & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentumVector
   (or (and (variable (name L_vector) (value ?L_vector & S)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name v_vector) (value ?v_vector & G)) (variable (name m) (value ?m & G)))
       (and (variable (name L_vector) (value ?L_vector & G)) (variable (name r_vector) (value ?r_vector & S)) 
            (variable (name v_vector) (value ?v_vector & G)) (variable (name m) (value ?m & G)))
       (and (variable (name L_vector) (value ?L_vector & G)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name v_vector) (value ?v_vector & S)) (variable (name m) (value ?m & G)))
       (and (variable (name L_vector) (value ?L_vector & G)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name v_vector) (value ?v_vector & G)) (variable (name m) (value ?m & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentumMagnitude
   (or (and (variable (name L_magnitude) (value ?L_magnitude & S)) (variable (name r) (value ?r & G)) 
            (variable (name m) (value ?m & G)) (variable (name v) (value ?v & G))) 
            (variable (name theta) (value ?theta & G))

       (and (variable (name L_magnitude) (value ?L_magnitude & G)) (variable (name r) (value ?r & S)) 
            (variable (name m) (value ?m & G)) (variable (name v) (value ?v & G))) 
            (variable (name theta) (value ?theta & G))

       (and (variable (name L_magnitude) (value ?L_magnitude & G)) (variable (name r) (value ?r & G)) 
            (variable (name m) (value ?m & S)) (variable (name v) (value ?v & G))) 
            (variable (name theta) (value ?theta & G))

       (and (variable (name L_magnitude) (value ?L_magnitude & G)) (variable (name r) (value ?r & G)) 
            (variable (name m) (value ?m & G)) (variable (name v) (value ?v & S))) 
            (variable (name theta) (value ?theta & G))

       (and (variable (name L_magnitude) (value ?L_magnitude & G)) (variable (name r) (value ?r & G)) 
            (variable (name m) (value ?m & G)) (variable (name v) (value ?v & G))) 
            (variable (name theta) (value ?theta & S)))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentum_T
   (or (and (variable (name L) (value ?L & S)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & G)))
       (and (variable (name L) (value ?L & G)) (variable (name I) (value ?I & S)) (variable (name w) (value ?w & G)))
       (and (variable (name L) (value ?L & G)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantNetTorque_functionTorque
   (or (and (variable (name functionTorque) (value ?functionTorque & S)) (variable (name functionL) (value ?functionL & G)))
       (and (variable (name functionTorque) (value ?functionTorque & G)) (variable (name functionL) (value ?functionL & S))))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

/*
* 
*/
(deffunction validVariables ()
   (bind ?variables "theta s r r_vector deltaTheta theta_f theta_i T deltaTime v v_vector w deltaW w_f w_i averageW functionW ")
   (bind ?variables (+ ?variables "functionTheta a alpha averageAlpha functionAlpha period K I I_com m h torque_vector functionL "))
   (bind ?variables (+ ?variables "F_vector r_vector torque_magnitude torque_net functionTorque F L L_vector L_magnitude"))

   (return (explode$ ?variables))
)

/*
* Prints out the entire list of variables used within this program
* as well as what concepts/quantities they refer to
*/
(deffunction printVariableKey ()
   (printline "-----------Key for Variables-----------")
   (printline "theta            - angular position")
   (printline "s                - arc length")
   (printline "r                - radius")
   (printline "r_vector         - radius vector")
   (printline "deltaTheta       - change in angular position")
   (printline "theta_f          - final angular position")
   (printline "theta_i          - initial angular position")
   (printline "T                - time")
   (printline "deltaTime        - change in time")
   (printline "v                - velocity")
   (printline "v_vector         - velocity vector")
   (printline "w                - angular velocity")
   (printline "deltaW           - change in angular velocity")
   (printline "w_f              - final angular velocity")
   (printline "w_i              - initial angular velocity")
   (printline "averageW         - average angular velocity")
   (printline "functionW        - angular velocity as a function of time")
   (printline "functionTheta    - angular position as a function of time")
   (printline "a                - acceleration")
   (printline "alpha            - angular acceleration")
   (printline "averageAlpha     - average angular acceleration")
   (printline "functionAlpha    - angular acceleration as a function of time")
   (printline "period           - period of circular motion")
   (printline "K                - rotational kinetic energy")
   (printline "I                - moment of inertia")
   (printline "I_com            - moment of inertia at center of mass (used mainly for parallel axis theorem)")
   (printline "m                - mass")
   (printline "h                - distance between parallel rotation axes (used mainly for parallel axis theorem)")
   (printline "torque_vector    - torque vector")
   (printline "F_vector         - force vector")
   (printline "r_vector         - radius/distance vector")
   (printline "torque_magnitude - magnitude of torque")
   (printline "torque_net       - net torque")
   (printline "functionTorque   - torque as a function of time")
   (printline "F                - force")
   (printline "L                - angular momentum")
   (printline "L_vector         - angular momentum vector")
   (printline "L_magnitude      - mangitude of angular momentum")
   (printline "functionL        - angular momentum as a function of time")
   (printline)
   (printline)

   (return)
)  ; deffunction printVariableKey ()

/*
* Finds what variable (from the above list) the user is trying
* to solve for
*/
(deffunction findVariableBeingSolvedFor ()
   (printVariableKey)
  
   (bind ?result "invalid")

   (while (= ?result "invalid")
      (printline)

      (bind ?question "What variable are you trying to solve for? Please enter the exact short-hand shown within the variable key (case-sensitive). ")
      (bind ?input (ask ?question))

      (bind ?validVariables (validVariables))
      (bind ?valid (member$ (+ "" ?input) ?validVariables))

      (if (integerp ?valid) then
         (bind ?result ?input) 
       else
         (printline "Valid variable not detected. Please enter a valid variable short-hand from the key.")
      ) 
   )  ; while (= ?result "invalid")

   (assert (variable (name ?result) (value S)))

   (return)
)  ; deffunction findVariableBeingSolvedFor

/*
* Asks a given question and determines whether the user's input is an affirmative, negative, or indecisive response        
* @param question             the question to ask and retrieve input from
* @return                     T if the first character of user input is a 'y', 'Y', 'u', or 'U'
*                             F if the first character of user input is an 'n' or 'N'
*/
(deffunction convertInput (?question)
   (bind ?result "invalid")

   (while (= ?result "invalid")
      (printline)

      (bind ?input (askline (sym-cat (+ ?*questions_asked* 1) ". " ?question " ")))
      (bind ?character (sub-string 1 1 ?input))

      (bind ?validInputs (validInputs))
      (bind ?valid (member$ ?character ?validInputs))

      (if (integerp ?valid) then
         (if (<= ?valid 4) then
            (bind ?result T)
          else 
            (bind ?result F)
         )   
       else
         (printline "Improper input detected. Please enter your response to the following question again ('y', 'n', or 'u').")
      )  ; if (integerp ?valid) then
   )  ; while (= ?result "invalid")

   (bind ?*questions_asked* (++ ?*questions_asked*))

   (return ?result)
)  ; deffunction convertInput (?question)

(run)