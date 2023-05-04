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
* Key for variables used throughout program:
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
* L_magnitude      - magnitude of angular momentum
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

(deftemplate target (slot name))

(do-backward-chaining variable)     ; enable backward chaining using the variable template

(defglobal ?*questions_asked* = 0)  ; the amount of questions asked so far

(defglobal ?*FORMULA_SALIENCE* = 75)
(defglobal ?*VARIABLE_SALIENCE* = 50)

/************************************
* Rules either starting or ending the expert system
*/
(defrule startProgram "Starts the expert system"
   (declare (salience 100))
=>
   (printline)
   (printline "Welcome to the rotational physics formula suggester! ")
   (printline "In a few moments, please tell me the one variable you are attempting to solve for as well as which other variables are or are not given.")
   (printline "If a simple rotational physics formula exists that expresses the variable being asked for in terms of only the given variables, I will attempt to tell you it.")
   (printline "If not, your problem might unfortunately be too vague or complex for this program... Ready? Let's begin! ")
   (printline)

   (findVariableBeingSolvedFor)
)  

(defrule giveUp "Ends the expert system and notifies the user that we were unable to suggest a formula based on the given variables"
   (declare (salience -100))
=>
   (haltProgram)
   (printline "I'm not sure which formula to use... It seems like your problem might be too complex for our purposes!")
   (printline "Sorry about that, and we wish you the best of luck in solving your problem!")
)  

/************************************
* Rules defining some of the most common/simple rotational physics formulas
* The (or) construct is used to compile all user variations of the formula together, for example, with s = theta * r,
* one variation is that 's' is being solved for while the other two are given, or maybe 'theta' is being solved for while
* the other two are given instead
* This (or) construct is why the pattern matching syntax is used within the left hand side of the rules
*/

(defrule angularPosition
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name theta) (value ?theta & S)) (variable (name s) (value ?s & G)) (variable (name r) (value ?r & G)))
       (and (variable (name theta) (value ?theta & G)) (variable (name s) (value ?s & S)) (variable (name r) (value ?r & G))) 
       (and (variable (name theta) (value ?theta & G)) (variable (name s) (value ?s & G)) (variable (name r) (value ?r & S))))
=>
   (suggestFormula "s = theta * r")
)

/*(defrule angularDisplacement "formula for angular displacement"
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name deltaTheta) (value ?deltaTheta & S)) (variable (name theta_f) (value ?theta_f & G)) 
            (variable (name theta_i) (value ?theta_i & G)))
       (and (variable (name deltaTheta) (value ?deltaTheta & G)) (variable (name theta_f) (value ?theta_f & S)) 
            (variable (name theta_i) (value ?theta_i & G)))
       (and (variable (name deltaTheta) (value ?deltaTheta & G)) (variable (name theta_f) (value ?theta_f & G)) 
            (variable (name theta_i) (value ?theta_i & S))))
=>
   (suggestFormula "deltaTheta = theta_f - theta_i")
)*/

(defrule angularDisplacement "formula for angular displacement"
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name deltaTheta))
      (target (name theta_f))
      (target (name theta_i))
   )
   (variable (name deltaTheta) (value ?deltaTheta))
   (variable (name theta_f) (value ?theta_f)) 
   (variable (name theta_i) (value ?theta_i))
=>
   (if (or 
         (and (eq ?deltaTheta S) (eq ?theta_f G) (eq ?theta_i G))
         (and (eq ?deltaTheta G) (eq ?theta_f S) (eq ?theta_i G))
         (and (eq ?deltaTheta G) (eq ?theta_f G) (eq ?theta_i S))
       ) then
      (suggestFormula "deltaTheta = theta_f - theta_i")
   )
)

(defrule changeInAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name deltaW) (value ?deltaW & S)) (variable (name w_f) (value ?w_f & G)) 
            (variable (name w_i) (value ?w_i & G)))
       (and (variable (name deltaW) (value ?deltaW & G)) (variable (name w_f) (value ?w_f & S))
            (variable (name w_i) (value ?w_i & G)))
       (and (variable (name deltaW) (value ?deltaW & G)) (variable (name w_f) (value ?w_f & G)) 
            (variable (name w_i) (value ?w_i & S))))
