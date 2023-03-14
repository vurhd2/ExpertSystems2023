(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 3/6/23
* Description of Module: 
*/

(deftemplate attribute (slot name) (slot value))

(defrule startGame ""
   (declare (salience 100))
=>
   (print "Welcome to the 20 questions animal game! ")
   (print "Please think of an animal and respond honestly to the following questions with either a yes ('y') or no ('n')!")
)

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

(defrule askLand "askLand"
   (declare (salience 90))
   =>
   (ask "Does your animal live on land?")
   (assert (attribute (name "land") (value (convertInput (readLine)))))
)

(defrule giveUp ""
   (declare (salience -100))
=>
   (halt)
   (print "I give up. What is your animal?")
)

(deffunction convertInput (?input)
   (bind ?result "")
   
   (if (= ?input "y") then
      (bind ?result TRUE)
    else if (= ?input "n") then
      (bind ?result FALSE)
    else
      (print "Improper input detected. Ending program")
   )

   (return ?result)
)

(deffunction guessAnimal (?animal)
   (print (sym-cat "Is your animal a " ?animal))
   (return)
)

(run)