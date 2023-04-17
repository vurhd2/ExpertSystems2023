(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
*
*
*
*/

/*
* Defines a template for each animal trait being used to differentiate animals
* @slot name            the name of the animal trait
* @slot value           the value indicating whether this trait applies to a given animal,
*                       with 'TRUE' indicating that it does and 'FALSE' indicating the opposite
*/
(deftemplate attribute (slot name) (slot value))

(do-backward-chaining attribute)

(defglobal ?*question_limit* = 20)
(defglobal ?*questions_asked* = 0)

(defrule startGame "Begins the animal game"
   (declare (salience 100))
=>
   (printline)
   (printline "Welcome to the 20 questions animal game! ")
   (printline "Please think of an animal and respond honestly to the following questions with either yes ('y'), no ('n'), or unknown ('u') !")
   (printline)
)  

(defrule giveUp "Ends the game and notifies the user that we were unable to guess their animal with the given info"
   (declare (salience -100))
=>
   (halt)
   (printline "I give up. Looks like I lose... ")
)  

(defrule loseGame "Ends the game forcefully if the question limit has been reached and notifies the user of their win"
   (> ?*questions_asked* ?*question_limit*)
=>
   (halt)
   (printline "We have reached the question limit. You win!")
)

(defrule mammal
   (attribute (name milk) (value TRUE))
=>
   (batch AnimalGame/mammals.clp)

   (undefrule hasFeathers)
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule undergoMetamorphosis)
   (undefrule hasJointedAppendages)
   (undefrule hasGills)
   (undefrule hasShell)
)  ; defrule mammal

(defrule bird
   (attribute (name feathers) (value TRUE))
=>
   (batch AnimalGame/birds.clp)

   (undefrule produceMilk)
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule undergoMetamorphosis)
   (undefrule hasJointedAppendages)
   (undefrule hasGills)
   (undefrule hasShell)
   (undefrule isSolitary)
)  ; defrule bird

(defrule reptile
   (attribute (name vertebrate)  (value TRUE))
   (attribute (name endothermic) (value FALSE))
   (attribute (name gills)       (value FALSE))
=>
   (batch AnimalGame/reptiles.clp)

   (undefrule hasFeathers)
   (undefrule produceMilk)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule undergoMetamorphosis)
   (undefrule hasJointedAppendages)
)  ; defrule reptile

(defrule mollusk
   (attribute (name exoskeleton)  (value TRUE))
   (attribute (name radial)       (value FALSE))
   (attribute (name appendages)   (value FALSE))
=>
   (batch AnimalGame/mollusks.clp)

   (undefrule hasFeathers)
   (undefrule produceMilk)
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule hasExoskeleton)
   (undefrule hasGills)
)  ; defrule mollusk

(defrule insect
   (attribute (name appendages) (value TRUE))
=>
   (batch AnimalGame/insects.clp)

   (undefrule hasFeathers)
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule hasGills)
   (undefrule hasShell)
)  ; defrule insect

(defrule amphibian
   (attribute (name vertebrate)    (value TRUE))
   (attribute (name metamorphosis) (value TRUE))
=>
   (batch AnimalGame/amphibians.clp)

   (undefrule hasFeathers)
   (undefrule produceMilk)
   (undefrule isEndothermic)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule hasJointedAppendages)
   (undefrule hasGills)
   (undefrule hasShell)
)  ; defrule amphibian

(defrule fish
   (attribute (name vertebrate)    (value TRUE))
   (attribute (name metamorphosis) (value FALSE))
   (attribute (name gills)         (value TRUE))
=>
   (guessAnimal fish)
)  ; defrule fish

(defrule jellyfish
   (attribute (name exoskeleton) (value FALSE))
   (attribute (name radial)      (value TRUE))
=>
   (guessAnimal jellyfish)
)  ; defrule jellyfish

(defrule sea_urchin
   (attribute (name exoskeleton) (value TRUE))
   (attribute (name radial)      (value TRUE))
=>
   (guessAnimal "sea urchin")
)  ; defrule sea_urchin

(defrule produceMilk
   (need-attribute (name milk) (value ?))
=>
   (bind ?value (convertInput "Does your animal produce milk?"))
   (assert (attribute (name milk) (value ?value)))
) ; defrule produceMilk

