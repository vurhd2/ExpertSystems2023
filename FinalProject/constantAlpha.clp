/*
* Author: Dhruv Aron
* Date of Creation: 4/20/23
*
* Description of Module:
* Defines the rules that represent the five basic rotational
* kinematic formulas when angular acceleration is constant
*
*/

(defrule angularVelocityWithoutChangeInAngularPosition
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name w_f))
      (target (name w_i))
      (target (name alpha))
      (target (name t))
   )
   (variable (name w_f) (value ?w_f))
   (variable (name w_i) (value ?w_i)) 
   (variable (name alpha) (value ?alpha))
   (variable (name t) (value ?t))
=>
   (if (or (and             (eq ?w_i G) (eq ?alpha G) (eq ?t G))
           (and (eq ?w_f G)             (eq ?alpha G) (eq ?t G))
           (and (eq ?w_f G) (eq ?w_i G)               (eq ?t G))
           (and (eq ?w_f G) (eq ?w_i G) (eq ?alpha G)          )) then
      (suggestFormula "w_f = w_i + (alpha * t)")
   )
)

(defrule changeInAngularPositionWithAngularAccelerationAndInitialAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name deltaTheta))
      (target (name w_i))
      (target (name t))
      (target (name alpha))
   )
   (variable (name deltaTheta) (value ?deltaTheta))
   (variable (name w_i) (value ?w_i)) 
   (variable (name t) (value ?t))
   (variable (name alpha) (value ?alpha))
=>
   (if (or (and                    (eq ?w_i G) (eq ?t G) (eq ?alpha G))
           (and (eq ?deltaTheta G)             (eq ?t G) (eq ?alpha G))
           (and (eq ?deltaTheta G) (eq ?w_i G)           (eq ?alpha G))
           (and (eq ?deltaTheta G) (eq ?w_i G) (eq ?t G)          )) then
      (suggestFormula "deltaTheta = (w_i * t) + (0.5 * alpha * t^2)")
   )
)

(defrule angularVelocityWithoutTime
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name w_f))
      (target (name w_i))
      (target (name alpha))
      (target (name deltaTheta))
   )
   (variable (name w_f) (value ?w_f))
   (variable (name w_i) (value ?w_i)) 
   (variable (name alpha) (value ?alpha))
   (variable (name deltaTheta) (value ?deltaTheta))
=>
   (if (or (and             (eq ?w_i G) (eq ?alpha G) (eq ?deltaTheta G))
           (and (eq ?w_f G)             (eq ?alpha G) (eq ?deltaTheta G))
           (and (eq ?w_f G) (eq ?w_i G)               (eq ?deltaTheta G))
           (and (eq ?w_f G) (eq ?w_i G) (eq ?alpha G)                   )) then
      (suggestFormula "w_f^2 = w_i^2 + 2(alpha * deltaTheta)")
   )
)

(defrule changeInAngularPositionWithoutAngularAcceleration
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name deltaTheta))
      (target (name w_i))
      (target (name w_f))
      (target (name t))
   )
   (variable (name deltaTheta) (value ?deltaTheta))
   (variable (name w_i) (value ?w_i)) 
   (variable (name w_f) (value ?w_f))
   (variable (name t) (value ?t))
=>
   (if (or (and                    (eq ?w_i G) (eq ?w_f G) (eq ?t G))
           (and (eq ?deltaTheta G)             (eq ?w_f G) (eq ?t G))
           (and (eq ?deltaTheta G) (eq ?w_i G)             (eq ?t G))
           (and (eq ?deltaTheta G) (eq ?w_i G) (eq ?w_f G)          )) then
      (suggestFormula "deltaTheta = 0.5 * (w_f + w_i) * t")
   )
)

(defrule changeInAngularPositionWithoutInitialAngularVelocity
   (declare (salience ?*FORMULA_SALIENCE*))
   (or
      (target (name deltaTheta))
      (target (name w_f))
      (target (name alpha))
      (target (name t))
   )
   (variable (name deltaTheta) (value ?deltaTheta))
   (variable (name w_f) (value ?w_f)) 
   (variable (name alpha) (value ?alpha))
   (variable (name t) (value ?t))
=>
   (if (or (and                    (eq ?w_f G) (eq ?alpha G) (eq ?t G))
           (and (eq ?deltaTheta G)             (eq ?alpha G) (eq ?t G))
           (and (eq ?deltaTheta G) (eq ?w_f G)               (eq ?t G))
           (and (eq ?deltaTheta G) (eq ?w_f G) (eq ?alpha G)          )) then
      (suggestFormula "deltaTheta = (w_f * t) - (0.5 * alpha * t^2)")
   )
)