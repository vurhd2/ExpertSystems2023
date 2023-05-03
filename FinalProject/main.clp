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
* Nomenclature for variables:
* theta            - angular position
* s                - arc length
* r                - radius
* deltaTheta       - change in angular position
* theta_f          - final angular position
* theta_i          - initial angular position
* T                - time
* deltaTime        - change in time
* t_f              - final time
* t_i              - initial time
* v                - velocity
* w                - angular velocity
* deltaW           - change in angular velocity
* w_f              - final angular velocity
* w_i              - initial angular velocity
* averageW         - average angular velocity
* functionW        - angular velocity as a function of time
* functionTheta    - angular position as a function of time
* a                - acceleration
* alpha            - angular acceleration
* deltaAlpha       - change in angular acceleration
* averageAlpha     - average angular acceleration
* alpha_f          - final angular acceleration
* alpha_i          - initial angular acceleration
* functionAlpha    - angular acceleration as a function of time
* period           - period of circular motion
* K                - rotational kinetic energy
* I                - moment of inertia
* I_com            - moment of inertia at center of mass (used mainly for parallel axis theorem)
* m                - mass
* h                - distance between rotation axes (used mainly for parallel axis theorem)
* torque_vector    - torque vector
* F_vector         - force vector
* r_vector         - radius/distance vector
* torque_magnitude - magnitude of torque
* torque_net       - net torque
* p                - momentum
* p_vector         - momentum vector
* L                - angular momentum
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

(defrule angularMomentumVector_T
   (variable (name L_vector) (value S))
   (variable (name r_vector) (value G))
   (variable (name p_vector) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentumVector_T
   (variable (name L_vector) (value G))
   (variable (name r_vector) (value S))
   (variable (name p_vector) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentumVector_T
   (variable (name L_vector) (value G))
   (variable (name r_vector) (value G))
   (variable (name p_vector) (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentum_T
   (variable (name L) (value S))
   (variable (name I) (value G))
   (variable (name w) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentum_T
   (variable (name L) (value G))
   (variable (name I) (value S))
   (variable (name w) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularMomentum_T
   (variable (name L) (value G))
   (variable (name I) (value G))
   (variable (name w) (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantNetTorque_functionTorque
   (variable (name functionTorque) (value S))
   (variable (name functionL)      (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantNetTorque_functionL
   (variable (name functionTorque) (value G))
   (variable (name functionL)      (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularAcceleration_instantAlpha
   (variable (name alpha)  (value S))
   (variable (name functionAlpha) (value G))
   (variable (name T)             (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(deffunction validVariables ()
   (bind ?variables "theta s r deltaTheta theta_f theta_i deltaTime t_f t_i deltaW w_f w_i v a I I_com m h alpha p F ")
   (bind ?variables (+ ? variables "functionAlpha functionTorque functionL functionW functionTheta L_vector p_vector r_vector "))
   (bind ?variables (+ ? variables "F_vector torque_net torque_magnitude L_magnitude K averageAlpha averageW period T"))

   (return (explode$ ?variables))
)

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
