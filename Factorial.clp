/*
* Author: Dhruv Aron
* Date of Creation: 1/20/23 
* 
* Description of Module:
* Provides a user interface for calculating and returning the factorial 
* of a positive, non-zero integer.
*
* Publicly Accessible Functions:
* factorial
*/

(batch "utilities_v3.clp")

/*
* Casts and returns the integer parameter to a long if not already one,
* circumventing crashes caused by casting a long to a long
* @num            the number to cast to a long 
* @precondition   num must be of a valid number data type
* @return         num casted to a long form    
*/
(deffunction castLong (?num)
   (if (longp ?input) then
      (bind ?result ?input)
    else
      (bind ?result (long ?input))
   )

   (return ?result)

) ; deffunction castLong (?num)

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
* Provides a user interface for calculating the factorial of a positive non-zero integer number
* and returns (if valid) the factorial of the inputted number.
* If num is a decimal number greater than or equal to 1, the decimal places  will be truncated.
* @return         the factorial of the inputted (valid) number
*/
(deffunction factorial ()
   (bind ?question "What positive non-zero integer do you want to calculate the factorial of")
   (bind ?input (askQuestion ?question))
   (bind ?isNum (numberp ?input))

   (if (not ?isNum) then
      (printline "Number not entered. Restarting program.")
      (factorial)
    else (if (< ?input 1) then
      (printline "Please enter a positive non-zero integer.")
      (factorial)
    else
      (bind ?validInt (castLong ?input))
      (bind ?result (fact ?validInt))

      (print "The factorial of ")
      (print ?validInt)
      (print " is ")
      (print ?result)
   )) ; if (not ?isNum) then
   
   (return)
)     ; deffunction factorial ()

(factorial)
(printline "") ; prints a newline after execution