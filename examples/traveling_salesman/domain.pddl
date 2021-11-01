(define (domain NICE)
    (:requirements :adl :action-costs)
    (:types city)
    (:predicates (starting_city ?c - city) (is_in ?c - city)  (was_in ?c - city) (is_adjacent ?c1 ?c2 - city))
    
    (:functions (move_cost ?c1 ?c2 - city) - number
                (total_cost) - number
    )

    (:action move
     :parameters (?c1 ?c2 - city)
     :precondition (and (is_in ?c1) (or (not (was_in ?c2)) (starting_city ?c2)) (is_adjacent ?c1 ?c2))
     :effect (and (not (is_in ?c1))
                  (is_in ?c2)
                  (was_in ?c1)
                  (increase (total_cost) (move_cost ?c1 ?c2)))
    )
)
