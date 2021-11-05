;Header and description

(define (domain job_schedule_domain)

;remove requirements that are not needed
(:requirements :adl :action-costs )

(:types task machine time_slice
)

(:predicates  (is_for ?t - task ?m - machine) 
            (scheduled_for_ts ?m - machine ?t - task ?ts - time_slice) 
            (task_precedes ?t1 ?t2 - task)
            (ts_precedes ?ts1 ?ts2 - time_slice)
            (ts_occupied ?m - machine ?ts1 - time_slice)
            (scheduled ?t - task)
            (first_sub_task ?t - task)
            (adjacent ?ts1 ?ts2 - time_slice)
            (absolute_first_task ?t - task)
            (last_task ?t - task)
)

(:functions
    (end ?ts - time_slice)- number 
    (total-cost) - number   
)
(:action schedule_middle_sub_task
    :parameters (?m - machine ?task ?pre_task - task  ?time_slice ?pre_time_slice - time_slice)
    :precondition (and  (not (scheduled ?task))
                        (scheduled ?pre_task)
                        (scheduled_for_ts ?m ?pre_task ?pre_time_slice)
                        (adjacent ?pre_time_slice ?time_slice)
                        (is_for ?task ?m)
                        (not (ts_occupied ?m ?time_slice))
                        (task_precedes ?pre_task ?task)
                        (not (last_task ?task))
                        )
    :effect (and (scheduled ?task) 
                  (scheduled_for_ts ?m ?task ?time_slice)
                  (ts_occupied ?m ?time_slice)
                  )
)

(:action schedule_last_sub_task
    :parameters (?m - machine ?task ?pre_task - task  ?time_slice ?pre_time_slice - time_slice)
    :precondition (and  (not (scheduled ?task))
                        (scheduled ?pre_task)
                        (scheduled_for_ts ?m ?pre_task ?pre_time_slice)
                        (adjacent ?pre_time_slice ?time_slice)
                        (is_for ?task ?m)
                        (not (ts_occupied ?m ?time_slice))
                        (task_precedes ?pre_task ?task)
                        (last_task ?task)
                        )
    :effect (and (scheduled ?task) 
                  (scheduled_for_ts ?m ?task ?time_slice)
                  (ts_occupied ?m ?time_slice)
                (increase (total-cost) (end ?time_slice))
                  )
)


(:action schedule_absolute_firstsub_task
    :parameters (?m - machine ?t - task  ?ts - time_slice)
    :precondition (and  (absolute_first_task ?t)
                        (not (scheduled ?t))
                        (is_for ?t ?m)
                        (not (ts_occupied ?m ?ts))
                        )
    :effect (and  (scheduled ?t) 
                  (scheduled_for_ts ?m ?t ?ts)
                  (ts_occupied ?m ?ts)
                  )
)

(:action schedule_other_firstsub_tasks
    :parameters (?m ?pre_machine - machine ?t ?pre_task - task  ?ts ?pre_time_slice - time_slice)
    :precondition (and  (first_sub_task ?t)
                        (not (scheduled ?t))
                        (scheduled ?pre_task)
                        (scheduled_for_ts ?pre_machine ?pre_task ?pre_time_slice)
                        (is_for ?t ?m)
                        (not (ts_occupied ?m ?ts))
                        (task_precedes ?pre_task ?t)
                        (ts_precedes ?pre_time_slice ?ts)
                        )
    :effect (and (scheduled ?t) 
                  (scheduled_for_ts ?m ?t ?ts)
                  (ts_occupied ?m ?ts)
                  )
)
)