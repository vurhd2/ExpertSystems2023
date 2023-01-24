(batch "utilities_v3.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 1/20/23 
* 
* Description of Module:
* Provides a user interface for calculating and returning the factorial 
* of a whole number, truncating the decimal places if a positive decimal is entered.
*
* Publicly Accessible Functions:
* factorial
*/

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

)              ; deffunction castLong (?num)

/*
* Returns the factorial of the given integer parameter
* @num            the integer to calculate the factorial of
* @precondition   num must be a whole number   
* @return         the factorial of num
*/
(deffunction fact (?num)
   (if (= ?num 0) then
      (bind ?result 1)
    else
      (bind ?result (* ?num (fact (- ?num 1))))
   )

   (return ?result)
)

/*
* Provides a user interface for calculating the factorial of a whole number
* and returns (if valid) the factorial of the inputted number.
* If num is a positive decimal number, the decimal places will be truncated.
* @return         the factorial of the inputted (valid) number
*/
(deffunction factorial ()
   (bind ?question "What whole number do you want to calculate the factorial of")
   (bind ?input (askQuestion ?question))
   (bind ?isNum (numberp ?input))

   (if (not ?isNum) then
      (printline "A number was not entered. Restarting program.")
      (factorial)
    else 
      (if (< ?input 0) then
         (printline "Inputted number was less than zero. Restarting program.")
         (factorial)
       else
         (bind ?validInt (castLong ?input))
         (bind ?result (fact ?validInt))

         (print "The factorial of ")
         (print ?validInt)
         (print " is ")
         (printline ?result)
      )
   )           ; if (not ?isNum) then
   
   (return)
)              ; deffunction factorial ()

(factorial)    ; run factorial
(printline "") ; prints a new line after execution