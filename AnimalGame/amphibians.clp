/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
*
*
*
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