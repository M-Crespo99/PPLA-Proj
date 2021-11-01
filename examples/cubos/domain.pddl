;Header and description

(define (domain cubos_dom)

;remove requirements that are not needed
(:requirements :strips :typing)

(:types cubo
)

(:predicates (top ?c1 ?c2 - cubo) (free ?c - cubo) (table ?c - cubo)
)


(:action move_to_table
    :parameters (?c1 ?c2 - cubo)
    :precondition (and (free ?c1) (top ?c1 ?c2))
    :effect (and (not(top ?c1 ?c2)) (free ?c2) (table ?c1))
)

(:action move_to_cube
    :parameters (?c1 ?c2 ?c3 - cubo)
    :precondition (and (free ?c1) (not (top ?c1 ?c2)) (top ?c1 ?c3) (free ?c2) (not (table ?c1)))
    :effect (and (top ?c1 ?c2) (not (free ?c2)) (free ?c3))
)

(:action move_from_table
    :parameters (?c1 ?c2 - cubo)
    :precondition (and (free ?c1) (not (top ?c1 ?c2)) (free ?c2) (table ?c1))
    :effect (and (not(table ?c1)) (top ?c1 ?c2) (not (free ?c2)))
)

)