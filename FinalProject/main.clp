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
* t                - time
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
* L                - (magnitude of) angular momentum
* L_vector         - angular momentum vector
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

(do-backward-chaining variable)              ; enable backward chaining using the variable template

(defglobal ?*questions_asked* = 0)           ; the amount of questions asked so far

(defglobal ?*DIRECTORY* = "FinalProject/")   ; the directory housing this project's files

(defglobal ?*FORMULA_SALIENCE* = 75)         ; salience for all the rules that represent the formulas
(defglobal ?*VARIABLE_SALIENCE* = 50)        ; salience for all the rules that ask the user whether a certain variable is given

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
   (noFormulasLeft)
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
   (or
      (target (name theta))
      (target (name s))
      (target (name r))
   )
   (variable (name theta) (value ?theta))
   (variable (name s) (value ?s)) 
   (variable (name r) (value ?r))
=>
   (if (or (and               (eq ?s G) (eq ?r G))
           (and (eq ?theta G)           (eq ?r G))
           (and (eq ?theta G) (eq ?s G)          )) then
      (suggestFormula "s = theta * r")
    else
      (assert (variable (name finished) (value G)))
   )
)  ; defrule angularPosition

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
   (if (or (and                    (eq ?theta_f G) (eq ?theta_i G))
           (and (eq ?deltaTheta G)                 (eq ?theta_i G))
           (and (eq ?deltaTheta G) (eq ?theta_f G)                )) then
      (suggestFormula "deltaTheta = theta_f - theta_i")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule changeInAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name deltaW))
      (target (name w_f))
      (target (name w_i))
   )
   (variable (name deltaW) (value ?deltaW))
   (variable (name w_f) (value ?w_f)) 
   (variable (name w_i) (value ?w_i))
=>
   (if (or (and                (eq ?w_f G) (eq ?w_i G))
           (and (eq ?deltaW G)             (eq ?w_i G))
           (and (eq ?deltaW G) (eq ?w_f G)            )) then
      (suggestFormula "deltaW = w_f - w_i")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule averageAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name averageW))
      (target (name deltaTheta))
      (target (name deltaTime))
   )
   (variable (name averageW) (value ?averageW))
   (variable (name deltaTheta) (value ?deltaTheta)) 
   (variable (name deltaTime) (value ?deltaTime))
=>
   (if (or (and                  (eq ?deltaTheta G) (eq ?deltaTime G))
           (and (eq ?averageW G)                    (eq ?deltaTime G))
           (and (eq ?averageW G) (eq ?deltaTheta G)                  )) then
      (suggestFormula "averageW = deltaTheta / deltaTime")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule functionAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name functionW))
      (target (name functionTheta))
   )
   (variable (name functionW) (value ?functionW))
   (variable (name functionTheta) (value ?functionTheta)) 
=>
   (if (or (eq ?functionTheta G) (eq ?functionW G)) then
      (suggestFormula "w = d(theta)/dt")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule averageAngularAcceleration
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name averageAlpha))
      (target (name deltaW))
      (target (name deltaTime))
   )
   (variable (name averageAlpha) (value ?averageAlpha))
   (variable (name deltaW) (value ?deltaW)) 
   (variable (name deltaTime) (value ?deltaTime))
=>
   (if (or (and                      (eq ?deltaW G) (eq ?deltaTime G))
           (and (eq ?averageAlpha G)                (eq ?deltaTime G))
           (and (eq ?averageAlpha G) (eq ?deltaW G)                  )) then
      (suggestFormula "averageAlpha = deltaW / deltaTime")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule functionAngularAccelerationWithAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name functionAlpha))
      (target (name functionW))
   )
   (variable (name functionAlpha) (value ?functionAlpha))
   (variable (name functionW) (value ?functionW)) 
=>
   (if (or (eq ?functionAlpha G) (eq ?functionW G)) then
      (suggestFormula "alpha = d(w)/dt")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule functionAngularAccelerationWithAngularPosition
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name functionAlpha))
      (target (name functionTheta))
   )
   (variable (name functionAlpha) (value ?functionAlpha))
   (variable (name functionTheta) (value ?functionTheta)) 
=>
   (if (or (eq ?functionTheta G) (eq ?functionAlpha G)) then
      (suggestFormula "alpha = second derivative of theta with respect to time")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule linearVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name v))
      (target (name w))
      (target (name r))
   )
   (variable (name v) (value ?v))
   (variable (name w) (value ?w)) 
   (variable (name r) (value ?r))
