/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for guessing select reptiles, which are differentiated 
* solely by the hasShell attribute rule found in the main file (AnimalGame.clp)
*
* Reptile Rules:
* turtle
* crocodile
*
* Main File Attribute Rules Used:
* hasShell
*/

/*****
* Rules guessing the titular reptile if the reptile's assigned traits
* match the ones inputted by the user 
*/
(defrule turtle
   (attribute (name shell) (value T))
=>
   (guessAnimal "turtle")
)

(defrule crocodile
   (attribute (name shell) (value F))
=>
   (guessAnimal "crocodile")
)