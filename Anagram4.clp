(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 2/27/23
* 
* Description of Module: 
* Provides a user interface for generating/printing anagrams of an inputted word of any length
*
* Publicly Accessible Functions:
* main
* 
* RULES:
* main                  Begins the process for intaking a word of any length and generating all possible anagrams of it
* anagram               Generates and prints all possible combinations of the given word using distinct positions
*/

(defglobal ?*ASCII_DOUBLE_QUOTE* = 34)                ; the ascii value for double quotes ("")
(defglobal ?*CRASH_LIMIT* = 10)                       ; the maximum length word that can be used for anagrams without crashing the program

/*
* Defines a template for letters being used to generate anagrams with possible duplicate letters
* @slot c               the actual character value of the letter
* @slot p               the position of the letter in the anagram (this allows duplicate letters)       
*/
(deftemplate Letter (slot c) (slot p))

(defrule anagram "Generates and prints all possible combinations of the given 6 letter word using six characters and distinct positions"
   (Letter (c ?c1) (p ?p1))
   (Letter (c ?c2) (p ?p2 &~?p1))
   (Letter (c ?c3) (p ?p3 &~?p2 &~?p1))
   (Letter (c ?c4) (p ?p4 &~?p3 &~?p2 &~?p1))
   (Letter (c ?c5) (p ?p5 &~?p4 &~?p3 &~?p2 &~?p1))
   (Letter (c ?c6) (p ?p6 &~?p5 &~?p4 &~?p3 &~?p2 &~?p1))
=>
   (printout t ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 " ")
)  ; defrule anagram "Generates and prints all possible combinations of the given 6 letter word"

(defrule main "Begins the process for intaking a word of any length and generating all possible anagrams of it"

=>
   (main)
)  ; defrule main "Begins the process for intaking a word of any length and generating all possible anagrams of it"

/*
* 
* 
* Example for an inputted word of length six:
* (defrule anagram "Generates and prints all possible combinations of the given six letter word using six characters and distinct positions"
*     (Letter (c ?c1) (p ?p1))
*     (Letter (c ?c2) (p ?p2 &~?p1))
*     (Letter (c ?c3) (p ?p3 &~?p2 &~?p1))
*     (Letter (c ?c4) (p ?p4 &~?p3 &~?p2 &~?p1))
*     (Letter (c ?c5) (p ?p5 &~?p4 &~?p3 &~?p2 &~?p1))
*     (Letter (c ?c6) (p ?p6 &~?p5 &~?p4 &~?p3 &~?p2 &~?p1))
*  =>
*     (printout t ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 " ")
)
*/
(deffunction makeRules (?len)
   (bind ?double_quote (toChar ?*ASCII_DOUBLE_QUOTE*))
   (bind ?rule (sym-cat "(defrule anagram " ?double_quote "Generates and prints all possible combinations of the given " ?len " letter word using " ?len " characters and distinct positions" ?double_quote crlf))
   
   (for (bind ?char_index 1) (<= ?char_index ?len) (++ ?char_index)
      (bind ?rule (sym-cat "(Letter (c ?c" ?char_index ") (p "))


   )

   (bind ?rule (sym-cat ?rule "=>" crlf))

   (bind ?rule (sym-cat ?rule "(printout t "))
   (for (bind ?print_index 1) (<= ?print_index ?len) (++ ?print_index)
      (bind ?rule (sym-cat ?rule "?c" ?print_index " "))
   )
   (bind ?rule (sym-cat ?double_quote " " ?double_quote ")" crlf))
   (bind ?rule (sym-cat ?rule ")"))
   
   (build ?rule)

   (return)
)  ; deffunction makeRules (?len)

/*
* Asserts a letter using the Letter template as well as a character and 
* position so the anagram rule can fire
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
(deffunction assertList (?letters ?len)
   (for (bind ?index 1) (<= ?index ?len) (++ ?index)
      (assertLetter (nth$ ?index ?letters) ?index) 
   )

   (return)
)  ; deffunction assertList (?letters)

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
   (bind ?prompt (sym-cat "Enter a word: "))
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
   (bind ?len (length$ ?sliced))
   (makeRules ?len)
   (assertList ?sliced ?len)

   (bind ?numCombinations (run))
   (printline "")
   (print "The rule was fired ")
   (print ?numCombinations)
   (printline " times!")

   (return)
)  ; deffunction printAnagrams (?input)

/*
* Provides a user interface for intaking a word from the user and
* generating/printing anagrams of the inputted word if the input is of a valid length
*/
(deffunction main ()
   (bind ?input (getInput))

   (printAnagrams ?input)

   (return)
)  ; deffunction main ()