=>
   (if (or (and           (eq ?w G) (eq ?r G))
           (and (eq ?v G)           (eq ?r G))
           (and (eq ?v G) (eq ?w G)          )) then
      (suggestFormula "v = w * r")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule linearAcceleration
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name a))
      (target (name alpha))
      (target (name r))
   )
   (variable (name a) (value ?a))
   (variable (name alpha) (value ?alpha)) 
   (variable (name r) (value ?r))
=>
   (if (or (and           (eq ?alpha G) (eq ?r G))
           (and (eq ?a G)               (eq ?r G))
           (and (eq ?a G) (eq ?alpha G)          )) then
      (suggestFormula "a = alpha * r")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule radialAccelerationWithAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name a))
      (target (name w))
      (target (name r))
   )
   (variable (name a) (value ?a))
   (variable (name w) (value ?w)) 
   (variable (name r) (value ?r))
=>
   (if (or (and           (eq ?w G) (eq ?r G))
           (and (eq ?a G)           (eq ?r G))
           (and (eq ?a G) (eq ?w G)          )) then
      (suggestFormula "a = r * w^2")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule radialAccelerationWithLinearVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name a))
      (target (name v))
      (target (name r))
   )
   (variable (name a) (value ?a))
   (variable (name v) (value ?v)) 
   (variable (name r) (value ?r))
=>
   (if (or (and           (eq ?v G) (eq ?r G))
           (and (eq ?a G)           (eq ?r G))
           (and (eq ?a G) (eq ?v G)          )) then
      (suggestFormula "a = v^2 / r")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule periodWithLinearVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name period))
      (target (name v))
      (target (name r))
   )
   (variable (name period) (value ?period))
   (variable (name v) (value ?v)) 
   (variable (name r) (value ?r))
=>
   (if (or (and                (eq ?v G) (eq ?r G))
           (and (eq ?period G)           (eq ?r G))
           (and (eq ?period G) (eq ?v G)          )) then
      (suggestFormula "period = 2PI * r / v")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule periodWithAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name period))
      (target (name w))
   )
   (variable (name period) (value ?period))
   (variable (name w) (value ?w)) 
=>
   (if (or (eq ?period G) (eq ?w G)) then
      (suggestFormula "period = 2PI / w")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule rotationalKineticEnergy
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name K))
      (target (name I))
      (target (name w))
   )
   (variable (name K) (value ?K))
   (variable (name I) (value ?I)) 
   (variable (name w) (value ?w))
=>
   (if (or (and           (eq ?I G) (eq ?w G))
           (and (eq ?K G)           (eq ?w G))
           (and (eq ?K G) (eq ?I G)          )) then
      (suggestFormula "K = 0.5 * I * w^2")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule parallelAxisTheorem
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name I))
      (target (name I_com))
      (target (name m))
      (target (name h))
   )
   (variable (name I) (value ?I))
   (variable (name I_com) (value ?I_com)) 
   (variable (name m) (value ?m))
   (variable (name h) (value ?h))
=>
   (if (or (and           (eq ?I_com G) (eq ?m G) (eq ?h G))
           (and (eq ?I G)               (eq ?m G) (eq ?h G))
           (and (eq ?I G) (eq ?I_com G)           (eq ?h G))
           (and (eq ?I G) (eq ?I_com G) (eq ?m G)          )) then
      (suggestFormula "I = I_com + (M * h^2)")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule torqueVector
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name torque_vector))
      (target (name r_vector))
      (target (name F_vector))
   )
   (variable (name torque_vector) (value ?torque_vector))
   (variable (name r_vector) (value ?r_vector)) 
   (variable (name F_vector) (value ?F_vector))
=>
   (if (or (and                       (eq ?r_vector G) (eq ?F_vector G))
           (and (eq ?torque_vector G)                  (eq ?F_vector G))
           (and (eq ?torque_vector G) (eq ?r_vector G)                 )) then
      (suggestFormula "torque_vector = r_vector x F_vector")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule torqueMagnitude
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name torque_magnitude))
      (target (name r))
      (target (name F))
      (target (name theta))
   )
   (variable (name torque_magnitude) (value ?torque_magnitude))
   (variable (name r) (value ?r)) 
   (variable (name F) (value ?F))
   (variable (name theta) (value ?theta))
=>
   (if (or (and                          (eq ?r G) (eq ?F G) (eq ?theta G))
           (and (eq ?torque_magnitude G)           (eq ?F G) (eq ?theta G))
           (and (eq ?torque_magnitude G) (eq ?r G)           (eq ?theta G))
           (and (eq ?torque_magnitude G) (eq ?r G) (eq ?F G)          )) then
      (suggestFormula "magnitude of torque vector = r * F * sin(theta)")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule netTorque
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name torque_net))
      (target (name I))
      (target (name alpha))
   )
   (variable (name torque_net) (value ?torque_net))
   (variable (name I) (value ?I)) 
   (variable (name alpha) (value ?alpha))
