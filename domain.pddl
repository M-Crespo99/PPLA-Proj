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
            (tasks_separated_by ?t - task ?ts1 ?ts2 - time_slice)
            (task_occupies_ts ?t - task ?ts - time_slice)
)

(:functions
    (end ?ts - time_slice)- number 
    (total-cost) - number   
)
(:action schedule_middle_sub_task
    :parameters (?m - machine ?task ?pre_task - task  ?time_slice ?end_time_slice - time_slice)
    :precondition (and  (not (scheduled ?task))
                        (tasks_separated_by ?task ?time_slice ?end_time_slice)
                        (scheduled ?pre_task)
                        (is_for ?task ?m)
                        (not (ts_occupied ?m ?time_slice))
                        (not (task_occupies_ts ?pre_task ?time_slice))
                        (not (exists (?ts - time_slice)
                                     (or
                                     (and (ts_precedes ?time_slice ?ts) (ts_occupied ?m ?ts))
                                     (and (ts_precedes ?time_slice ?ts) (task_occupies_ts ?pre_task ?ts)
                                     ))
                        ))
                        (task_precedes ?pre_task ?task)
                        )
    :effect (and (scheduled ?task) 
                 (ts_occupied ?m ?time_slice)
                 (ts_occupied ?m ?end_time_slice)
                 (task_occupies_ts ?task ?time_slice)
                 (task_occupies_ts ?task ?end_time_slice)

                 (increase (total-cost) (end ?end_time_slice))
            )
)

)