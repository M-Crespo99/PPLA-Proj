(define (problem jobs) (:domain job_schedule_domain)
(:objects task111 task112 task211 task212 task121 task122 task221 task222 - task 
          t0 t1 t2 t3 t4 t5 t6 t7 - time_slice
          m1 m2 - machine
)

(:init
    (absolute_first_task task111)
    (absolute_first_task task211)
    (first_sub_task task121)
    (first_sub_task task221)

    (=(end t0) 1)
    (=(end t1) 2)
    (=(end t2) 3)
    (=(end t3) 4)
    (=(end t4) 5)
    (=(end t5) 6)
    (=(end t6) 7)
    (=(end t7) 8)

    (=(total-cost) 0)

    (adjacent t0 t1)
    (adjacent t1 t2)
    (adjacent t2 t3)
    (adjacent t3 t4)
    (adjacent t4 t5)
    (adjacent t5 t6)
    (adjacent t6 t7)

    

    (ts_precedes t0 t1)
    (ts_precedes t0 t2)
    (ts_precedes t0 t3)
    (ts_precedes t0 t4)
    (ts_precedes t0 t5)
    (ts_precedes t0 t6)
    (ts_precedes t0 t7)
    
    
    (ts_precedes t1 t2)
    (ts_precedes t1 t3)
    (ts_precedes t1 t4)
    (ts_precedes t1 t5)
    (ts_precedes t1 t6)
    (ts_precedes t1 t7)

    (ts_precedes t2 t3)
    (ts_precedes t2 t4)
    (ts_precedes t2 t5)
    (ts_precedes t2 t6)
    (ts_precedes t2 t7)

    (ts_precedes t3 t4)
    (ts_precedes t3 t5)
    (ts_precedes t3 t6)
    (ts_precedes t3 t7)

    (ts_precedes t4 t5)
    (ts_precedes t4 t6)
    (ts_precedes t4 t7)

    (ts_precedes t5 t6)
    (ts_precedes t5 t7)
    
    (ts_precedes t6 t7)

    (task_precedes task111 task112)
    (task_precedes task112 task121)
    (task_precedes task121 task122)

    (task_precedes task211 task212)
    (task_precedes task212 task221)
    (task_precedes task221 task222)

    (is_for task111 m1)
    (is_for task112 m1)
    (is_for task211 m1)
    (is_for task212 m1)

    (is_for task121 m2)
    (is_for task122 m2)
    (is_for task221 m2)
    (is_for task222 m2)
)

(:goal (and (scheduled task111)
    (scheduled task112)
    (scheduled task211)
    (scheduled task212)
    (scheduled task121)
    (scheduled task122)
    (scheduled task221)
    (scheduled task222)
))

;un-comment the following line if metric is needed
    (:metric minimize (total-cost))
)
