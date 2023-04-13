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
=>
   (guessAnimal eagle)
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
=>
   (guessAnimal hawk)
)

(defrule falcon
   (attribute (name land)    (value TRUE))
   (attribute (name fly)     (value TRUE))
   (attribute (name rounded) (value FALSE))
   (attribute (name piping)  (value TRUE))
=>
   (guessAnimal falcon)
)

(defrule penguin
   (attribute (name land) (value FALSE))
   (attribute (name fly)  (value FALSE))
=>
   (guessAnimal penguin)
)

(defrule isNocturnal
   (need-attribute (name nocturnal) (value ?))
=>
   (bind ?value (convertInput "Is your animal nocturnal?"))
   (assert (attribute (name nocturnal) (value ?value)))
)

(defrule hasRoundedWings
   (need-attribute (name rounded) (value ?))
=>
   (bind ?value (convertInput "Does your animal have rounded wings?"))
   (assert (attribute (name rounded) (value ?value)))
)

(defrule makesPipingSound
   (need-attribute (name piping) (value ?))
=>
   (bind ?value (convertInput "Does your animal emit a piping sound?"))
   (assert (attribute (name appendages) (value ?value)))
)