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

(defglobal ?*questions_asked* = 0)  ; the amount of questions asked so far

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

(defrule angular_position
   (variable (name angularPosition) (value S))
   (variable (name arcLength)       (value G))
   (variable (name radius)          (value G))
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
