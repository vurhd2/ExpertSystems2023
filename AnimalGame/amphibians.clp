/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for guessing select amphibians as well as rules for certain attributes 
* to help differentiate between these amphibians
*
* Amphibian Rules:
* frog
* salamander
* tadpole
* caecilian
*
* Amphibian Attribute Rules:
* hasTail
* hasEyelids
*/

/*****
* Rules guessing the titular amphibian if the amphibian's assigned traits
* match the ones inputted by the user 
*/
(defrule frog
   (attribute (name tail)    (value F))
   (attribute (name eyelids) (value T))
=>
   (guessAnimal frog)
)

(defrule salamander
   (attribute (name tail)    (value T))
   (attribute (name eyelids) (value T))
=>
   (guessAnimal salamander)
)

(defrule tadpole
   (attribute (name tail)    (value T))
   (attribute (name eyelids) (value F))
=>
   (guessAnimal tadpole)
)

(defrule caecilian
   (attribute (name tail)    (value F))
   (attribute (name eyelids) (value F))
=>
   (guessAnimal caecilian)
)

/*****
* Rules checking whether the user's animal has the titular attribute
*/
(defrule hasTail
   (need-attribute (name tail) (value ?))
=>
   (bind ?value (convertInput "Does your animal typically have a tail?"))
   (assert (attribute (name tail) (value ?value)))
)

(defrule hasEyelids
   (need-attribute (name eyelids) (value ?))
=>
   (bind ?value (convertInput "Does your animal have eyelids?"))
   (assert (attribute (name eyelids) (value ?value)))
)