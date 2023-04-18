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
*                       with 'T' indicating that it does and 'F' indicating the opposite
*/
(deftemplate attribute (slot name) (slot value))

(do-backward-chaining attribute)

(defglobal ?*question_limit* = 20)  ; the amount of questions that can be asked without losing
(defglobal ?*questions_asked* = 0)  ; the amount of questions asked so far

/*
* path of the folder within the jess working directory that contains the files for this animal game
*/
(defglobal ?*directory* = "AnimalGame/")

/*****
* Rules either starting or ending the animal game based on certain conditions
* such as exceeding the question limit or running out of questions to ask
*/
(defrule startGame "Begins the animal game"
   (declare (salience 100))
=>
   (printline)
   (printline "Welcome to the 20 questions animal game! ")
   (printline "Please think of an animal and respond honestly to the following questions with either 'yes' ('y'), 'no' ('n'), or 'unknown' ('u')!")
   (printline "Feel free to use Google or other resources to learn more about your own animal in the process!")
   (printline "Ready? The game is beginning! ")
   (printline)
)  

(defrule giveUp "Ends the game and notifies the user that we were unable to guess their animal with the given info"
   (declare (salience -100))
=>
   (halt)
   (printline "I ran out of questions to ask, so I give up. Looks like I lose... ")
)  

(defrule loseGame "Ends the game forcefully if the question limit has been reached and notifies the user of their win"
   (> ?*questions_asked* ?*question_limit*)
=>
   (halt)
   (printline "We have reached the question limit. Seems like you win!")
)

/*****
* Rules batching in the respective knowledge island if the animal group's listed traits are
* the same as the ones inputted by the user
*/
(defrule mammal
   (attribute (name milk) (value T))
=>
   (batch (concatDirectory mammals.clp))

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
   (attribute (name feathers) (value T))
=>
   (batch (concatDirectory birds.clp))

   (undefrule producesMilk)
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
   (attribute (name vertebrate)  (value T))
   (attribute (name endothermic) (value F))
   (attribute (name gills)       (value F))
=>
   (batch (concatDirectory reptiles.clp))

   (undefrule hasFeathers)
   (undefrule producesMilk)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule undergoMetamorphosis)
   (undefrule hasJointedAppendages)
)  ; defrule reptile

(defrule mollusk
   (attribute (name exoskeleton)  (value T))
   (attribute (name radial)       (value F))
   (attribute (name appendages)   (value F))
=>
   (batch (concatDirectory mollusks.clp))

   (undefrule hasFeathers)
   (undefrule producesMilk)
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule hasExoskeleton)
   (undefrule hasGills)
)  ; defrule mollusk

(defrule insect
   (attribute (name appendages) (value T))
=>
   (batch (concatDirectory insects.clp))

   (undefrule hasFeathers)
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule hasGills)
   (undefrule hasShell)
)  ; defrule insect

(defrule amphibian
   (attribute (name vertebrate)    (value T))
   (attribute (name metamorphosis) (value T))
=>
   (batch (concatDirectory amphibians.clp))

   (undefrule hasFeathers)
   (undefrule producesMilk)
   (undefrule isEndothermic)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule hasJointedAppendages)
   (undefrule hasGills)
   (undefrule hasShell)
)  ; defrule amphibian

/*****
* Rules guessing the titular animal if the animal's assigned traits
* match the ones inputted by the user 
*/
(defrule fish
   (attribute (name vertebrate)    (value T))
   (attribute (name metamorphosis) (value F))
   (attribute (name gills)         (value T))
=>
   (guessAnimal fish)
)  ; defrule fish

(defrule jellyfish
   (attribute (name exoskeleton) (value F))
   (attribute (name radial)      (value T))
=>
   (guessAnimal jellyfish)
)  ; defrule jellyfish

(defrule sea_urchin
   (attribute (name exoskeleton) (value T))
   (attribute (name radial)      (value T))
=>
   (guessAnimal "sea urchin")
)  ; defrule sea_urchin