=>
   (suggestFormula "deltaW = w_f - w_i")
)

(defrule averageAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name averageW) (value ?averageW & S)) (variable (name deltaTheta) (value ?deltaTheta & G)) 
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageW) (value ?averageW & G)) (variable (name deltaTheta) (value ?deltaTheta & S)) 
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageW) (value ?averageW & G)) (variable (name deltaTheta) (value ?deltaTheta & G)) 
            (variable (name deltaTime) (value ?deltaTime & S))))
=>
   (suggestFormula "averageW = deltaTheta / deltaTime")
)

(defrule functionAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name functionW) (value ?functionW & S)) (variable (name functionTheta) (value ?functionTheta & G)))
       (and (variable (name functionW) (value ?functionW & G)) (variable (name functionTheta) (value ?functionTheta & S))))
=>
   (suggestFormula "w = d(theta)/dt")
)

(defrule averageAngularAcceleration
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name averageAlpha) (value ?averageAlpha & S)) (variable (name deltaW) (value ?deltaW & G))
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageAlpha) (value ?averageAlpha & G)) (variable (name deltaW) (value ?deltaW & S)) 
            (variable (name deltaTime) (value ?deltaTime & G)))
       (and (variable (name averageAlpha) (value ?averageAlpha & G)) (variable (name deltaW) (value ?deltaW & G)) 
            (variable (name deltaTime) (value ?deltaTime & S))))
=>
   (suggestFormula "averageAlpha = deltaW / deltaTime")
)

(defrule functionAngularAccelerationWithAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name functionAlpha) (value ?functionAlpha & S)) (variable (name functionW) (value ?functionW & G)))
       (and (variable (name functionAlpha) (value ?functionAlpha & G)) (variable (name functionW) (value ?functionW & S))))
=>
   (suggestFormula "alpha = d(w)/dt")
)

(defrule functionAngularAccelerationWithAngularPosition
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name functionAlpha) (value ?functionAlpha & S)) (variable (name functionTheta) (value ?functionTheta & G)))
       (and (variable (name functionAlpha) (value ?functionAlpha & G)) (variable (name functionTheta) (value ?functionTheta & S))))
=>
   (suggestFormula "alpha = second derivative of theta")
)

(defrule linearVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name v) (value ?v & S)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & G)))
       (and (variable (name v) (value ?v & G)) (variable (name w) (value ?w & S)) (variable (name r) (value ?r & G)))
       (and (variable (name v) (value ?v & G)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & S))))
=>
   (suggestFormula "v = w * r")
)

(defrule linearAcceleration
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name a) (value ?a & S)) (variable (name alpha) (value ?alpha & G)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name alpha) (value ?alpha & S)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name alpha) (value ?alpha & G)) (variable (name r) (value ?r & S))))
=>
   (suggestFormula "a = alpha * r")
)

(defrule radialAccelerationWithAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name a) (value ?a & S)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name w) (value ?w & S)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name w) (value ?w & G)) (variable (name r) (value ?r & S))))
=>
   (suggestFormula "a = w^2 * r")
)

(defrule radialAccelerationWithLinearVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name a) (value ?a & S)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name v) (value ?v & S)) (variable (name r) (value ?r & G)))
       (and (variable (name a) (value ?a & G)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & S))))
=>
   (suggestFormula "a = v^2 / r")
)

(defrule periodWithLinearVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name period) (value ?period & S)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & G)))
       (and (variable (name period) (value ?period & G)) (variable (name v) (value ?v & S)) (variable (name r) (value ?r & G)))
       (and (variable (name period) (value ?period & G)) (variable (name v) (value ?v & G)) (variable (name r) (value ?r & S))))
=>
   (suggestFormula "period = 2PI * r / v")
)

(defrule periodWithAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name period) (value ?period & S)) (variable (name w) (value ?w & G)))
       (and (variable (name period) (value ?period & G)) (variable (name w) (value ?w & S))))
