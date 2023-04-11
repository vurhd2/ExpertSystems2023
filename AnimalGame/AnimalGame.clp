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

(defrule nameBackward ""
   (need-attribute (name ?x &~nil))
=>
   
)

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

(defrule mammal
   (attribute (name milk) (value TRUE))
=>
   (batch mammals.clp)
)

(defrule bird
   (attribute (name feathers) (value TRUE))
=>
   (batch birds.clp)
)

(defrule reptile
   (attribute (name vertebrate)  (value TRUE))
   (attribute (name endothermic) (value FALSE))
   (attribute (name gills)       (value FALSE))
=>
   (batch reptiles.clp)
)

(defrule mollusk
   (attribute (name exoskeleton) (value TRUE))
   (attribute (name radial)      (value FALSE))
   (attribute (name appendages)   (value FALSE))
=>
   (batch mollusks.clp)
)

(defrule insect
   (attribute (name appendages) (value TRUE))
=>
   (batch insects.clp)
)

(defrule amphibian
   (attribute (name vertebrate)    (value TRUE))
   (attribute (name metamorphosis) (value TRUE))
=>
   (batch amphibians.clp)
)

(defrule fish
   (attribute (name vertebrate)    (value TRUE))
   (attribute (name metamorphosis) (value FALSE))
   (attribute (name gills)         (value TRUE))
=>
   (guessAnimal fish)
)

(defrule jellyfish
   (attribute (name exoskeleton) (value FALSE))
   (attribute (name radial)      (value TRUE))
)

(defrule sea_urchin
   (attribute (name exoskeleton) (value TRUE))
   (attribute (name radial)      (value TRUE))
=>
   (guessAnimal "sea urchin")
)

(defrule produceMilk
   
)

(defrule hasFeathers
   
)

(defrule vertebrate
   
)

(defrule hasExoskeleton
   
)

(defrule endothermic
   
)

(defrule radiallySymmetrical
   
)

(defrule undergoMetamorphosis
   
)

(defrule jointedAppendages
   
)

(defrule livesOnLand
   
)

(defrule fly
   
)

(defrule solitary
   
)

(defrule shell
   
)

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
            (printline "Improper input detected. Please enter your response to the following question again ('y' or 'n').")
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