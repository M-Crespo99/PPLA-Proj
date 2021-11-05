;Header and description

(define (domain job_schedule_domain)

;remove requirements that are not needed
(:requirements :adl :action-costs :existential-preconditions)

(:types task machine time_slice
)

(:predicates  (is_for ?t - task ?m - machine) 
            (task_precedes ?t1 ?t2 - task)
            (ts_precedes ?ts1 ?ts2 - time_slice)
            (ts_occupied ?m - machine ?ts1 - time_slice)
            (scheduled ?t - task)
            (adjacent ?ts1 ?ts2 - time_slice)
            (task_precedes_ts ?t - task ?ts - time_slice)
            (task_adjacent_ts ?t - task ?ts - time_slice)
            (other_first_task ?t - task)
            (task_is_last ?t - task)
            (task_occupies_ts ?t - task ?ts - time_slice)
)

(:functions
    (end ?ts - time_slice)- number 
    (total-cost) - number   
)
(:action schedule_middle_sub_task
    :parameters (?m - machine ?task ?pre_task - task  ?time_slice - time_slice)
    :precondition (and  (not (scheduled ?task))
                        (scheduled ?pre_task)
                        (or (and (other_first_task ?task) (task_precedes_ts ?pre_task ?time_slice))
                            (and (not (other_first_task ?task)) (task_adjacent_ts ?pre_task ?time_slice))
                        )
                        (is_for ?task ?m)
                        (not (ts_occupied ?m ?time_slice))
                        (task_precedes ?pre_task ?task)
                        )
    :effect (and (scheduled ?task) 
                  (ts_occupied ?m ?time_slice)
                  (when (not (task_is_last ?task))
                  (forall (?ts_next - time_slice)
                        (when (adjacent ?time_slice ?ts_next)
                            (task_adjacent_ts ?task ?ts_next))
                  ))
                  (when (task_is_last ?task) 
                        (forall (?ts_next - time_slice) 
                        (when (ts_precedes ?time_slice ?ts_next)
                            (task_precedes_ts ?task ?ts_next))
                  ))
                  

                (increase (total-cost) (end ?time_slice))
                  )
)

)