=>
   (suggestFormula "period = 2PI / w")
)

(defrule rotationalKineticEnergy
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name K) (value ?K & S)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & G)))
       (and (variable (name K) (value ?K & G)) (variable (name I) (value ?I & S)) (variable (name w) (value ?w & G)))
       (and (variable (name K) (value ?K & G)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & S))))
=>
   (suggestFormula "K = 0.5Iw^2")
)

(defrule parallelAxisTheorem
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name I) (value ?I & S)) (variable (name I_com) (value ?I_com & G)) 
            (variable (name m) (value ?m & G)) (variable (name h) (value ?h & G)))
       (and (variable (name I) (value ?I & G)) (variable (name I_com) (value ?I_com & S)) 
            (variable (name m) (value ?m & G)) (variable (name h) (value ?h & G)))
       (and (variable (name I) (value ?I & G)) (variable (name I_com) (value ?I_com & G)) 
            (variable (name m) (value ?m & S)) (variable (name h) (value ?h & G)))
       (and (variable (name I) (value ?I & G)) (variable (name I_com) (value ?I_com & G)) 
            (variable (name m) (value ?m & G)) (variable (name h) (value ?h & S))))
=>
   (suggestFormula "I = I_com + Mh^2")
)

(defrule torqueVector
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name torque_vector) (value ?torque_vector & S)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name F_vector) (value ?F_vector & G)))
       (and (variable (name torque_vector) (value ?torque_vector & G)) (variable (name r_vector) (value ?r_vector & S)) 
            (variable (name F_vector) (value ?F_vector & G)))
       (and (variable (name torque_vector) (value ?torque_vector & G)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name F_vector) (value ?F_vector & S))))
=>
   (suggestFormula "torque_vector = r_vector x F_vector")
)

(defrule torqueMagnitude
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name torque_magnitude) (value ?torque_magnitude & S)) (variable (name r) (value ?r & G)) 
            (variable (name F) (value ?F & G)) (variable (name theta) (value ?theta & G)))
       (and (variable (name torque_magnitude) (value ?torque_magnitude & G)) (variable (name r) (value ?r & S)) 
            (variable (name F) (value ?F & G)) (variable (name theta) (value ?theta & G)))
       (and (variable (name torque_magnitude) (value ?torque_magnitude & G)) (variable (name r) (value ?r & G)) 
            (variable (name F) (value ?F & S)) (variable (name theta) (value ?theta & G)))
       (and (variable (name torque_magnitude) (value ?torque_magnitude & G)) (variable (name r) (value ?r & G)) 
            (variable (name F) (value ?F & G)) (variable (name theta) (value ?theta & S))))
=>
   (suggestFormula "torque_magnitude = r * F * sin(theta)")
)

(defrule netTorque
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name torque_net) (value ?torque_net & S)) (variable (name I) (value ?I & G)) 
            (variable (name alpha) (value ?alpha & G)))
       (and (variable (name torque_net) (value ?torque_net & G)) (variable (name I) (value ?I & S)) 
            (variable (name alpha) (value ?alpha & G)))
       (and (variable (name torque_net) (value ?torque_net & G)) (variable (name I) (value ?I & G)) 
            (variable (name alpha) (value ?alpha & S))))
=>
   (suggestFormula "torque_net = I * alpha")
)

(defrule angularMomentumVector
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name L_vector) (value ?L_vector & S)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name v_vector) (value ?v_vector & G)) (variable (name m) (value ?m & G)))
       (and (variable (name L_vector) (value ?L_vector & G)) (variable (name r_vector) (value ?r_vector & S)) 
            (variable (name v_vector) (value ?v_vector & G)) (variable (name m) (value ?m & G)))
       (and (variable (name L_vector) (value ?L_vector & G)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name v_vector) (value ?v_vector & S)) (variable (name m) (value ?m & G)))
       (and (variable (name L_vector) (value ?L_vector & G)) (variable (name r_vector) (value ?r_vector & G)) 
            (variable (name v_vector) (value ?v_vector & G)) (variable (name m) (value ?m & S))))
