(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 3/6/23
* 
* Description of Module: 
* Provides a user interface for essentially playing 20 questions
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
* @slot value           the value indicating whether this trait applies to a given animal,
*                       with 'TRUE' indicating that it does and 'FALSE' indicating the opposite
*/
(deftemplate attribute (slot name) (slot value))

/******
* Rules guessing the titular animal if the animal's assigned traits 
* match the patterns inputted by the user
*/

(defrule goat 
   (attribute (name land)   (value TRUE))
   (attribute (name mammal) (value TRUE))
   (attribute (name claws)  (value FALSE))
=>
   (guessAnimal goat)
)  ; defrule goat 

(defrule kangaroo 
   (attribute (name land)        (value TRUE))
   (attribute (name mammal)      (value TRUE))
   (attribute (name herbivorous) (value TRUE))
   (attribute (name claws)       (value TRUE))
   (attribute (name legs)        (value TRUE))
   (attribute (name groups)      (value TRUE))
=>
   (guessAnimal kangaroo)
)  ; defrule kangaroo 

(defrule panda 
   (attribute (name land)        (value TRUE))
   (attribute (name mammal)      (value TRUE))
   (attribute (name herbivorous) (value TRUE))
   (attribute (name claws)       (value TRUE))
   (attribute (name legs)        (value TRUE))
   (attribute (name groups)      (value FALSE))
=>
   (guessAnimal panda)
)  ; defrule panda

(defrule cat 
   (attribute (name land)        (value TRUE))
   (attribute (name mammal)      (value TRUE))
   (attribute (name herbivorous) (value FALSE))
=>
   (guessAnimal cat)
)  ; defrule cat

(defrule frog 
   (attribute (name land)        (value TRUE))
   (attribute (name mammal)      (value FALSE))
   (attribute (name herbivorous) (value FALSE))
   (attribute (name claws)       (value FALSE))
=>
   (guessAnimal frog)
)  ; defrule frog

(defrule snail 
   (attribute (name land) (value TRUE))
   (attribute (name legs) (value FALSE))
=>
   (guessAnimal snail)
)  ; defrule snail 

(defrule bee 
   (attribute (name fly)      (value TRUE))
   (attribute (name feathers) (value FALSE))
=>
   (guessAnimal bee)
)  ; defrule bee 

(defrule eagle 
   (attribute (name fly)       (value TRUE))
   (attribute (name feathers)  (value TRUE))
   (attribute (name nocturnal) (value FALSE))
=>
   (guessAnimal eagle)
)  ; defrule eagle 

(defrule owl 
   (attribute (name nocturnal) (value TRUE))
=>
   (guessAnimal owl)
)  ; defrule owl 

(defrule penguin 
   (attribute (name fly)      (value FALSE))
   (attribute (name feathers) (value TRUE))
=>
   (guessAnimal penguin)
)  ; defrule penguin 

(defrule fish 
   (attribute (name land)   (value FALSE))
   (attribute (name mammal) (value FALSE))
   (attribute (name legs)   (value FALSE))
=>
   (guessAnimal fish)
)  ; defrule fish 

(defrule octopus
   (attribute (name land) (value FALSE))
   (attribute (name legs) (value TRUE))
=>
   (guessAnimal octopus)
)  ; defrule octopus

(defrule whale 
   (attribute (name land)   (value FALSE))
   (attribute (name mammal) (value TRUE))
=>
   (guessAnimal whale)
)  ; defrule whale 

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
   (not (attribute (name land)))
=>
   (bind ?value (convertInput "Does your animal mainly live on land (sleeps and breathes on land)? "))
   (assert (attribute (name land) (value ?value)))
   (if (not ?value) then
      (assert (attribute (name fly)      (value FALSE)))
      (assert (attribute (name feathers) (value FALSE)))
   )
)  ; defrule liveOnLand "Checks whether the user's animal mainly lives on land (sleeps and breathes on it)"