=>
   (if (or (and                    (eq ?I G) (eq ?alpha G))
           (and (eq ?torque_net G)           (eq ?alpha G))
           (and (eq ?torque_net G) (eq ?I G)              )) then
      (suggestFormula "net torque = I * alpha")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule angularMomentumVector
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name L_vector))
      (target (name r_vector))
      (target (name m))
      (target (name v_vector))
   )
   (variable (name L_vector) (value ?L_vector))
   (variable (name r_vector) (value ?r_vector)) 
   (variable (name m) (value ?m))
   (variable (name v_vector) (value ?v_vector))
=>
   (if (or (and                  (eq ?r_vector G) (eq ?m G) (eq ?v_vector G))
           (and (eq ?L_vector G)                  (eq ?m G) (eq ?v_vector G))
           (and (eq ?L_vector G) (eq ?r_vector G)           (eq ?v_vector G))
           (and (eq ?L_vector G) (eq ?r_vector G) (eq ?m G)                 )) then
      (suggestFormula "L_vector = m * (r_vector x v_vector)")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule angularMomentumVectorMagnitude
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name L))
      (target (name r))
      (target (name m))
      (target (name v))
      (target (name theta))
   )
   (variable (name L) (value ?L))
   (variable (name r) (value ?r)) 
   (variable (name m) (value ?m))
   (variable (name v) (value ?v))
   (variable (name theta) (value ?theta))
=>
   (if (or (and           (eq ?r G) (eq ?m G) (eq ?v G) (eq ?theta G))
           (and (eq ?L G)           (eq ?m G) (eq ?v G) (eq ?theta G))
           (and (eq ?L G) (eq ?r G)           (eq ?v G) (eq ?theta G))
           (and (eq ?L G) (eq ?r G) (eq ?m G)           (eq ?theta G))
           (and (eq ?L G) (eq ?r G) (eq ?m G) (eq ?v G)              )) then
      (suggestFormula "L = r * m * v * sin(theta)")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule angularMomentum
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name L))
      (target (name I))
      (target (name w))
   )
   (variable (name L) (value ?L))
   (variable (name I) (value ?I)) 
   (variable (name w) (value ?w))
=>
   (if (or (and           (eq ?I G) (eq ?w G))
           (and (eq ?L G)           (eq ?w G))
           (and (eq ?L G) (eq ?I G)          )) then
      (suggestFormula "L = I * w")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule functionNetTorque
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name functionTorque))
      (target (name functionL))
   )
   (variable (name functionTorque) (value ?functionTorque))
   (variable (name functionL) (value ?functionL)) 
=>
   (if (or (eq ?functionTorque G) (eq ?functionL G)) then
      (suggestFormula "torque = dL/dt")
    else
      (assert (variable (name finished) (value G)))
   )
)

(defrule givenConstantAngularAcceleration
   (declare (salience ?*FORMULA_SALIENCE*))
   (variable (name constantAlpha) (value G))
=>
   (batch (sym-cat ?*DIRECTORY* "constantAlpha.clp"))
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
   (bind ?value (convertInput "Is the (magnitude of) angular momentum given?"))
   (assert (variable (name L) (value ?value)))
)

(defrule needAngularMomentumVector
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name L_vector) (value ?))
=>
   (bind ?value (convertInput "Is the angular momentum given as a vector?"))
   (assert (variable (name L_vector) (value ?value)))
)

(defrule checkForConstantAngularAcceleration
   (declare (salience ?*VARIABLE_SALIENCE*))
   (need-variable (name constantAlpha) (value ?))
=>
   (bind ?value (convertInput "Is it given that the angular acceleration is constant?"))
   (assert (variable (name constantAlpha) (value ?value)))
)

(defrule isolateTheta
   (target (name theta))
=>
   (undefrule angularDisplacement)
   (undefrule changeInAngularVelocity)
   (undefrule )
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
   (bind ?variables "theta s r r_vector deltaTheta theta_f theta_i t deltaTime v v_vector w deltaW w_f w_i averageW functionW ")
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
   (printline "t                - time")
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

/*
* 
*/
(deffunction noFormulasLeft ()
   (haltProgram)

   (printline "I'm not sure which formula to use... It seems like your problem might be too complex for our purposes!")
   (printline "Sorry about that, and we wish you the best of luck in solving your problem!")

   (return)
)

(run)