/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for guessing select mollusks as well as rules for certain attributes 
* to help differentiate between these mollusks
*
* Mollusk Rules:
* snail
* clam
* octopus
* squid
*
* Mollusk Attribute Rules:
* hasHingedShell
* hasLegs
* hasRoundedHead
*
* Main File Attribute Rules Used:
* hasShell
*/

/*****
* Rules guessing the titular mollusk if the mollusk's assigned traits
* match the ones inputted by the user 
*/
(defrule snail
   (attribute (name shell)  (value T))
   (attribute (name hinged) (value F))
=>
   (guessAnimal "snail")
)

(defrule clam
   (attribute (name hinged) (value T))
=>
   (guessAnimal "clam")
)

(defrule octopus
   (attribute (name legs)    (value T))
   (attribute (name rounded) (value T))
=>
   (guessAnimal "octopus")
)

(defrule squid
   (attribute (name legs)    (value T))
   (attribute (name rounded) (value F))
=>
   (guessAnimal "squid")
)

/*****
* Rules checking whether the user's animal has the titular attribute
*/
(defrule hasHingedShell
   (need-attribute (name hinged) (value ?))
=>
   (bind ?value (convertInput "Does your animal have a hinged shell?"))
   (assert (attribute (name hinged) (value ?value)))
)

(defrule hasLegs "Checks if the user's animal has limbs technically classified as legs (feet do not count)"
   (need-attribute (name legs) (value ?))
=>
   (bind ?value (convertInput "Does your animal have limbs technically classified as legs (feet do not count)?"))
   (assert (attribute (name legs) (value ?value)))
)

(defrule hasRoundedHead
   (need-attribute (name rounded) (value ?))
=>
   (bind ?value (convertInput "Does your animal have a rounded head?"))
   (assert (attribute (name rounded) (value ?value)))
)