(defrule canFly "Checks whether the user's animal actively uses energy to fly"
   (not (attribute (name fly)))
=>
   (bind ?value (convertInput "Does your animal fly (active use of energy involved)? "))
   (assert (attribute (name fly) (value ?value)))
   (if ?value then
      (assert (attribute (name land) (value ?value)))
   )
)  ; defrule canFly "Checks whether the user's animal actively uses energy to fly"

(defrule hasFeathers 
   (not (attribute (name feathers)))
=>
   (bind ?value (convertInput "Does your animal have feathers? "))
   (assert (attribute (name feathers) (value ?value)))
   (if ?value then
      (assert (attribute (name land)   (value ?value)))
      (assert (attribute (name mammal) (value FALSE)))
      (assert (attribute (name legs)   (value TRUE)))
      (assert (attribute (name claws)  (value TRUE)))
   )
)  ; defrule hasFeathers 

(defrule isMammal 
   (not (attribute (name mammal)))
=>
   (bind ?value (convertInput "Is your animal mammalian? "))
   (assert (attribute (name mammal) (value ?value)))
   (if ?value then
      (assert (attribute (name fly)      (value FALSE)))
      (assert (attribute (name feathers) (value FALSE)))
   )
)  ; defrule isMammal 

(defrule isNocturnal 
   (not (attribute (name nocturnal)))
=>
   (bind ?value (convertInput "Is your animal nocturnal? "))
   (assert (attribute (name nocturnal) (value ?value)))
)  ; defrule isNocturnal 

(defrule isHerbivore "Checks whether the user's animal is mainly herbivorous"
   (not (attribute (name herbivorous)))
=>
   (bind ?value (convertInput "Is your animal mainly herbivorous? "))
   (assert (attribute (name herbivorous) (value ?value)))
)  ; defrule isHerbivore "Checks whether the user's animal is mainly herbivorous"

(defrule hasClaws 
   (not (attribute (name claws)))
=>
   (bind ?value (convertInput "Does your animal have claws? "))
   (assert (attribute (name claws) (value ?value)))
   (if ?value then
      (assert (attribute (name legs) (value ?value)))
   )
)  ; defrule hasClaws 

(defrule hasLegs "Checks whether the user's animal has limbs classified as legs or feet"
   (not (attribute (name legs)))
=>
   (bind ?value (convertInput "Does your animal have limbs classified as legs (or feet)? "))

   (assert (attribute (name legs) (value ?value)))
   (if (not ?value) then
      (assert (attribute (name claws)    (value FALSE)))
      (assert (attribute (name feathers) (value FALSE)))
      (assert (attribute (name fly)      (value FALSE)))
   )
)  ; defrule hasLegs "Checks whether the user's animal has limbs classified as legs or feet"

(defrule inGroups "Checks whether the user's animal travels in groups"
   (not (attribute (name groups)))
=>
   (bind ?value (convertInput "Does your animal often travel in groups (packs, herds, etc.)? "))
   (assert (attribute (name groups) (value ?value)))
)  ; defrule inGroups "Checks whether the user's animal travels in groups"

/*
* Determines whether the user's input to the given question is an affirmative or negative response (or neither)          
* @param question            the question to ask and retrieve input from
* @precondition              input is a string
* @return                    TRUE if the first character of user input is a 'y' or 'Y',
*                            FALSE if the first character of input is an 'n' or 'N'
*/
(deffunction convertInput (?question)
   (bind ?result "invalid")
   (while (stringp ?result)
      (printline)

      (bind ?input (askline ?question))
      (bind ?character (upcase (sub-string 1 1 ?input)))

      (if (= ?character "Y") then
         (bind ?result TRUE)
      else 
         (if (= ?character "N") then
            (bind ?result FALSE)
          else
            (printline "Improper input detected. Please enter your response again to following question again ('y' or 'n').")
         )
      )
   )  ; while (not (= ?result "invalid"))

   (return ?result)
)  ; deffunction convertInput (?input)

/*
* Guesses the given animal if the given attributes match those of the given animal
* @param animal              the animal to guess
*/
(deffunction guessAnimal (?animal)
   (halt)
   (bind ?input (convertInput (sym-cat "Is your animal a(n) " ?animal "? ")))

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