/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for select reptiles 
*
* Amphibian Rules:
* turtle
* crocodile
*/

/*****
* Rules guessing the titular reptile if the reptile's assigned traits
* match the ones inputted by the user 
*/
(defrule turtle
   (attribute (name shell) (value T))
=>
   (guessAnimal turtle)
)

(defrule crocodile
   (attribute (name shell) (value F))
=>
   (guessAnimal crocodile)
)