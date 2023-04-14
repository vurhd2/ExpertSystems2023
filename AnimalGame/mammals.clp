/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
*
*
*
*/

(defrule goat
   (attribute (name pierce)   (value TRUE))
   (attribute (name pattern)  (value FALSE))
   (attribute (name solitary) (value FALSE))
=>
   (guessAnimal goat)
)

(defrule pig
   (attribute (name land)      (value TRUE))
   (attribute (name herbivore) (value TRUE))
   (attribute (name hooves)    (value TRUE))
   (attribute (name pierce)    (value FALSE))
   (attribute (name pattern)   (value FALSE))
   (attribute (name solitary)  (value FALSE))
=>
   (guessAnimal pig)
)

(defrule cow
   (attribute (name pierce)    (value TRUE))
   (attribute (name pattern)   (value TRUE))
=>
   (guessAnimal cow)
)

(defrule whale
   (attribute (name land)     (value FALSE))
   (attribute (name solitary) (value TRUE))
   (attribute (name snout)    (value FALSE))
=>
   (guessAnimal whale)
)

(defrule platypus
   (attribute (name land)     (value FALSE))
   (attribute (name solitary) (value TRUE))
   (attribute (name snout)    (value TRUE))
=>
   (guessAnimal platypus)
)

(defrule dolphin
   (attribute (name land)     (value FALSE))
   (attribute (name solitary) (value FALSE))
   (attribute (name snout)    (value TRUE))
=>
   (guessAnimal dolphin)
)

(defrule kangaroo
   (attribute (name herbivore) (value TRUE))
   (attribute (name claws)     (value TRUE))
   (attribute (name snout)     (value TRUE))
=>
   (guessAnimal kangaroo)
)

(defrule panda
   (attribute (name herbivore) (value TRUE))
   (attribute (name claws)     (value TRUE))
   (attribute (name snout)     (value FALSE))
=>
   (guessAnimal panda)
)

(defrule cat
   (attribute (name pattern)   (value TRUE))
   (attribute (name solitary)  (value FALSE))
   (attribute (name herbivore) (value FALSE))
=>
   (guessAnimal cat)
)

(defrule elephant
   (attribute (name pierce)   (value TRUE))
   (attribute (name pattern)  (value FALSE))
   (attribute (name solitary) (value TRUE))
=>
   (guessAnimal elephant)
)

(defrule dog
   (attribute (name pattern) (value TRUE))
   (attribute (name snout)   (value TRUE))
=>
   (guessAnimal dog)
)

(defrule hippo
   (attribute (name hooves)    (value TRUE))
   (attribute (name herbivore) (value FALSE))
=>
   (guessAnimal hippo)
)

(defrule bat
   (attribute (name fly) (value TRUE))
=>
   (guessAnimal bat)
)

(defrule monkey
   (attribute (name land)      (value TRUE))
   (attribute (name herbivore) (value FALSE))
   (attribute (name claws)     (value FALSE))
   (attribute (name hooves)    (value FALSE))
=>
   (guessAnimal monkey)
)

(defrule herbivorous
   (need-attribute (name herbivore) (value ?))
=>
   (bind ?value (convertInput "Is your animal predominantly herbivorous?"))
   (assert (attribute (name herbivore) (value ?value)))
)

(defrule hasClaws
   (need-attribute (name claws) (value ?))
=>
   (bind ?value (convertInput "Does your animal have claws?"))
   (assert (attribute (name claws) (value ?value)))
   (if ?value then
      (assert (attribute (name hooves) (value FALSE)))
   )
)

(defrule hasHooves
   (need-attribute (name hooves) (value ?))
=>
   (bind ?value (convertInput "Does your animal have hooves?"))
   (assert (attribute (name hooves) (value ?value)))
   (if ?value then
      (assert (attribute (name claws) (value FALSE)))
   )
)

(defrule hasElongatedSnout
   (need-attribute (name snout) (value ?))
=>
   (bind ?value (convertInput "Does your animal have an elongated snout of some sort?"))
   (assert (attribute (name snout) (value ?value)))
)

(defrule hasSkinPattern
   (need-attribute (name pattern) (value ?))
=>
   (bind ?value (convertInput "Does your animal have a visual pattern on its skin, fur, etc.?"))
   (assert (attribute (name pattern) (value ?value)))
)

(defrule canPierce
   (need-attribute (name pierce) (value ?))
=>
   (bind ?value (convertInput "Does your animal have a horns or tusks (sharp piercing body part)?"))
   (assert (attribute (name pierce) (value ?value)))
)