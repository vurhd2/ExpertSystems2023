/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for guessing select insects, which are differentiated solely
* by the canFly and isSolitary attribute rules found in the main file (AnimalGame.clp)
*
* Insect Rules:
* bee
* grasshopper
* ant
* beetle
*
* Main File Attribute Rules Used:
* canFly
* isSolitary
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

(defrule grasshopper
   (attribute (name fly)      (value F))
   (attribute (name solitary) (value T))
=>
   (guessAnimal grasshopper)
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