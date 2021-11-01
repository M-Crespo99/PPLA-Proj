(define (problem jobs) (:domain job_schedule_domain)
(:objects task111 task112 task121 task122 task123 task211 task212 task231 task321 task322 task323 task331 - task 
          t0 t1 t2 t3 t4 t5 t6 t7 t8 t9 - time_slice
          m1 m2 m3 - machine
)

(:init
    (absolute_first_task task111)
    (absolute_first_task task211)
    (absolute_first_task task321)
    (first_sub_task task231)
    (first_sub_task task121)
    (first_sub_task task331)

    (=(end t0) 1)
    (=(end t1) 2)
    (=(end t2) 3)
    (=(end t3) 4)
    (=(end t4) 5)
    (=(end t5) 6)
    (=(end t6) 7)
    (=(end t7) 8)
    (=(end t8) 9)
    (=(end t9) 10)

    (=(total-cost) 0)

    (adjacent t0 t1)
    (adjacent t1 t2)
    (adjacent t2 t3)
    (adjacent t3 t4)
    (adjacent t4 t5)
    (adjacent t5 t6)
    (adjacent t6 t7)
    (adjacent t7 t8)
    (adjacent t8 t9)

    (ts_precedes t0 t1)
    (ts_precedes t0 t2)
    (ts_precedes t0 t3)
    (ts_precedes t0 t4)
    (ts_precedes t0 t5)
    (ts_precedes t0 t6)
    (ts_precedes t0 t7)
    (ts_precedes t0 t8)
    (ts_precedes t0 t9)
    
    
    (ts_precedes t1 t2)
    (ts_precedes t1 t3)
    (ts_precedes t1 t4)
    (ts_precedes t1 t5)
    (ts_precedes t1 t6)
    (ts_precedes t1 t7)
    (ts_precedes t1 t8)
    (ts_precedes t1 t9)

    (ts_precedes t2 t3)
    (ts_precedes t2 t4)
    (ts_precedes t2 t5)
    (ts_precedes t2 t6)
    (ts_precedes t2 t7)
        (ts_precedes t2 t8)
    (ts_precedes t2 t9)

    (ts_precedes t3 t4)
    (ts_precedes t3 t5)
    (ts_precedes t3 t6)
    (ts_precedes t3 t7)
        (ts_precedes t3 t8)
    (ts_precedes t3 t9)

    (ts_precedes t4 t5)
    (ts_precedes t4 t6)
    (ts_precedes t4 t7)
        (ts_precedes t4 t8)
    (ts_precedes t4 t9)

    (ts_precedes t5 t6)
    (ts_precedes t5 t7)
        (ts_precedes t5 t8)
    (ts_precedes t5 t9)
    
    (ts_precedes t6 t7)
    (ts_precedes t6 t8)
    (ts_precedes t6 t9)

    (ts_precedes t7 t8)
    (ts_precedes t7 t9)

     (ts_precedes t8 t9)

    (task_precedes task111 task112)
    (task_precedes task112 task121)
    (task_precedes task121 task122)
    (task_precedes task122 task123)

    (task_precedes task211 task212)
    (task_precedes task212 task231)

    (task_precedes task321 task322)
    (task_precedes task322 task323)

    (task_precedes task323 task331)

    (is_for task111 m1)
    (is_for task112 m1)
    (is_for task211 m1)
    (is_for task212 m1)

    (is_for task121 m2)
    (is_for task122 m2)
    (is_for task123 m2)
    (is_for task321 m2)
    (is_for task322 m2)
    (is_for task323 m2)

    (is_for task331 m3)
    (is_for task231 m3)
)


;task111 task112 task121 task122 task123 task211 task212 task231 task321 task322 task323 task331 - task 

(:goal (and (scheduled task111)
    (scheduled task112)
    (scheduled task121)
    (scheduled task122)
    (scheduled task123)
    (scheduled task211)
    (scheduled task212)
    (scheduled task231)
    (scheduled task321)
    (scheduled task322)
    (scheduled task323)
    (scheduled task331)
    
))

;un-comment the following line if metric is needed
    (:metric minimize (total-cost))
)
