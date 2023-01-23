/*
* Author: Dhruv Aron
* Date of Creation: 1/20/23 
* Description of Module: 
*/

(batch "utilities_v3.clp")

/*
* Returns the factorial of the given integer parameter
* @num            the integer to calculate the factorial of
* @precondition   num must be a positive, non-zero integer   
* @return         the factorial of num
*/
(deffunction fact (?num)
   (if (= ?num 1) then
      (bind ?result 1)
    else
      (bind ?result (* ?num (fact (- ?num 1))))
   )

   (return ?result)
)

/*
*
*/
(deffunction factorial ()
   (bind ?question "What positive integer do you want to calculate the factorial of")
   (printout t crlf)
   (bind ?input (askQuestion ?question))

   (bind ?isNum (numberp ?input))

   (if (not ?isNum) then

      (printline "Please enter a number. Restarting program.")
      (factorial)

   else

      (if (< ?input 1) then

         (printline "Please enter a positive non-zero integer.")
         (factorial)

      else

         (if (longp ?input) then

            ;(bind ?result ?input)
            (return (fact ?input))

         else

            ;(bind ?result (long ?input))
            (return (fact (long ?input)))
         )
      )
   )

   ;(return (fact ?result))
)

(factorial)