=>
   (suggestFormula "L_vector = m * (r_vector x v_vector)")
)

(defrule angularMomentumMagnitude
   (declare (salience ?*FORMULA_SALIENCE*))
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
   (suggestFormula "L_magnitude = r * m * v * sin(theta)")
)

(defrule angularMomentum
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name L) (value ?L & S)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & G)))
       (and (variable (name L) (value ?L & G)) (variable (name I) (value ?I & S)) (variable (name w) (value ?w & G)))
       (and (variable (name L) (value ?L & G)) (variable (name I) (value ?I & G)) (variable (name w) (value ?w & S))))
=>
   (suggestFormula "L = I * w")
)

(defrule functionNetTorque
   (declare (salience ?*FORMULA_SALIENCE*))
   (or (and (variable (name functionTorque) (value ?functionTorque & S)) (variable (name functionL) (value ?functionL & G)))
       (and (variable (name functionTorque) (value ?functionTorque & G)) (variable (name functionL) (value ?functionL & S))))
=>
   (suggestFormula "torque = dL/dt")
)

/************************************
* Rules checking whether the user is given the titular variable
*/

(defrule needTheta 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name theta) (value ?))
=>
   (bind ?value (convertInput "Is an angular position or angle between vectors given?"))
   (assert (variable (name theta) (value ?value)))
)

(defrule needArcLength 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name s) (value ?))
=>
   (bind ?value (convertInput "Is an arc length given?"))
   (assert (variable (name s) (value ?value)))
)

(defrule needRadius 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name r) (value ?))
=>
   (bind ?value (convertInput "Is a radius or distance to a rotation axis given?"))
   (assert (variable (name r) (value ?value)))
)

(defrule needRadiusVector 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name r_vector) (value ?))
=>
   (bind ?value (convertInput "Is a radius vector or distance vector to a point or rotation axis given?"))
   (assert (variable (name r_vector) (value ?value)))
   (printline ?value)
)

(defrule needDeltaTheta 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name deltaTheta) (value ?))
=>
   (bind ?value (convertInput "Is a difference in angles or angular positions given?"))
   (assert (variable (name deltaTheta) (value ?value)))
)

(defrule needFinalTheta 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name theta_f) (value ?))
=>
   (bind ?value (convertInput "Is a final angle or angular position given?"))
   (assert (variable (name theta_f) (value ?value)))
)

(defrule needInitialTheta 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name theta_i) (value ?))
=>
   (bind ?value (convertInput "Is an initial angle or angular position given?"))
   (assert (variable (name theta_i) (value ?value)))
)

(defrule needTime 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name T) (value ?))
=>
   (bind ?value (convertInput "Is a time given?"))
   (assert (variable (name T) (value ?value)))
)

(defrule needDeltaTime 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name deltaTime) (value ?))
=>
   (bind ?value (convertInput "Is a difference in times given?"))
   (assert (variable (name deltaTime) (value ?value)))
)

(defrule needLinearVelocity 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name v) (value ?))
=>
   (bind ?value (convertInput "Is a linear velocity given?"))
   (assert (variable (name v) (value ?value)))
)

(defrule needLinearVelocityVector 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name v_vector) (value ?))
=>
   (bind ?value (convertInput "Is a linear velocity vector given?"))
   (assert (variable (name v_vector) (value ?value)))
)

(defrule needAngularVelocity 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name w) (value ?))
=>
   (bind ?value (convertInput "Is an angular velocity given?"))
   (assert (variable (name T) (value ?value)))
)

(defrule needDeltaW 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name deltaW) (value ?))
=>
   (bind ?value (convertInput "Is a change in angular velocity given?"))
   (assert (variable (name deltaW) (value ?value)))
)

(defrule needFinalAngularVelocity 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name w_f) (value ?))
=>
   (bind ?value (convertInput "Is a final angular velocity given?"))
   (assert (variable (name w_f) (value ?value)))
)

