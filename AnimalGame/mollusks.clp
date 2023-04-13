/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
*
*
*
*/

(defrule snail
   (attribute (name shell)  (value TRUE))
   (attribute (name hinged) (value FALSE))
=>
   (guessAnimal snail)
)

(defrule clam
   (attribute (name hinged) (value TRUE))
=>
   (guessAnimal clam)
)

(defrule octopus
   (attribute (name legs)    (value TRUE))
   (attribute (name rounded) (value TRUE))
=>
   (guessAnimal octopus)
)

(defrule squid
   (attribute (name legs)    (value TRUE))
   (attribute (name rounded) (value FALSE))
=>
   (guessAnimal squid)
)

(defrule hasHingedShell
   (need-attribute (name hinged) (value ?))
=>
   (bind ?value (convertInput "Does your animal have a hinged shell?"))
   (assert (attribute (name hinged) (value ?value)))
)

(defrule hasLegs
   (need-attribute (name tail) (value ?))
=>
   (bind ?value (convertInput "Does your animal have limbs technically classified as legs?"))
   (assert (attribute (name legs) (value ?value)))
)

(defrule hasRoundedHead
   (need-attribute (name rounded) (value ?))
=>
   (bind ?value (convertInput "Does your animal have a rounded head?"))
   (assert (attribute (name rounded) (value ?value)))
)