(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 4/15/23
* Description of Module:
*/

/*
* Defines a template for each variable within the rotational physics formulas
* @slot name                  the name of the variable
* @slot value                 the value indicating whether this variable applies to a given formula,
*                             with 'G' indicating that it is given and 'S' indicating that it needs to 
*                             be solved for, otherwise 'F' if it does not apply
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

(defrule angularPosition_theta
   (variable (name theta) (value S))
   (variable (name s)     (value G))
   (variable (name r)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularPosition_arcLength
   (variable (name theta) (value G))
   (variable (name s)     (value S))
   (variable (name r)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularPosition_radius
   (variable (name theta) (value G))
   (variable (name s)     (value G))
   (variable (name r)     (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularDisplacement_displacement
   (variable (name deltaTheta) (value S))
   (variable (name theta_f)    (value G))
   (variable (name theta_i)    (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularDisplacement_finalPosition
   (variable (name deltaTheta) (value G))
   (variable (name theta_f)    (value S))
   (variable (name theta_i)    (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule angularDisplacement_initialPosition
   (variable (name deltaTheta) (value G))
   (variable (name theta_f)    (value G))
   (variable (name theta_i)    (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule deltaTime_delta
   (variable (name deltaT) (value S))
   (variable (name t_f)    (value G))
   (variable (name t_i)    (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule deltaTime_finalTime
   (variable (name deltaT) (value G))
   (variable (name t_f)    (value S))
   (variable (name t_i)    (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule deltaTime_initialTime
   (variable (name deltaT) (value G))
   (variable (name t_f)    (value G))
   (variable (name t_i)    (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule deltaAngularVelocity_de
   (variable (name deltaW) (value S))
   (variable (name w_f)    (value G))
   (variable (name w_i)    (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule deltaAngularVelocity_de
   (variable (name deltaW) (value G))
   (variable (name w_f)    (value S))
   (variable (name w_i)    (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule deltaAngularVelocity_de
   (variable (name deltaW) (value G))
   (variable (name w_f)    (value S))
   (variable (name w_i)    (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularVelocity_average
   (variable (name averageW)   (value S))
   (variable (name deltaTheta) (value G))
   (variable (name deltaT)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularVelocity_angularDisplacement
   (variable (name averageW)   (value G))
   (variable (name deltaTheta) (value S))
   (variable (name deltaT)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularVelocity_deltaTime
   (variable (name averageW)   (value G))
   (variable (name deltaTheta) (value G))
   (variable (name deltaT)     (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularVelocity_functionAngularVelocity
   (variable (name functionW)     (value S))
   (variable (name functionTheta) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularVelocity_functionAngularPosition
   (variable (name functionW)     (value G))
   (variable (name functionTheta) (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularVelocity_instantAngularVelocity
   (variable (name w)         (value S))
   (variable (name functionW) (value G))
   (variable (name T)         (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularVelocity_instantAngularVelocity
   (variable (name w)         (value G))
   (variable (name functionW) (value G))
   (variable (name T)         (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularAcceleration_deltaTime
   (variable (name averageAlpha) (value S))
   (variable (name deltaW)       (value G))
   (variable (name deltaT)       (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularAcceleration_deltaTime
   (variable (name averageAlpha) (value G))
   (variable (name deltaW)       (value S))
   (variable (name deltaT)       (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule averageAngularAcceleration_deltaTime
   (variable (name averageAlpha) (value G))
   (variable (name deltaW)       (value G))
   (variable (name deltaT)       (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularVelocity_functionAngularPosition
   (variable (name functionAlpha) (value S))
   (variable (name functionW)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularVelocity_functionAngularPosition
   (variable (name functionAlpha) (value G))
   (variable (name functionW)     (value S))
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

(defrule instantAngularAcceleration_instantAlpha
   (variable (name alpha)  (value G))
   (variable (name functionAlpha) (value S))
   (variable (name T)             (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule instantAngularAcceleration_instantAlpha
   (variable (name alpha)  (value G))
   (variable (name functionAlpha) (value G))
   (variable (name T)             (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearVelocity_v
   (variable (name v) (value S))
   (variable (name w) (value G))
   (variable (name r) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearVelocity_w
   (variable (name v) (value G))
   (variable (name w) (value S))
   (variable (name r) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearVelocity_r
   (variable (name v) (value G))
   (variable (name w) (value G))
   (variable (name r) (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearAcceleration_a
   (variable (name a)     (value S))
   (variable (name alpha) (value G))
   (variable (name r) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearAcceleration_a
   (variable (name a)     (value G))
   (variable (name alpha) (value S))
   (variable (name r)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule linearAcceleration_a
   (variable (name a)     (value G))
   (variable (name alpha) (value G))
   (variable (name r)     (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule radialAcceleration_a
   (variable (name a) (value S))
   (variable (name w) (value G))
   (variable (name r) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule radialAcceleration_a
   (variable (name a) (value G))
   (variable (name w) (value S))
   (variable (name r) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule radialAcceleration_a
   (variable (name a) (value G))
   (variable (name w) (value G))
   (variable (name r) (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule period_period
   (variable (name period) (value S))
   (variable (name w)      (value G))
=>

)

(defrule period_w
   (variable (name period) (value G))
   (variable (name w)      (value s))
=>

)

(defrule rotationalKineticEnergy_K
   (variable (name K) (value S))
   (variable (name I) (value G))
   (variable (name w) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule rotationalKineticEnergy_K
   (variable (name K) (value G))
   (variable (name I) (value S))
   (variable (name w) (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule rotationalKineticEnergy_K
   (variable (name K) (value G))
   (variable (name I) (value G))
   (variable (name w) (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule parallelAxis_I
   (variable (name I)     (value S))
   (variable (name I_com) (value G))
   (variable (name m)     (value G))
   (variable (name h)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule parallelAxis_I
   (variable (name I)     (value G))
   (variable (name I_com) (value S))
   (variable (name m)     (value G))
   (variable (name h)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule parallelAxis_I
   (variable (name I)     (value G))
   (variable (name I_com) (value G))
   (variable (name m)     (value S))
   (variable (name h)     (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule parallelAxis_I
   (variable (name I)     (value G))
   (variable (name I_com) (value G))
   (variable (name m)     (value G))
   (variable (name h)     (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueVector_T
   (variable (name torque_vector) (value S))
   (variable (name r_vector)      (value G))
   (variable (name F_vector)      (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueVector_T
   (variable (name torque_vector) (value G))
   (variable (name r_vector)      (value S))
   (variable (name F_vector)      (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueVector_T
   (variable (name torque_vector) (value G))
   (variable (name r_vector)      (value G))
   (variable (name F_vector)      (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueMagnitude_T
   (variable (name torque_magnitude) (value S))
   (variable (name r)                (value G))
   (variable (name F)                (value G))
   (variable (name theta)            (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueMagnitude_T
   (variable (name torque_magnitude) (value G))
   (variable (name r)                (value S))
   (variable (name F)                (value G))
   (variable (name theta)            (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueMagnitude_T
   (variable (name torque_magnitude) (value G))
   (variable (name r)                (value G))
   (variable (name F)                (value S))
   (variable (name theta)            (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule torqueMagnitude_T
   (variable (name torque_magnitude) (value G))
   (variable (name r)                (value G))
   (variable (name F)                (value G))
   (variable (name theta)            (value S))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule netTorque_T
   (variable (name torque_net) (value S))
   (variable (name I)          (value G))
   (variable (name alpha)      (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule netTorque_T
   (variable (name torque_net) (value G))
   (variable (name I)          (value S))
   (variable (name alpha)      (value G))
=>
   (printline "Conclusion: theta = s / r, where theta is the angular position, s is the arc length, and r is the radius")
)

(defrule netTorque_T
   (variable (name torque_net) (value G))
   (variable (name I)          (value G))
   (variable (name alpha)      (value S))
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
