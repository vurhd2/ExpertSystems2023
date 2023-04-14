/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
*
*
*
*/

(defrule bee
   (attribute (name fly)      (value TRUE))
   (attribute (name solitary) (value FALSE))
=>
   (guessAnimal bee)
)

(defrule spider
   (attribute (name fly)      (value FALSE))
   (attribute (name solitary) (value TRUE))
=>
   (guessAnimal spider)
)

(defrule ant
   (attribute (name fly)      (value FALSE))
   (attribute (name solitary) (value FALSE))
=>
   (guessAnimal ant)
)

(defrule beetle
   (attribute (name fly)      (value TRUE))
   (attribute (name solitary) (value TRUE))
=>
   (guessAnimal beetle)
)