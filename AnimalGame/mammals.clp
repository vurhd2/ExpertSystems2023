/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Contains rules for select mammals as well as rules for select attributes 
* to help differentiate between these mammals
*
* Mammal Rules:
* goat
* pig
* whale
* platypus
* dolphin
* kangaroo
* panda
* cat
* elephant
* dog
* hippo
* monkey
*
* Atttribute Rules:
* herbivorous
* hasClaws
* hasHooves
* hasElongatedSnout
* hasSkinPattern
* canPierce
*/

/*****
* Rules guessing the titular mammal if the mammal's assigned traits
* match the ones inputted by the user 
*/
(defrule goat
   (attribute (name pierce)   (value T))
   (attribute (name pattern)  (value F))
   (attribute (name solitary) (value F))
=>
   (guessAnimal goat)
)

(defrule pig
   (attribute (name herbivore) (value T))
   (attribute (name hooves)    (value T))
   (attribute (name pierce)    (value F))
   (attribute (name pattern)   (value F))
   (attribute (name solitary)  (value F))
=>
   (guessAnimal pig)
)

(defrule whale
   (attribute (name land)     (value F))
   (attribute (name solitary) (value T))
   (attribute (name snout)    (value F))
=>
   (guessAnimal whale)
)

(defrule platypus
   (attribute (name land)     (value F))
   (attribute (name solitary) (value T))
   (attribute (name snout)    (value T))
=>
   (guessAnimal platypus)
)

(defrule dolphin
   (attribute (name land)     (value F))
   (attribute (name solitary) (value F))
   (attribute (name snout)    (value T))
=>
   (guessAnimal dolphin)
)

(defrule kangaroo
   (attribute (name herbivore) (value T))
   (attribute (name claws)     (value T))
   (attribute (name snout)     (value T))
=>
   (guessAnimal kangaroo)
)

(defrule panda
   (attribute (name herbivore) (value T))
   (attribute (name claws)     (value T))
   (attribute (name snout)     (value F))
=>
   (guessAnimal panda)
)

(defrule cat
   (attribute (name pattern)   (value T))
   (attribute (name solitary)  (value T))
   (attribute (name herbivore) (value F))
=>
   (guessAnimal cat)
)

(defrule elephant
   (attribute (name pierce)   (value T))
   (attribute (name pattern)  (value F))
   (attribute (name solitary) (value T))
=>
   (guessAnimal elephant)
)

(defrule dog
   (attribute (name pattern) (value T))
   (attribute (name snout)   (value T))
=>
   (guessAnimal dog)
)

(defrule hippo
   (attribute (name hooves)    (value T))
   (attribute (name herbivore) (value F))
=>
   (guessAnimal hippo)
)

(defrule monkey
   (attribute (name land)      (value T))
   (attribute (name herbivore) (value F))
   (attribute (name claws)     (value F))
   (attribute (name hooves)    (value F))
=>
   (guessAnimal monkey)
)

/*****
* Rules checking whether the user's animal has the titular attribute
*/
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
   (if (= ?value T) then
      (assert (attribute (name hooves) (value F)))
   )
)

(defrule hasHooves
   (need-attribute (name hooves) (value ?))
=>
   (bind ?value (convertInput "Does your animal have hooves?"))
   (assert (attribute (name hooves) (value ?value)))
   (if (= ?value T) then
      (assert (attribute (name claws) (value F)))
   )
)

(defrule hasElongatedSnout
   (need-attribute (name snout) (value ?))
=>
   (bind ?value (convertInput "Does your animal have an elongated snout of some sort (such as a bill or long, pointed nose)?"))
   (assert (attribute (name snout) (value ?value)))
)

(defrule hasSkinPattern
   (need-attribute (name pattern) (value ?))
=>
   (bind ?value (convertInput "Is it common for your animal to have a distinct visual pattern on its skin, fur, etc. (such as spots or stripes)?"))
   (assert (attribute (name pattern) (value ?value)))
)

(defrule canPierce
   (need-attribute (name pierce) (value ?))
=>
   (bind ?value (convertInput "Does your animal have horns or tusks (sharp piercing body part)?"))
   (assert (attribute (name pierce) (value ?value)))
)