(defrule needInitialAngularVelocity 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name w_i) (value ?))
=>
   (bind ?value (convertInput "Is an initial angular velocity given?"))
   (assert (variable (name w_i) (value ?value)))
)

(defrule needAverageAngularVelocity 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name averageW) (value ?))
=>
   (bind ?value (convertInput "Is an average angular velocity given?"))
   (assert (variable (name averageW) (value ?value)))
)

(defrule needAngularVelocityFunction 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name functionW) (value ?))
=>
   (bind ?value (convertInput "Is the angular velocity given as a function of time?"))
   (assert (variable (name functionW) (value ?value)))
)

(defrule needAngularPositionFunction 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name functionTheta) (value ?))
=>
   (bind ?value (convertInput "Is the angular position given as a function of time?"))
   (assert (variable (name functionTheta) (value ?value)))
)

(defrule needLinearAcceleration 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name a) (value ?))
=>
   (bind ?value (convertInput "Is a linear acceleration given?"))
   (assert (variable (name a) (value ?value)))
)

(defrule needAngularAcceleration 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name alpha) (value ?))
=>
   (bind ?value (convertInput "Is an angular acceleration given?"))
   (assert (variable (name alpha) (value ?value)))
)

(defrule needAverageAngularAcceleration 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name averageAlpha) (value ?))
=>
   (bind ?value (convertInput "Is an average angular acceleration given?"))
   (assert (variable (name averageAlpha) (value ?value)))
)

(defrule needAngularAccelerationFunction 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name functionAlpha) (value ?))
=>
   (bind ?value (convertInput "Is angular acceleration given as a function of time?"))
   (assert (variable (name functionAlpha) (value ?value)))
)

(defrule needPeriod 
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name period) (value ?))
=>
   (bind ?value (convertInput "Is a period for circular motion given?"))
   (assert (variable (name period) (value ?value)))
)

(defrule needRotationalKineticEnergy
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name K) (value ?))
=>
   (bind ?value (convertInput "Is a rotational kinetic energy given?"))
   (assert (variable (name K) (value ?value)))
)

(defrule needMomentOfInertia
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name I) (value ?))
=>
   (bind ?value (convertInput "Is a moment of inertia given (not necessarily at the center of mass)?"))
   (assert (variable (name I) (value ?value)))
)

(defrule needMomentOfInertiaAtCenterOfMass
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name I_com) (value ?))
=>
   (bind ?value (convertInput "Is a moment of inertia given at the center of mass?"))
   (assert (variable (name I_com) (value ?value)))
)

(defrule needMass
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name m) (value ?))
=>
   (bind ?value (convertInput "Is the mass of the system given?"))
   (assert (variable (name m) (value ?value)))
)

(defrule needDistanceBetweenAxes
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name h) (value ?))
=>
   (bind ?value (convertInput "Is a perpendicular distance between parallel rotation axes given?"))
   (assert (variable (name h) (value ?value)))
)

(defrule needTorqueVector
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name torque_vector) (value ?))
=>
   (bind ?value (convertInput "Is torque given as a vector?"))
   (assert (variable (name torque_vector) (value ?value)))
)

(defrule needAngularMomentumFunction
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name functionL) (value ?))
=>
   (bind ?value (convertInput "Is angular momentum given as a function of time?"))
   (assert (variable (name functionL) (value ?value)))
)

(defrule needForceVector
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name F_vector) (value ?))
=>
   (bind ?value (convertInput "Is a force given as a vector?"))
   (assert (variable (name F_vector) (value ?value)))
)

(defrule needRadiusVector
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name r_vector) (value ?))
=>
   (bind ?value (convertInput "Is a distance or radius given as a vector?"))
   (assert (variable (name r_vector) (value ?value)))
)

(defrule needTorqueMagnitude
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name torque_magnitude) (value ?))
=>
   (bind ?value (convertInput "Is the magnitude of torque given?"))
   (assert (variable (name torque_magnitude) (value ?value)))
)

