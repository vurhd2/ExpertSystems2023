(batch "utilities_v3.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 2/1/23
* Description of Module: 
*/

/*
* 
*/
(deffunction slice$ (?text) ; CHECK IF ALLOWED TO USE EXPLODE
   (return (explode$ ?text))
)

/*
* 
*/
(deffunction count (?spliced)
   (for (bind ?index 1) (<= ?index (length$ ?spliced)) (++ ?index)

   )
)

/*
* 
*/
(deffunction histo ()
   (bind ?prompt "Please enter the text you wish to be alphabetically counted: ")
   (bind ?input (ask (?prompt)))

   (bind ?spliced (slice$ ?input))
   (bind ?counted )
   (return)
)  ; deffunction histo ()