/*****
* Rules checking whether the user's animal has the titular attribute
*/
(defrule producesMilk
   (need-attribute (name milk) (value ?))
=>
   (bind ?value (convertInput "Does your animal produce milk?"))
   (assert (attribute (name milk) (value ?value)))
) ; defrule producesMilk

(defrule canFly "Checks whether the user's animal flies (and actively uses energy in the process)"
   (need-attribute (name fly) (value ?))
=>
   (bind ?value (convertInput "Does your animal fly (active use of energy involved)?"))
   (assert (attribute (name fly) (value ?value)))
   (if (= ?value T) then
      (assert (attribute (name land)        (value T)))
      (assert (attribute (name hooves)      (value F)))
    else
      (assert (attribute (name roundwinged) (value F)))
   )
)  ; defrule canFly

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
   (if (= ?value T) then
      (assert (attribute (name exoskeleton) (value F)))
   )
)  ; defrule isVertebrate

(defrule hasExoskeleton
   (need-attribute (name exoskeleton) (value ?))
=>
   (bind ?value (convertInput "Does your animal have an exoskeleton?"))
   (assert (attribute (name exoskeleton) (value ?value)))
   (if (= ?value T) then
      (assert (attribute (name vertebrate) (value F)))
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

(defrule undergoMetamorphosis "Checks whether the user's animal undergoes metamorphosis at least once in its life"
   (need-attribute (name metamorphosis) (value ?))
=>
   (bind ?value (convertInput "Does your animal undergo metamorphosis at least once in its life?"))
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
   (if (= ?value T) then
      (assert (attribute (name land) (value F)))
   )
)  ; defrule hasGills

(defrule livesOnLand "Checks whether the user's animal lives on land (spends most of its time above sea level)"
   (need-attribute (name land) (value ?))
=>
   (bind ?value (convertInput "Does your animal spend most of its time on land (above sea level)?"))
   (assert (attribute (name land) (value ?value)))
   (if (= ?value F) then
      (assert (attribute (name fly) (value F)))
   )
)  ; defrule livesOnLand

(defrule isSolitary
   (need-attribute (name solitary) (value ?))
=>
   (bind ?value (convertInput "Is your animal considered solitary (spends most of its time alone)?"))
   (assert (attribute (name solitary) (value ?value)))
)  ; defrule isSolitary

(defrule hasShell "Checks whether the user's animal has an outer shell (not inner)"
   (need-attribute (name shell) (value ?))
=>
   (bind ?value (convertInput "Does your animal have an outer shell?"))
   (assert (attribute (name shell) (value ?value)))
   (if (= ?value F) then
      (assert (attribute (name hinged) (value F)))
   )
)  ; defrule hasShell

/*
* Returns a string containing the path of the given file within the current jess working directory
* @param file                 the name of the file to access/batch within the animal game directory
* @return                     a string containing the concatenated path
*/
(deffunction concatDirectory (?file)
   (return (sym-cat ?*directory* ?file))
)

/*
* Determines whether the user's input to the given question is an affirmative or negative response (or neither)          
* @param question             the question to ask and retrieve input from
* @precondition               input is a string
* @return                     TRUE if the first character of user input is a 'y' or 'Y',
*                             FALSE if the first character of input is an 'n' or 'N'
*/
(deffunction convertInput (?question)
   (bind ?result "invalid")
   (while (stringp ?result)
      (printline)

      (bind ?input (askline ?question " "))
      (bind ?*questions_asked* (++ ?*questions_asked*))
      (bind ?character (upcase (sub-string 1 1 ?input)))

      (if (or (= ?character "Y") (= ?character "U")) then
         (bind ?result T)
       else 
         (if (= ?character "N") then
            (bind ?result F)
          else
            (printline "Improper input detected. Please enter your response to the following question again ('y', 'n', or 'u').")
         )
      )  ; if (or (= ?character "Y") (= ?character "U")) then
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

   (if (= ?input T) then
      (printline "I win! ")
    else
      (if (= ?input F) then
         (printline "Looks like I lose...")
       else
         (printline "Sorry, I couldn't understand that. I'll just assume that I lost... ")
      )
   )  ; if (= ?input TRUE) then

   (return)
)  ; deffunction guessAnimal (?animal)

(run)