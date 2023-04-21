/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for select insects
*
* Insect Rules:
* bee
* spider
* ant
* beetle
*/

/*****
* Rules guessing the titular insect if the insect's assigned traits
* match the ones inputted by the user 
*/
(defrule bee
   (attribute (name fly)      (value T))
   (attribute (name solitary) (value F))
=>
   (guessAnimal bee)
)

(defrule spider
   (attribute (name fly)      (value F))
   (attribute (name solitary) (value T))
=>
   (guessAnimal spider)
)

(defrule ant
   (attribute (name fly)      (value F))
   (attribute (name solitary) (value F))
=>
   (guessAnimal ant)
)

(defrule beetle
   (attribute (name fly)      (value T))
   (attribute (name solitary) (value T))
=>
   (guessAnimal beetle)
)