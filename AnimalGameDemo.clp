(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 3/6/23
* Description of Module: 
*/

(deftemplate attribute (slot name) (slot value))

(defrule goat "guesses a goat"
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value TRUE))
   (attribute (name "claws") (value FALSE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "goat")
)

(defrule kangaroo
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value TRUE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "kangaroo")
)

(defrule panda
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value TRUE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value FALSE))
   =>
   (halt)
   (guessAnimal "panda")
)

(defrule cat
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value FALSE))
   =>
   (halt)
   (guessAnimal "cat")
)

(defrule frog
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value FALSE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "frog")
)

(defrule snail
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value TRUE))
   (attribute (name "claws") (value FALSE))
   (attribute (name "legs") (value FALSE))
   (attribute (name "groups") (value FALSE))
   =>
   (halt)
   (guessAnimal "snail")
)

(defrule bee
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value TRUE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value TRUE))
   (attribute (name "claws") (value FALSE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "bee")
)
(defrule eagle
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value TRUE))
   (attribute (name "feathers") (value TRUE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "eagle")
)
(defrule owl
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value TRUE))
   (attribute (name "feathers") (value TRUE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value TRUE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "owl")
)

(defrule penguin
   (attribute (name "land") (value TRUE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value TRUE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "penguin")
)

(defrule fish
   (attribute (name "land") (value FALSE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value FALSE))
   (attribute (name "legs") (value FALSE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "fish")
)

(defrule octopus
   (attribute (name "land") (value FALSE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value FALSE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value FALSE))
   =>
   (halt)
   (guessAnimal "octopus")
)

(defrule whale
   (attribute (name "land") (value FALSE))
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value FALSE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value FALSE))
   (attribute (name "legs") (value FALSE))
   (attribute (name "groups") (value TRUE))
   =>
   (halt)
   (guessAnimal "whale")
)


(defrule startGame ""
   (declare (salience 100))
=>
   (printline "Welcome to the 20 questions animal game! ")
   (printline "Please think of an animal and respond honestly to the following questions with either a yes ('y') or no ('n')!")
   (printline)
)

(defrule liveOnLand "liveOnLand"
   (declare (salience 90))
   (not (attribute (name "land")))
=>
   (bind ?value (convertInput (askline "Does your animal live on land? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "land") (value ?value)))
      (if (not ?value) then
         (assert (attribute (name "fly") (value FALSE)))
         (assert (attribute (name "feathers") (value FALSE)))
      )
   )
)

(defrule canFly "canFly"
   (not (attribute (name "fly")))
=>
   (bind ?value (convertInput (askline "Does your animal fly? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "fly") (value ?value)))
      (if ?value then
         (assert (attribute (name "land") (value ?value)))
      )
   )
)

(defrule hasFeathers "hasFeathers"
   (not (attribute (name "feathers")))
=>
   (bind ?value (convertInput (askline "Does your animal have feathers? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "feathers") (value ?value)))
      (if ?value then
         (assert (attribute (name "land") (value ?value)))
         (assert (attribute (name "mammal") (value FALSE)))
         (assert (attribute (name "legs") (value TRUE)))
         (assert (attribute (name "claws") (value TRUE)))
      )
   )
)

(defrule isMammal "isMammal"
   (not (attribute (name "mammal")))
=>
   (bind ?value (convertInput (askline "Is your animal mammalian? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "mammal") (value ?value)))
      (if ?value then
         (assert (attribute (name "legs") (value ?value)))
         (assert (attribute (name "feathers") (value FALSE)))
      )
   )
)

(defrule isNocturnal "isNocturnal"
   (not (attribute (name "nocturnal")))
=>
   (bind ?value (convertInput (askline "Is your animal nocturnal? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "nocturnal") (value ?value)))
   )
)

(defrule isHerbivore "isHerbivore"
   (not (attribute (name "herbivorous")))
=>
   (bind ?value (convertInput (askline "Is your animal mainly herbivorous? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "herbivorous") (value ?value)))
   )
)

(defrule hasClaws "hasClaws"
   (not (attribute (name "claws")))
=>
   (bind ?value (convertInput (askline "Does your animal have claws? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "claws") (value ?value)))
      (if ?value then
         (assert (attribute (name "legs") (value ?value)))
      )
   )
)

(defrule hasLegs "hasLegs"
   (not (attribute (name "legs")))
=>
   (bind ?value (convertInput (ask "Does your animal have limbs classified as legs (or feet)? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "legs") (value ?value)))
      (if (not ?value) then
         (assert (attribute (name "claws") (value FALSE)))
         (assert (attribute (name "feathers") (value FALSE)))
         (assert (attribute (name "fly") (value FALSE)))
      )
   )
)

(defrule inGroups "inGroups"
   (not (attribute (name "groups")))
=>
   (bind ?value (convertInput (askline "Does your animal often travel in groups (packs, herds, etc.)? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "groups") (value ?value)))
   )
)

(defrule giveUp ""
   (declare (salience -100))
=>
   (halt)
   (printline "I give up. Looks like I lose... ")
)

(deffunction convertInput (?input)
   (bind ?result "invalid")
   (bind ?character (upcase (sub-string 1 1 ?input)))

   (if (= ?character "Y") then
      (bind ?result TRUE)
    else 
      (if (= ?character "N") then
         (bind ?result FALSE)
      )
   )

   (return ?result)
)

(deffunction guessAnimal (?animal)
   (bind ?input (convertInput (askline (sym-cat "Is your animal a(n) " ?animal "? "))))

   (if (= ?input TRUE) then
      (printline "I win! ")
    else
      (if (= ?input FALSE) then
         (printline "Looks like I lose...")
       else
         (printline "Sorry, I couldn't understand that. I'll just assume that I lost... ")
      )
   )
   (return)
)

(run)