(clear)
(reset)

(defrule anagram0
   (L ?c1)
   (L ?c2 &~?c1)
   (L ?c3 &~?c2 &~?c1)
   (L ?c4 &~?c3 &~?c2 &~?c1)
=>
   (printout t ?c1 ?c2 ?c3 ?c4 " ")
)

(assert (L A) (L T) (L C) (L S))