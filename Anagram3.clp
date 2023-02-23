(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 2/9/23
* Description of Module: 
*/

(defglobal ?*FIXED_WORD_LENGTH* = 6) ; the fixed length of the word that is used to generate anagrams

/*
* 
* @param c
* @param p        
*/
(deftemplate Letter (slot c) (slot p))

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
* @param letter         the character that is being asserted for the anagram
* @param position       the position of the character being asserted 
*                       (in order to allow duplicates)
*/
(deffunction assertLetter (?letter ?position)
   (assert (Letter (c ?letter) (p ?position)))

   (return)
)  ; deffunction assertLetter (?letter) (?position)

/*
* Takes in a sliced list of letters/characters and asserts 
* each individual character with a distinct position
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
* @param input          the user input
* @return               true if the user input is a string and it is of the appropriate length,
*                       otherwise false
*/
(deffunction inputIsValid (?input)
   (return (and (stringp ?input) (= (str-length ?input) ?*FIXED_WORD_LENGTH*)))
)  ; deffunction inputIsValid (?input)

/*
* Slices the given string into a list containing each character in
* the string within each index (in the original order)
* @param text           the string to slice into a list
* @precondition         text is a string
* @return               a list containing all of the string's individual 
*                       characters in the same order         
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
* Provides a user interface for entering a word to generate anagrams of
* @return               the user's input (in the form of a string)
*/
(deffunction getInput ()
   (bind ?prompt (sym-cat "Please enter a " ?*FIXED_WORD_LENGTH* " letter word to generate anagrams for: "))
   (bind ?input (askline ?prompt))

   (return ?input)
)  ; deffunction getInput () 

/*
* Generates and prints out anagrams of the user's inputted word of
* an appropriate length
* @param input          the user's input
* @precondition         input must be a string
*/
(deffunction printAnagrams (?input)
   (bind ?sliced (slice$ ?input))
   (assertList ?sliced)

   (bind ?combinations (run))
   (printline "")
   (print "The rule was fired ")
   (print ?combinations)
   (printline " times!")

   (return)
)  ; deffunction printAnagrams (?input)

/*
* Notifies the user that the input is invalid if not of the appropriate length, or
* instead proceeds to generate/print the anagrams if the input is valid
* @param input          the user's input
* @precondition         input must be a string
*/
(deffunction generateResult (?input)
   (if (not (inputIsValid ?input)) then
      (printline (sym-cat "Inputted word was not of length " ?*FIXED_WORD_LENGTH* ". Ending program."))
    else
      (printAnagrams ?input)
   ) 

   (return)
)  ; deffunction generateResult (?input)

/*
* Provides a user interface for intaking a word and generating/printing
* anagrams of the inputted word if the input is of a valid length
*/
(deffunction main ()
   (bind ?input (getInput))

   (generateResult ?input)

   (return)
)  ; deffunction main ()

(main)