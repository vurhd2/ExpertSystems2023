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
(defglobal ?*FIXED_WORD_LENGTH* = 6)

/*
* 
* @param l        
*/
(deftemplate Letter (slot c) (slot p))

(defrule anagram "DOCUMENT THIS PLEASE"

=>

)

/*
* 
* @param letter
* @param position
*/
(deffunction assertLetter (?letter) (?position)
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
   (return (and (string ?input) (= (str-length ?input )) ?*FIXED_WORD_LENGTH*))
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
   (bind ?prompt (sym-cat "Please enter a " ?*FIXED_WORD_LENGTH* " letter word to generate anagrams for"))
   (bind ?input (askline ?prompt))

   (if (not (inputisValid ?input))
      (printline (sym-cat "Inputted word was not of length " ?*FIXED_WORD_LENGTH* ". Ending program"))
    else
      (bind ?sliced (slice$ ?input))
      (assertList ?sliced)
      (run)
   )

   (return)
)