(defrule hasFeathers
   (need-attribute (name feathers) (value ?))
=>
   (bind ?value (convertInput "Does your animal have feathers?"))
   (assert (attribute (name feathers) (value ?value)))
) ; defrule hasFeathers

(defrule isVertebrate
   (need-attribute (name vertebrate) (value ?))
=>
   (bind ?value (convertInput "Is your animal considered a vertebrate (has a central spinal column or backbone)?"))
   (assert (attribute (name vertebrate) (value ?value)))
   (if ?value then
      (assert (attribute (name exoskeleton) (value FALSE)))
   )
)  ; defrule isVertebrate

(defrule hasExoskeleton
   (need-attribute (name exoskeleton) (value ?))
=>
   (bind ?value (convertInput "Does your animal have an exoskeleton?"))
   (assert (attribute (name exoskeleton) (value ?value)))
   (if ?value then
      (assert (attribute (name vertebrate) (value FALSE)))
   )
)  ; defrule hasExoskeleton

(defrule isEndothermic
   (need-attribute (name endothermic) (value ?))
=>
   (bind ?value (convertInput "Is your animal considered endothermic (naturally warm-blooded)?"))
   (assert (attribute (name endothermic) (value ?value)))
)  ; defrule isEndothermic

(defrule radiallySymmetrical
   (need-attribute (name radial) (value ?))
=>
   (bind ?value (convertInput "Does your animal exhibit radial symmetry?"))
   (assert (attribute (name radial) (value ?value)))
)  ; defrule radiallySymmetrical

(defrule undergoMetamorphosis
   (need-attribute (name metamorphosis) (value ?))
=>
   (bind ?value (convertInput "Does your animal undergo metamorphosis?"))
   (assert (attribute (name metamorphosis) (value ?value)))
)  ; defrule undergoMetamorphosis

(defrule hasJointedAppendages
   (need-attribute (name appendages) (value ?))
=>
   (bind ?value (convertInput "Does your animal have jointed appendages?"))
   (assert (attribute (name appendages) (value ?value)))
)  ; defrule hasJointedAppendages

(defrule hasGills
   (need-attribute (name gills) (value ?))
=>
   (bind ?value (convertInput "Does your animal have gills?"))
   (assert (attribute (name gills) (value ?value)))
   (if ?value then
      (assert (attribute (name land) (value FALSE)))
   )
)  ; defrule hasGills

(defrule livesOnLand
   (need-attribute (name land) (value ?))
=>
   (bind ?value (convertInput "Does your animal spend most of its time on land (above sea level)?"))
   (assert (attribute (name land) (value ?value)))
   (if (not ?value) then
      (assert (attribute (name fly) (value FALSE)))
   )
)  ; defrule livesOnLand

(defrule canFly
   (need-attribute (name fly) (value ?))
=>
   (bind ?value (convertInput "Does your animal fly (active use of energy involved)?"))
   (assert (attribute (name fly) (value ?value)))
   (if ?value then
      (assert (attribute (name land)        (value TRUE)))
    else
      (assert (attribute (name roundwinged) (value FALSE)))
   )
)  ; defrule canFly

(defrule isSolitary
   (need-attribute (name solitary) (value ?))
=>
   (bind ?value (convertInput "Is your animal considered solitary (spends most of its time alone)?"))
   (assert (attribute (name solitary) (value ?value)))
)  ; defrule isSolitary

(defrule hasShell
   (need-attribute (name shell) (value ?))
=>
   (bind ?value (convertInput "Does your animal have an outer shell?"))
   (assert (attribute (name shell) (value ?value)))
   (if (not ?value) then
      (assert (attribute (name hinged) (value FALSE)))
   )
)  ; defrule hasShell

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

      (bind ?input (askline ?question " "))
      (bind ?*questions_asked* (++ ?*questions_asked*))
      (bind ?character (upcase (sub-string 1 1 ?input)))

      (if (= ?character "Y") then
         (bind ?result TRUE)
       else 
         (if (= ?character "N") then
            (bind ?result FALSE)
          else
            (printline "Improper input detected. Please enter your response to the following question again ('y', 'n', or 'u').")
         )
      )
   )  ; while (stringp ?result)

   (return ?result)
)  ; deffunction convertInput (?question)

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