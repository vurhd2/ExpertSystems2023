(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 2/1/23
* 
* Description of Module: 
* Provides a user interface for intaking a block of ascii text and 
* outputting the frequency/count of each alphabetic letter in the given
* text (independent of case).
*
* Publicly Accessible Functions:
* histo
*/

/*
* The list of ASCII characters returned by asciiList$ in utilities_v4
*/
(defglobal ?*ASCII_LIST* = (asciiList$))

/*
* Index of "A" in the list returned by asciiList$ in utilities_v4
*/
(defglobal ?*A_ASCII_INDEX* = 66)

/*
* Index of "Z" in the list returned by asciiList$ in utilities_v4
*/
(defglobal ?*Z_ASCII_INDEX* = 91)

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
* Intakes a list of sliced ascii characters and counts
* the frequency of each alphabetic letter in the list
* @param sliced      a list of the sliced characters 
*                    in the original inputted text
* @precondition      sliced only contains ascii characters
* @return            a list of the frequencies of each
*                    letter in the text in the same order
*/
(deffunction count (?sliced)
   (bind ?counts (create$))

   (for (bind ?index 1) (<= ?index (length$ ?*ASCII_LIST*)) (++ ?index)
      (bind ?counts (insert$ ?counts ?index 0))
   )

   (foreach ?character ?sliced
      (bind ?index (+ (asc (upcase ?character)) 1))
      (bind ?counts (replace$ ?counts ?index ?index (+ (nth$ ?index ?counts) 1)))
   )

   (return ?counts)
)  ; deffunction count (?sliced)

/*
* Prints out the results of the alphabetic histogram,
* specifically each alphabetic letter and its frequency 
* within the given text
* @param counts      a list of the frequencies of each
*                    letter in the text in the same order
* @return            nil
*/
(deffunction printHisto (?counts)
   (printline "Here are the frequencies of each letter:")

   (for (bind ?index ?*A_ASCII_INDEX*) (<= ?index ?*Z_ASCII_INDEX*) (++ ?index)
      (print (nth$ ?index ?*ASCII_LIST*))
      (print ": ")
      (printline (nth$ ?index ?counts))
   )

   (return)
)  ; deffunction printHisto (?counts)

/*
* Provides a user interface for intaking a block of ascii text and 
* outputting the frequency/count of each alphabetic letter in the given
* text (independent of case)
* @return            nil      
*/
(deffunction histo ()
   (bind ?prompt "Please enter the text you wish to be alphabetically counted: ")
   (bind ?input (askline ?prompt))

   (bind ?sliced (slice$ ?input))
   (bind ?counted (count ?sliced))

   (printHisto ?counted)

   (return)
)  ; deffunction histo ()

(histo)