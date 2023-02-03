(batch "utilities_v3.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 2/1/23
* Description of Module: 
*/

/*
* The list of ASCII characters returned by asciiList$ in utilities_v3
*/
(defglobal ?*ASCII_LIST* = (asciiList$))

/*
* Index of "A" in the list returned by asciiList$ in utilities_v3
*/
(defglobal ?*A_ASCII_INDEX* = 66)

/*
* Index of "Z" in the list returned by asciiList$ in utilities_v3
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
   (bind ?spliced (create$))

   (for (bind ?index 1) (<= ?index (str-length ?text)) (++ ?index)
      (bind ?character (sub-string ?index ?index ?text))
      (bind ?spliced (insert$ ?spliced ?index ?character))
   )

   (return ?spliced)
)  ; deffunction slice$ (?text)

/*
* Counts 
*/
(deffunction count (?spliced)
   (bind ?counts (create$))

   (for (bind ?index 1) (<= ?index ?*Z_ASCII_INDEX*) (++ ?index)
      (bind ?counts (insert$ ?counts ?index 0))
   )

   (foreach ?character ?spliced
      (bind ?index (member$ (upcase ?character) ?*ASCII_LIST*))
      (bind ?counts (replace$ ?counts ?index ?index (+ (nth$ ?index ?counts) 1)))
   )

   (return ?counts)
)  ; deffunction count (?spliced)

(deffunction printHisto (?counts)
   (for (bind ?index ?*A_ASCII_INDEX*) (<= ?index ?*Z_ASCII_INDEX*) (++ ?index)
      (print (nth$ ?index ?*ASCII_LIST*))
      (print ": ")
      (printline (nth$ ?index ?counts))
   )

   (return)
)  ; deffunction printHisto (?counts)

/*
* 
*/
(deffunction histo ()
   (bind ?prompt "Please enter the text you wish to be alphabetically counted: ")
   (bind ?input (askline ?prompt))

   (bind ?spliced (slice$ ?input))
   (bind ?counted (count ?spliced))

   (printHisto ?counted)

   (return)
)  ; deffunction histo ()

(histo)