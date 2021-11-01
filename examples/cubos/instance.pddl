(define (problem cubos) (:domain cubos_dom)
(:objects A B C - cubo
)

(:init
    (table A)
    (top B A)
    (top C B)
    (free C)
)

(:goal (and
    (top A B)
    (top B C)
    (table C)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
