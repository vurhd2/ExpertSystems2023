/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for select amphibians as well as rules for select attributes 
* to help differentiate between these amphibians
*
* Amphibian Rules:
* frog
* salamander
* axolotl
* caecilian
*
* Attribute Rules:
* hasLongTail
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

(defrule axolotl
   (attribute (name tail)    (value T))
   (attribute (name eyelids) (value F))
=>
   (guessAnimal axolotl)
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
(defrule hasLongTail
   (need-attribute (name tail) (value ?))
=>
   (bind ?value (convertInput "Does your animal have a typically longer tail?"))
   (assert (attribute (name tail) (value ?value)))
)

(defrule hasEyelids
   (need-attribute (name eyelids) (value ?))
=>
   (bind ?value (convertInput "Does your animal have eyelids?"))
   (assert (attribute (name eyelids) (value ?value)))
)