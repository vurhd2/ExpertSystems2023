/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
*
*
*
*/

(defrule chicken
   (attribute (name land) (value TRUE))
   (attribute (name fly)  (value FALSE))
=>
   (guessAnimal chicken)
)

(defrule eagle
   (attribute (name land)    (value TRUE))
   (attribute (name fly)     (value TRUE))
   (attribute (name rounded) (value TRUE))
   (attribute (name piping)  (value TRUE))
)

(defrule owl
   (attribute (name nocturnal) (value TRUE))
=>
   (guessAnimal owl)
)

(defrule hawk
   (attribute (name land)    (value TRUE))
   (attribute (name fly)     (value TRUE))
   (attribute (name rounded) (value TRUE))
   (attribute (name piping)  (value FALSE))
)

(defrule falcon
   (attribute (name land)    (value TRUE))
   (attribute (name fly)     (value TRUE))
   (attribute (name rounded) (value FALSE))
   (attribute (name piping)  (value TRUE))
)

(defrule penguin
   (attribute (name land) (value FALSE))
   (attribute (name fly)  (value FALSE))
=>
   (guessAnimal penguin)
)

(defrule isNocturnal

)

(defrule hasRoundedWings

)

(defrule makesPipingSound
   
)