(batch "utilities_v3.clp")

/*
* Author: Dhruv Aron 
* Date of Creation: 1/26/23
* 
* Description of Module: 
* Provides a user interface for calculating and outputting a list of fibonacci numbers 
* of an inputted length, provided the inputted length is a whole number (longs are included).
*
* Publicly Accessible Functions:
* fib
*/

/*
* Generates and returns a list of fibonacci numbers 
* determined by the inputted length parameter
* @param num      the number of fibonacci numbers to return 
*                 (length of the returned list)
* @precondition   num is a whole number (longs are acceptable)
* @return         a list containing the given number of
*                 fibonacci numbers
*/
(deffunction fibo (?num)
   (bind ?fibNums (create$ 1 1))

   (if (> ?num 2) then
      (for (bind ?index 3) (<= ?index ?num) (++ ?index)
         (bind ?fibNum1 (nth$ (- ?index 2) ?fibNums))             ; get the number two indexes before

         (bind ?fibNum2 (nth$ (- ?index 1) ?fibNums))             ; get the number one index before

         (bind ?fibNumAdded (+ ?fibNum1 ?fibNum2))                ; combine the two to get the new fibonacci number

         (bind ?fibNums (insert$ ?fibNums ?index ?fibNumAdded))   ; add the new number to the list
      )
    else
      (if (= ?num 1) then
         (bind ?fibNums (delete$ ?fibNums 1 1))                   ; only remove one of the elements
       else
         (if (= ?num 0) then       
            (bind ?fibNums (delete$ ?fibNums 1 2))                ; remove both of the existing elements
         )
      )
   )  ; if (> ?num 2) then

   (return ?fibNums)
)  ; deffunction fibo (?num)

/*
* Determines whether the inputted number is valid
* @param num      the number being validated
* @return         TRUE if num is an integer >= 0,
*                 otherwise FALSE
*/
(deffunction isValid (?num)
   (bind ?valid FALSE)
   (if (or (integerp ?num) (longp ?num)) then
      (if (> ?num -1) then
         (bind ?valid TRUE)
      )
   )

   (return ?valid)
)  ; deffunction isValid (?num)

/*
* Takes in a numerical parameter and returns a list of 
* fibonacci numbers if valid
* @param num      the inputted number of fibonacci numbers to return
* @return         a list of fibonacci numbers if num is valid,
*                 otherwise FALSE
*/
(deffunction fibonacci (?num)
   (bind ?result FALSE)
   (if (isValid ?num) then
      (bind ?result (fibo ?num))
   )

   (return ?result)
)  ; deffunction fibonacci (?num)

/*
* Provides a user interface for intaking a given length
* and outputting a corresponding list of fibonacci numbers
* @return         nil
*/
(deffunction fib ()
   (bind ?question "How many fibonacci numbers would you like to retrieve")
   (bind ?input (askQuestion ?question))

   (bind ?result (fibonacci ?input))

   (if (and (not (listp ?result)) (= ?result FALSE)) then
      (printline "Inputted length was not a whole number (integer >= 0). Ending program")
    else
      (print "Here is your list of ")
      (print ?input)
      (print " fibonacci numbers: ")
      (printline ?result)
   ) 

   (return)
)  ; deffunction fib ()

(fib)