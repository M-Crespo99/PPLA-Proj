;Header and description

(define (domain job_schedule_domain)

;remove requirements that are not needed
(:requirements :adl :action-costs :existential-preconditions)

(:types task machine time_slice
)

(:predicates 
            (scheduled ?t - task)
            (task_adjacent ?t1 ?t2 - task)
            (task_is_first ?t - task)
            (task_is_middle ?t - task)
            (last_scheduled ?m - machine ?t - task)
            (task_is_null ?t - task)
            (is_for ?m - machine ?t - task)

)

(:functions
    (total-cost) - number   
)
; (:action schedule_middle_sub_task
;     :parameters (?m - machine ?task ?pre_task - task  ?time_slice - time_slice)
;     :precondition (and  (not (scheduled ?task))
;                         (scheduled ?pre_task)
;                         (or (and (other_first_task ?task) (task_precedes_ts ?pre_task ?time_slice))
;                             (and (not (other_first_task ?task)) (task_adjacent_ts ?pre_task ?time_slice))
;                         )
;                         (is_for ?task ?m)
;                         (not (ts_occupied ?m ?time_slice))
;                         (task_precedes ?pre_task ?task)
;                         )
;     :effect (and (scheduled ?task) 
;                   (ts_occupied ?m ?time_slice)
;                   (when (not (task_is_last ?task))
;                   (forall (?ts_next - time_slice)
;                         (when (adjacent ?time_slice ?ts_next)
;                             (task_adjacent_ts ?task ?ts_next))
;                   ))
;                   (when (task_is_last ?task) 
;                         (forall (?ts_next - time_slice) 
;                         (when (ts_precedes ?time_slice ?ts_next)
;                             (task_precedes_ts ?task ?ts_next))
;                   ))
                  

;                 (increase (total-cost ?m) 1)
;                   )
; )

(:action schedule_middle_sub_task
    :parameters (?m - machine ?task ?pre_task - task)
    :precondition (or
                    (and  (scheduled ?pre_task)
                        (not (scheduled ?task))
                        (task_adjacent ?pre_task ?task)
                        (is_for ?m ?task)
                        (or (task_is_first ?task)
                            (and (task_is_middle ?task) (last_scheduled ?m ?pre_task))
                        )
                        )
                    (and (task_is_null ?task) (task_is_null ?pre_task))
                  )
    :effect (and                   
                (not (last_scheduled ?m ?pre_task))
                (last_scheduled ?m ?task)
                (scheduled ?task)
                (increase (total-cost) 1)
                )
)
)