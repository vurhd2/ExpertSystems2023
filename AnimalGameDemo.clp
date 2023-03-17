(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 3/6/23
* Description of Module: Provides a user interface for essentially playing 20 questions
* to guess the user's animal
*
* Animal RULES:
* goat
* kangaroo
* panda
* cat
* frog
* snail
* bee
* eagle
* owl
* penguin
* fish
* octopus
* whale
*
* Game RULES:
* startGame
* giveUp
*
* Attribute RULES:
* liveOnLand
* canFly
* hasFeathers
* isMammal
* isNocturnal
* isHerbivore
* hasClaws
* hasLegs
* inGroups
*/


/*
* Defines a template for each animal trait being used to differentiate animals
* @slot name            the name of the animal trait
* @slot value           the boolean value indicating whether this 
*                       trait applies to a given animal
*/
(deftemplate attribute (slot name) (slot value))

/******
* Rules guessing the titular animal if the animal's assigned traits 
* match the ones inputted by the user
*/

(defrule goat "guesses a goat if the inputted attributes match the ones belonging to a goat"
   (attribute (name "land") (value TRUE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "claws") (value FALSE))
=>
   (halt)
   (guessAnimal "goat")
)  ; defrule goat "guesses a goat if the inputted attributes match the ones belonging to a goat"

(defrule kangaroo "guesses a kangaroo if the inputted attributes match the ones belonging to a kangaroo"
   (attribute (name "land") (value TRUE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "herbivorous") (value TRUE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value TRUE))
=>
   (halt)
   (guessAnimal "kangaroo")
)  ; defrule kangaroo "guesses a kangaroo if the inputted attributes match the ones belonging to a kangaroo"

(defrule panda "guesses a panda if the inputted attributes match the ones belonging to a panda"
   (attribute (name "land") (value TRUE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "herbivorous") (value TRUE))
   (attribute (name "claws") (value TRUE))
   (attribute (name "legs") (value TRUE))
   (attribute (name "groups") (value FALSE))
=>
   (halt)
   (guessAnimal "panda")
)  ; defrule panda "guesses a panda if the inputted attributes match the ones belonging to a panda"

(defrule cat "guesses a cat if the inputted attributes match the ones belonging to a cat"
   (attribute (name "land") (value TRUE))
   (attribute (name "mammal") (value TRUE))
   (attribute (name "herbivorous") (value FALSE))
=>
   (halt)
   (guessAnimal "cat")
)  ; defrule cat "guesses a cat if the inputted attributes match the ones belonging to a cat"

(defrule frog "guesses a frog if the inputted attributes match the ones belonging to a frog"
   (attribute (name "land") (value TRUE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "herbivorous") (value FALSE))
   (attribute (name "claws") (value FALSE))
=>
   (halt)
   (guessAnimal "frog")
)  ; defrule frog "guesses a frog if the inputted attributes match the ones belonging to a frog"

(defrule snail "guesses a snail if the inputted attributes match the ones belonging to a snail"
   (attribute (name "land") (value TRUE))
   (attribute (name "legs") (value FALSE))
=>
   (halt)
   (guessAnimal "snail")
)  ; defrule snail "guesses a snail if the inputted attributes match the ones belonging to a snail"

(defrule bee "guesses a bee if the inputted attributes match the ones belonging to a bee"
   (attribute (name "fly") (value TRUE))
   (attribute (name "feathers") (value FALSE))
=>
   (halt)
   (guessAnimal "bee")
)  ; defrule bee "guesses a bee if the inputted attributes match the ones belonging to a bee"

(defrule eagle "guesses an eagle if the inputted attributes match the ones belonging to an eagle"
   (attribute (name "fly") (value TRUE))
   (attribute (name "feathers") (value TRUE))
   (attribute (name "nocturnal") (value FALSE))
   (attribute (name "claws") (value TRUE))
=>
   (halt)
   (guessAnimal "eagle")
)  ; defrule eagle "guesses an eagle if the inputted attributes match the ones belonging to an eagle"

(defrule owl "guesses an owl if the inputted attributes match the ones belonging to an owl"
   (attribute (name "nocturnal") (value TRUE))
=>
   (halt)
   (guessAnimal "owl")
)  ; defrule owl "guesses an owl if the inputted attributes match the ones belonging to an owl"

(defrule penguin "guesses a penguin if the inputted attributes match the ones belonging to a penguin"
   (attribute (name "fly") (value FALSE))
   (attribute (name "feathers") (value TRUE))
=>
   (halt)
   (guessAnimal "penguin")
)  ; defrule penguin "guesses a penguin if the inputted attributes match the ones belonging to a penguin"

(defrule fish "guesses a fish if the inputted attributes match the ones belonging to a fish"
   (attribute (name "land") (value FALSE))
   (attribute (name "mammal") (value FALSE))
   (attribute (name "legs") (value FALSE))
=>
   (halt)
   (guessAnimal "fish")
)  ; defrule fish "guesses a fish if the inputted attributes match the ones belonging to a fish"

(defrule octopus "guesses an octopus if the inputted attributes match the ones belonging to an octopus"
   (attribute (name "land") (value FALSE))
   (attribute (name "legs") (value TRUE))
=>
   (halt)
   (guessAnimal "octopus")
)  ; defrule octopus "guesses an octopus if the inputted attributes match the ones belonging to an octopus"

(defrule whale "guesses a whale if the inputted attributes match the ones belonging to a whale"
   (attribute (name "land") (value FALSE))
   (attribute (name "mammal") (value TRUE))
=>
   (halt)
   (guessAnimal "whale")
)  ; defrule whale "guesses a whale if the inputted attributes match the ones belonging to a whale"

/******
* Starting and ending rules 
*/

(defrule startGame "Begins the animal game"
   (declare (salience 100))
=>
   (printline)
   (printline "Welcome to the 20 questions animal game! ")
   (printline "Please think of an animal and respond honestly to the following questions with either a yes ('y') or no ('n')!")
   (printline)
)

(defrule giveUp "Ends the game and notifies the user that we were unable to guess their animal with the given info"
   (declare (salience -100))
=>
   (halt)
   (printline "I give up. Looks like I lose... ")
) 

/******
* Rules checking whether the user's animal has the titular attribute 
*/
(defrule liveOnLand "Checks whether the user's animal mainly lives on land (sleeps and breathes on it)"
   (declare (salience 90))
   (not (attribute (name "land")))
=>
   (bind ?value (convertInput (askline "Does your animal mainly live on land (sleeps and breathes on land)? ")))

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
)  ; defrule liveOnLand "Checks whether the user's animal mainly lives on land (sleeps and breathes on it)"

(defrule canFly "Checks whether the user's animal actively uses energy to fly"
   (declare (salience 70))
   (not (attribute (name "fly")))
=>
   (bind ?value (convertInput (askline "Does your animal fly (active use of energy involved)? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "fly") (value ?value)))
      (if ?value then
         (assert (attribute (name "land") (value ?value)))
      )
   )
)  ; defrule canFly "Checks whether the user's animal actively uses energy to fly"

(defrule hasFeathers "Checks whether the user's animal has feathers"
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
)  ; defrule hasFeathers "Checks whether the user's animal has feathers"

(defrule isMammal "Checks whether the user's animal is a mammal"
   (declare (salience 80))
   (not (attribute (name "mammal")))
=>
   (bind ?value (convertInput (askline "Is your animal mammalian? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "mammal") (value ?value)))
      (if ?value then
         (assert (attribute (name "fly") (value FALSE)))
         (assert (attribute (name "feathers") (value FALSE)))
      )
   )
)  ; defrule isMammal "Checks whether the user's animal is a mammal"

(defrule isNocturnal "Checks whether the user's animal is nocturnal"
   (not (attribute (name "nocturnal")))
=>
   (bind ?value (convertInput (askline "Is your animal nocturnal? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "nocturnal") (value ?value)))
   )
)  ; defrule isNocturnal "Checks whether the user's animal is nocturnal"

(defrule isHerbivore "Checks whether the user's animal is mainly herbivorous"
   (not (attribute (name "herbivorous")))
=>
   (bind ?value (convertInput (askline "Is your animal mainly herbivorous? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "herbivorous") (value ?value)))
   )
)  ; defrule isHerbivore "Checks whether the user's animal is mainly herbivorous"

(defrule hasClaws "Checks whether the user's animal has claws on their hands or feet"
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
)  ; defrule hasClaws "Checks whether the user's animal has claws on their hands or feet"

(defrule hasLegs "Checks whether the user's animal has limbs classified as legs or feet"
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
)  ; defrule hasLegs "Checks whether the user's animal has limbs classified as legs or feet"

(defrule inGroups "Checks whether the user's animal travels in groups"
   (not (attribute (name "groups")))
=>
   (bind ?value (convertInput (askline "Does your animal often travel in groups (packs, herds, etc.)? ")))

   (if (= ?value "invalid") then
      (printline "Improper input detected. Ending program")
      (halt)
    else 
      (assert (attribute (name "groups") (value ?value)))
   )
)  ; defrule inGroups "Checks whether the user's animal travels in groups"

/*
* Determines whether the user's input is an affirmative or negative response (or neither)          
* @param input               the user's input
* @precondition              input is a string
* @return                    TRUE if the first character of input is a 'y' or 'Y',
*                            FALSE if the first character of input is an 'n' or 'N',
*                            otherwise "invalid"
*/
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
)  ; deffunction convertInput (?input)

/*
* Guesses the given animal if the given attributes match those of the given animal
* @param animal            the animal to guess
*/
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
)  ; deffunction guessAnimal (?animal)

(run)