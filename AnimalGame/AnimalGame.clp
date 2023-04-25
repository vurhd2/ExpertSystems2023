(clear)
(reset)

(batch "utilities_v4.clp")

/*
* Author: Dhruv Aron
* Date of Creation: 4/10/23
*
* Description of Module:
* Provides a user interface for essentially playing 20 questions
* to guess the user's animal with both forward and backward chaining rules
*
* User Interface Rules:
* startGame
* giveUp
* loseGame
*
* Knowledge Island Rules:
* mammal
* bird
* reptile
* amphibian
* mollusk
* insect
*
* Animal Rules (those not within the above knowledge islands):
* fish
* sea urchin
* jellyfish
*
* Attribute Rules (those not within the above knowledge islands):
* producesMilk
* canFly
* hasFeathers
* isVertebrate
* hasExoskeleton
* isEndothermic
* radiallySymmetrical
* undergoMetamorphosis
* hasJointedAppendages
* hasGills
* livesOnLand
* isSolitary
* hasShell
* 
* Global Variables:
* question_limit
* questions_asked
* directory
* 
* Functions:
* batchFile
* validInputs
* convertInput
* vowels
* properArticle
* guessAnimal
*/

/*
* Defines a template for each animal trait being used to differentiate animals
* @slot name                  the name of the animal trait
* @slot value                 the value indicating whether this trait applies to a given animal,
*                             with 'T' indicating that it does and 'F' indicating the opposite
*/
(deftemplate attribute (slot name) (slot value))

(do-backward-chaining attribute)    ; enable backward chaining using the attribute template

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
   (printline "Feel free to use Google or other resources to learn more about your own animal in the process.")
   (printline "Ready? Let's begin! ")
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
   (batchFile mammals.clp)

   /*
   * Undefining other attribute rules that lead to other knowledge islands
   * being batched in simultaneously, causing conflicts between guessing animals
   * (other rules below also contain this functionality, but different variations
   *  of rules are undefined depending on the knowledge island each attribute rule
   *  relates to)
   */
   (undefrule hasFeathers)          ; 
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule fly)
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
   (batchFile birds.clp)

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
   (batchFile reptiles.clp)

   (undefrule hasFeathers)
   (undefrule producesMilk)
   (undefrule hasExoskeleton)
   (undefrule radiallySymmetrical)
   (undefrule undergoMetamorphosis)
   (undefrule hasJointedAppendages)
   (undefrule isSolitary)
   (undefrule livesOnLand)
)  ; defrule reptile

(defrule mollusk
   (attribute (name exoskeleton)  (value T))
   (attribute (name radial)       (value F))
   (attribute (name appendages)   (value F))
=>
   (batchFile mollusks.clp)

   (undefrule hasFeathers)
   (undefrule producesMilk)
   (undefrule isEndothermic)
   (undefrule isVertebrate)
   (undefrule hasExoskeleton)
   (undefrule hasGills)
   (undefrule isSolitary)
   (undefrule livesOnLand)
)  ; defrule mollusk

(defrule insect
   (attribute (name appendages) (value T))
=>
   (batchFile insects.clp)

   (undefrule hasFeathers)
   (undefrule producesMilk)
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
   (batchFile amphibians.clp)

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

(defrule canFly "Checks whether the user's animal flies (actively requires energy output to be airborne)"
   (need-attribute (name fly) (value ?))
=>
   (bind ?value (convertInput "Does your animal fly (actively requires energy output to be airborne)?"))
   (assert (attribute (name fly) (value ?value)))
   (if (= ?value T) then
      (assert (attribute (name land)        (value T)))
      (assert (attribute (name hooves)      (value F)))
    else
      (assert (attribute (name roundwinged) (value F)))
   )
)  ; defrule canFly "Checks whether the user's animal flies (actively requires energy output to be airborne)"

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

(defrule hasJointedAppendages "Checks whether the user's animal has multiple types of jointed appendages instead of just arms or legs"
   (need-attribute (name appendages) (value ?))
=>
   (bind ?value (convertInput "Does your animal have multiple types of jointed appendages (instead of just arms or legs)?"))
   (assert (attribute (name appendages) (value ?value)))
)  ; defrule hasJointedAppendages "Checks whether the user's animal has multiple types of jointed appendages instead of just arms or legs"

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
   (not (attribute (name land)))
=>
   (bind ?value (convertInput "Does your animal spend most of its time on land (above sea level)?"))
   (assert (attribute (name land) (value ?value)))
   (if (= ?value F) then
      (assert (attribute (name fly) (value F)))
   )
)  ; defrule livesOnLand

(defrule isSolitary
   (not (attribute (name solitary)))
=>
   (bind ?value (convertInput "Is your animal considered solitary (spends most of its time alone)?"))
   (assert (attribute (name solitary) (value ?value)))
)  ; defrule isSolitary

