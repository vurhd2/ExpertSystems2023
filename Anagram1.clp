(clear)
(reset)

(defrule anagram1
   (L ?c1 ?p1)
   (L ?c2 ?p2 &~?p1)
   (L ?c3 ?p3 &~?p2 &~?p1)
   (L ?c4 ?p4 &~?p3 &~?p2 &~?p1)
=>
   (printout t ?c1 ?c2 ?c3 ?c4 " ")
)

(assert (L A 1) (L A 2) (L C 3) (L S 4))

(run)