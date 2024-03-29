(batch "utilities_v3.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 1/20/23 
* 
* Description of Module:
* Provides a user interface for calculating and outputting the factorial 
* of a whole number, truncating the decimal places if a positive decimal is entered.
* Due to long data type limitations, an inaccurate value for inputs >= 21 
* will be outputted.
*
* Publicly Accessible Functions:
* factorial
*/

/*
* Casts and returns the whole number parameter to a long if not already one,
* circumventing crashes caused by casting a long to a long
* @num            the number to cast to a long 
* @precondition   num must be of a valid numerical data type
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
* Returns the factorial of the given number parameter
* @num            the number to calculate the factorial of
* @precondition   num must be a positive number (including zero)  
* @return         the factorial of num (truncating num's decimal places if any)
*/
(deffunction fact (?num)
   (if (= ?num 0) then
      (bind ?result 1)
    else
      (bind ?result (* ?num (fact (- ?num 1))))
   )

   (return ?result)
)              ; deffunction fact (?num)

/*
* Provides a user interface for calculating the factorial of a whole number
* and outputs (if valid) the factorial of the inputted number.
* If num is a positive decimal number, it will be treated as if
* the decimal places were truncated.
* If the inputted value is invalid, the program will be ended.
* @return         nil
*/
(deffunction factorial ()
   (bind ?question "What whole number do you want to calculate the factorial of")
   (bind ?input (askQuestion ?question))
   (bind ?isNum (numberp ?input))

   (if (not ?isNum) then
      (printline "Inputted value is not a number. Ending program.")
    else 
      (if (< ?input 0) then
         (printline "Inputted number was less than zero. Ending program.")
       else
         (bind ?validInt (castLong ?input))
         (bind ?result (fact ?validInt))

         (print "The factorial of ")
         (print ?validInt)
         (print " is ")
         (printline ?result)
      )        ; if (< ?input 0) then
   )           ; if (not ?isNum) then
   
   (return)
)              ; deffunction factorial ()

(factorial)    ; run factorial
(printline "") ; prints a new line after execution