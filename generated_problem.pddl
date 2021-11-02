(define (problem jobs) (:domain job_schedule_domain)
(:objects 
	task_1_1_1 task_1_1_2 task_1_2_1 task_2_1_1 task_2_1_2 task_2_1_3 task_2_2_1 task_3_1_1 task_3_1_2 task_3_2_1 task_3_2_2 task_3_2_3 - task
	t_0 t_1 t_2 t_3 t_4 t_5 t_6 t_7 t_8 t_9 t_10 t_11 - time_slice
	m_1 m_2 - machine
)
(:metric minimize (total-cost))
)