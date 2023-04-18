/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
*
*
*
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