(defrule needNetTorque
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name torque_net) (value ?))
=>
   (bind ?value (convertInput "Is the net torque given?"))
   (assert (variable (name torque_net) (value ?value)))
)

(defrule needTorqueFunction
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name functionTorque) (value ?))
=>
   (bind ?value (convertInput "Is torque given as a function of time?"))
   (assert (variable (name functionTorque) (value ?value)))
)

(defrule needForce
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name F) (value ?))
=>
   (bind ?value (convertInput "Is the magnitude of a force given?"))
   (assert (variable (name F) (value ?value)))
)

(defrule needAngularMomentum
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name L) (value ?))
=>
   (bind ?value (convertInput "Is the angular momentum given?"))
   (assert (variable (name L) (value ?value)))
)

(defrule needAngularMomentumVector
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name L_vector) (value ?))
=>
   (bind ?value (convertInput "Is the angular momentum given as a vector?"))
   (assert (variable (name L_vector) (value ?value)))
)

(defrule needAngularMomentumMagnitude
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name L_magnitude) (value ?))
=>
   (bind ?value (convertInput "Is the magnitude of angular momentum given?"))
   (assert (variable (name L_magnitude) (value ?value)))
)

/*
* Halts the rule engine for the expert system
*/
(deffunction haltProgram ()
   (halt)

   (return)
)

/*
* Returns a list of the valid variable short-hands used within this program
* @return                  the list of valid variable short-hands
*/
(deffunction validVariables ()
   (bind ?variables "theta s r r_vector deltaTheta theta_f theta_i T deltaTime v v_vector w deltaW w_f w_i averageW functionW ")
   (bind ?variables (sym-cat ?variables "functionTheta a alpha averageAlpha functionAlpha period K I I_com m h torque_vector functionL "))
   (bind ?variables (sym-cat ?variables "F_vector r_vector torque_magnitude torque_net functionTorque F L L_vector L_magnitude"))

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
   (printline "L_magnitude      - magnitude of angular momentum")
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
      (bind ?valid (member$ (sym-cat "" ?input) ?validVariables))

      (if (integerp ?valid) then
         (bind ?result ?input) 
       else
         (printline "Valid variable not detected. Please enter a valid variable short-hand from the key.")
      ) 
   )  ; while (= ?result "invalid")

   (assert (variable (name ?result) (value S)))
   (assert (target (name ?result)))
   (facts)
   (return)
)  ; deffunction findVariableBeingSolvedFor

/*
* Creates and returns a list containing the four valid user inputs for the backward chained questions: 
* 'y', 'Y', 'n', and 'N'
* @return                     the list of the four valid inputs
*/
(deffunction validInputs ()
   (return (explode$ "y Y n N"))
)  ; deffunction validInputs ()

/*
* Asks a given question and determines whether the user's input is an affirmative or negative response        
* @param question             the question to ask and retrieve input from
* @return                     G if the first character of user input is a 'y' or 'Y'
*                             N if the first character of user input is an 'n' or 'N'
*/
(deffunction convertInput (?question)
   (bind ?result "invalid")

   (while (= ?result "invalid")
      (printline)

      (bind ?input (ask (sym-cat (+ ?*questions_asked* 1) ". " ?question " ")))
      (bind ?character (sym-cat (sub-string 1 1 ?input)))

      (bind ?validInputs (validInputs))
      (bind ?valid (member$ ?character ?validInputs))

      (if (integerp ?valid) then
         (if (<= ?valid 2) then
            (bind ?result G)
          else 
            (bind ?result N)
         )   
       else
         (printline "Improper input detected. Please enter your response to the following question again ('y' or 'n').")
      )  ; if (integerp ?valid) then
   )  ; while (= ?result "invalid")

   (bind ?*questions_asked* (++ ?*questions_asked*))

   (return ?result)
)  ; deffunction convertInput (?question)

/*
* 
*/
(deffunction suggestFormula (?formula)
   (haltProgram)
   
   (printline (sym-cat "Based on your responses, we believe that you should use the formula: " ?formula))

   (return)
)

(run)