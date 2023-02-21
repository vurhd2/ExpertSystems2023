(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 2/9/23
* Description of Module: 
*/

/*
* 
*/
(defglobal ?*FIXED_WORD_LENGTH* = 6) ; the fixed length of the word that is used to be

/*
* 
* @param c
* @param p        
*/
(deftemplate Letter (slot c) (slot p))

/*
*  
*/
(defrule anagram "Generates all possible combinations of the given 6 letter word"
   (Letter (c ?c1) (p ?p1))
   (Letter (c ?c2) (p ?p2 &~?p1))
   (Letter (c ?c3) (p ?p3 &~?p2 &~?p1))
   (Letter (c ?c4) (p ?p4 &~?p3 &~?p2 &~?p1))
   (Letter (c ?c5) (p ?p5 &~?p4 &~?p3 &~?p2 &~?p1))
   (Letter (c ?c6) (p ?p6 &~?p5 &~?p4 &~?p3 &~?p2 &~?p1))
=>
   (printout t ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 " ")
)

/*
* 
* @param letter
* @param position
*/
(deffunction assertLetter (?letter ?position)
   (assert (Letter (c ?letter) (p ?position)))

   (return)
)  ; deffunction assertLetter (?letter) (?position)

/*
* 
* @param letters        the list of letters to be asserted
*/
(deffunction assertList (?letters)
   (for (bind ?index 1) (<= ?index ?*FIXED_WORD_LENGTH*) (++ ?index)
      (assertLetter (nth$ ?index ?letters) ?index) 
   )

   (return)
)  ; deffunction assertList (?letters)

/*
* Checks to ensure that the user input is of the necessitated length
* @param input          the 
*/
(deffunction inputIsValid (?input)
   (return (and (stringp ?input) (= (str-length ?input) ?*FIXED_WORD_LENGTH*)))
)  ; deffunction inputIsValid (?input)

/*
* Slices the given string into a list containing each character in
* the string within each index (in the original order)
* @param text        the string to slice into a list
* @precondition      text is a string
* @return            a list containing all of the string's characters
*                    in the same order         
*/
(deffunction slice$ (?text)
   (bind ?sliced (create$))

   (for (bind ?index 1) (<= ?index (str-length ?text)) (++ ?index)
      (bind ?character (sub-string ?index ?index ?text))
      (bind ?sliced (insert$ ?sliced ?index ?character))
   )

   (return ?sliced)
)  ; deffunction slice$ (?text)

/*
* 
*/
(deffunction getInput ()
   (bind ?prompt (sym-cat "Please enter a " ?*FIXED_WORD_LENGTH* " letter word to generate anagrams for: "))
   (bind ?input (askline ?prompt))

   (if (not (inputIsValid ?input)) then
      (printline (sym-cat "Inputted word was not of length " ?*FIXED_WORD_LENGTH* ". Ending program."))
    else
      (bind ?sliced (slice$ ?input))
      (assertList ?sliced)

      (bind ?combinations (run))
      (print "The rule was fired ")
      (print ?combinations)
      (printline " times!")
   )

   (return)
)

(getInput)