/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for select birds as well as rules for select attributes 
* to help differentiate between these birds
*
* Bird Rules:
* chicken
* eagle
* owl
* hawk
* falcon
* penguin
*
* Attribute Rules:
* isNocturnal
* hasRoundedWings
* makesPipingSound
*/

/*****
* Rules guessing the titular bird if the bird's assigned traits
* match the ones inputted by the user 
*/
(defrule chicken
   (attribute (name land) (value T))
   (attribute (name fly)  (value F))
=>
   (guessAnimal chicken)
)

(defrule eagle
   (attribute (name land)        (value T))
   (attribute (name fly)         (value T))
   (attribute (name roundwinged) (value T))
   (attribute (name piping)      (value T))
   (attribute (name nocturnal)   (value F))
=>
   (guessAnimal eagle)
)

(defrule owl
   (attribute (name nocturnal) (value T))
=>
   (guessAnimal owl)
)

(defrule hawk
   (attribute (name land)        (value T))
   (attribute (name fly)         (value T))
   (attribute (name roundwinged) (value T))
   (attribute (name piping)      (value F))
=>
   (guessAnimal hawk)
)

(defrule falcon
   (attribute (name land)        (value T))
   (attribute (name fly)         (value T))
   (attribute (name roundwinged) (value F))
   (attribute (name piping)      (value T))
=>
   (guessAnimal falcon)
)

(defrule penguin
   (attribute (name land) (value F))
=>
   (guessAnimal penguin)
)

/*****
* Rules checking whether the user's animal has the titular attribute
*/
(defrule isNocturnal
   (need-attribute (name nocturnal) (value ?))
=>
   (bind ?value (convertInput "Is your animal nocturnal?"))
   (assert (attribute (name nocturnal) (value ?value)))
)

(defrule hasRoundedWings
   (need-attribute (name roundwinged) (value ?))
=>
   (bind ?value (convertInput "Does your animal have rounded wings?"))
   (assert (attribute (name roundwinged) (value ?value)))
   (if (= ?value T) then
      (assert (attribute (name fly) (value T)))
   )
)

(defrule makesPipingSound
   (need-attribute (name piping) (value ?))
=>
   (bind ?value (convertInput "Does your animal emit a piping sound?"))
   (assert (attribute (name piping) (value ?value)))
)