(defrule hasShell "Checks whether the user's animal has an outer shell (not inner)"
   (not (attribute (name shell) (value ?)))
=>
   (bind ?value (convertInput "Does your animal have an outer shell?"))
   (assert (attribute (name shell) (value ?value)))
   (if (= ?value F) then
      (assert (attribute (name hinged) (value F)))
   )
)  ; defrule hasShell

/*
* Batches the given file in the Animal Game sub-folder within the current jess working directory
* @param file                 the name of the file to access/batch within the animal game directory
*/
(deffunction batchFile (?file)
   (batch (sym-cat ?*directory* ?file))

   (return)
)

/*
* Creates and returns a list containing the six valid user inputs to the animal game: 
* 'y', 'Y', 'u', 'U', 'n', and 'N'
* @return                     the list of the six valid inputs
*/
(deffunction validInputs ()
   (bind ?inputs (create$))

   (bind ?inputs (insert$ ?inputs 1 "y"))
   (bind ?inputs (insert$ ?inputs 2 "Y"))
   (bind ?inputs (insert$ ?inputs 3 "u"))
   (bind ?inputs (insert$ ?inputs 4 "U"))
   (bind ?inputs (insert$ ?inputs 5 "n"))
   (bind ?inputs (insert$ ?inputs 6 "N"))

   (return ?inputs)
)  ; deffunction validInputs ()

/*
* Asks a given question and determines whether the user's input is an affirmative, negative, or indecisive response        
* @param question             the question to ask and retrieve input from
* @return                     T if the first character of user input is a 'y', 'Y', 'u', or 'U'
*                             F if the first character of user input is an 'n' or 'N'
*/
(deffunction convertInput (?question)
   (bind ?result "invalid")

   (while (= ?result "invalid")
      (printline)

      (bind ?input (askline (sym-cat (+ ?*questions_asked* 1) ". " ?question " ")))
      (bind ?character (sub-string 1 1 ?input))

      (bind ?validInputs (validInputs))
      (bind ?valid (member$ ?character ?validInputs))

      (if (integerp ?valid) then
         (if (<= ?valid 4) then
            (bind ?result T)
          else 
            (bind ?result F)
         )   
       else
         (printline "Improper input detected. Please enter your response to the following question again ('y', 'n', or 'u').")
      )  ; if (integerp ?valid) then
   )  ; while (= ?result "invalid")

   (bind ?*questions_asked* (++ ?*questions_asked*))

   (return ?result)
)  ; deffunction convertInput (?question)

/*
* Creates and returns a list containing the ten (case-sensitive) vowels: 
* 'a', 'A', 'e', 'E', 'i', 'I', 'o', 'O', 'u', and 'U'
* @return                     the list of the ten case-sensitive vowels
*/
(deffunction vowels ()
   (bind ?inputs (create$))

   (bind ?inputs (insert$ ?inputs 1 "a"))
   (bind ?inputs (insert$ ?inputs 2 "A"))
   (bind ?inputs (insert$ ?inputs 3 "e"))
   (bind ?inputs (insert$ ?inputs 4 "E"))
   (bind ?inputs (insert$ ?inputs 5 "i"))
   (bind ?inputs (insert$ ?inputs 6 "I"))
   (bind ?inputs (insert$ ?inputs 7 "o"))
   (bind ?inputs (insert$ ?inputs 8 "O"))
   (bind ?inputs (insert$ ?inputs 9 "u"))
   (bind ?inputs (insert$ ?inputs 10 "U"))

   (return ?inputs)
)  ; deffunction vowels ()

/*
* Returns the proper article adjective ('a'/'an') for the given animal
* based on the first character of the animal name
* Ex: 'goat' would return 'a', while 'eagle' would return 'an'
* @param animal               the animal whose article adjective to return
* @return                     'a' if the animal's name begins with a vowel,
*                             'an' otherwise
*/
(deffunction properArticle (?animal)
   (bind ?vowels (vowels))
   (bind ?found (member$ (sub-string 1 1 ?animal) ?vowels))

   (bind ?result "an")
   (if (integerp ?found) then
      (bind ?result "a")
   )

   (return ?result)
)  ; deffunction properArticle (?animal)

/*
* Guesses the given animal if the given attributes match those of the given animal
* @param animal               the animal to guess
*/
(deffunction guessAnimal (?animal)
   (halt)
   (bind ?question ((sym-cat "Is your animal " (properArticle ?animal) " " ?animal "? ")))
   (bind ?input (convertInput ?question))

   (if (= ?input T) then
      (printline "I win! ")
    else
      (if (= ?input F) then
         (printline "Looks like I lose...")
       else
         (printline "Sorry, I couldn't understand that. I'll just assume that I lost... ")
      )
   )  ; if (= ?input T) then

   (return)
)  ; deffunction guessAnimal (?animal)

(run)