import sys
from collections import defaultdict
import os

machines = []
tasks = []
time_slices = []

class Machine:
    def __init__(self, id : int):
        self.id = id
    
    def __str__(self) -> str:
        return f'm_{self.id}'

class TimeSlice:
    def __init__(self, id : int):
        self.id = id
        self.end = id + 1
    
    def __str__(self) -> str:
        return f't_{self.id}'

class Task:
    def __init__(self, machine : Machine, job_number : int, relative_time : int, number_machines : int, absolute_first = False):
        self.machine_id = machine.id
        self.job_number = job_number
        self.number_machines = number_machines
        self.relative_time = relative_time
        self.absolute_first = absolute_first
    
    def __str__(self) -> str:
        return f'task_{self.job_number}_{self.machine_id}_{self.relative_time}'

def read_file():
    machine_count = int(sys.stdin.readline().split()[1])
    for i in range(1,machine_count+1):
        machines.append(Machine(i))

    job_count = 1
    for line in sys.stdin:
        line = line.rstrip()
        items = line.split()
        number_machines = int(items[0])
        first_split_task = items[1].split(":")
        tasks.append(Task(machines[int(first_split_task[0])-1], job_count, 1, number_machines, True))
        for i in range(2, int(first_split_task[1])+1):
            tasks.append(Task(machines[int(first_split_task[0])-1], job_count, number_machines,i))

        for task in line.split()[2:]:
            split_task = task.split(":")
            machine = int(split_task[0])
            task_count = int(split_task[1])
            for i in range(1, task_count+1):
                tasks.append(Task(machines[machine-1], job_count,number_machines, i))
        job_count += 1


def define(file, job_name: str, domain_name: str):
    file.write(f'(define (problem {job_name}) (:domain {domain_name})\n')

def objects(file):
    file.write("(:objects \n\t")

    for task in tasks:
        file.write(str(task) + " ")
    file.write("- task\n\t")

    for time_slice in time_slices:
        file.write(str(time_slice) + " ")
    file.write("- time_slice\n\t")

    for machine in machines:
        file.write(str(machine)+ " ")
    file.write("- machine\n)\n")

def init(file):
    file.write("(:init\n")

    # task declarations
    previous_task = None
    for task in tasks:
        if task.absolute_first:
            file.write(f'\t(absolute_first_task {task})\n')
        elif task.relative_time == 1:
            file.write(f'\t(first_sub_task {task})\n')
            if previous_task and task.job_number == previous_task.job_number :
                file.write(f'\t(task_precedes {previous_task} {task})\n')

        if previous_task and task.job_number == previous_task.job_number and task.relative_time > previous_task.relative_time and task.machine_id == previous_task.machine_id:
            file.write(f'\t(task_precedes {previous_task} {task})\n')
                
        file.write(f'\t(is_for {task} {machines[task.machine_id-1]})\n\n')
        previous_task = task

    # time slice declarations
    previous_ts = None
    for time_slice in time_slices:
        if previous_ts:
            file.write(f'\t(adjacent {previous_ts} {time_slice})\n')
        
        for time_slice_inner in time_slices:
            if time_slice_inner.id > time_slice.id:
                file.write(f'\t(ts_precedes {time_slice} {time_slice_inner})\n')
            
        file.write(f'\t(=(end {time_slice}) {time_slice.end})\n\n')

        previous_ts = time_slice

    file.write("\t(=(total_cost) 0)\n")
    file.write(")\n")
    

def goal(file):
    file.write("(:goal (and\n")
    for task in tasks:
        file.write(f'\t(scheduled {task})\n')
    file.write("))\n")


def metric(file):
    file.write("(:metric minimize (total-cost))\n)")


if __name__  == "__main__":
    read_file()

    # Create time slices
    for i in range(len(tasks)):
        time_slices.append(TimeSlice(i))
    
    f = open("generated_problem.pddl", "w")
    f.writelines

    define(f, "jobs", "job_schedule_domain")
    objects(f)
    init(f)
    goal(f)
    metric(f)

    f.close()

    os.system("./downward/fast-downward.py --alias seq-sat-lama-2011 domain.pddl generated_problem.pddl >/dev/null 2>&1")


    last_index = -1
    for file in os.listdir():
        if file.find("sas_plan") != -1:
            split = file.split(".")
            if int(split[1]) > last_index:
                last_index = int(split[1])
    
    f = open("sas_plan." + str(last_index), "r")
    
  
    jobs = []
    
    for task in tasks:
        if task.job_number not in jobs:
            jobs.append(task.job_number)
            
    
    f.close()

    f = open("sas_plan." + str(last_index), "r")

    things = defaultdict(list)

    time_taken = -1
    for line in f:
        split = line.split()
        if split[0] == "(schedule_absolute_firstsub_task":
            machine_id = int(split[1].split("_")[1])
            job_number = int(split[2].split("_")[1])
            time_started = int(split[3].split("_")[1][:-1])
        if split[0] == "(schedule_other_firstsub_tasks":
            machine_id = int(split[1].split("_")[1])
            job_number = int(split[3].split("_")[1])
            time_started = int(split[5].split("_")[1])
        if split[0] == "(schedule_middle_sub_task":
            machine_id = int(split[1].split("_")[1])
            job_number = int(split[2].split("_")[1])
            time_started = int(split[4].split("_")[1])

        things[job_number].append([machine_id, time_started])

        if time_started > time_taken:
            time_taken = time_started


    time_taken += 1
    print(time_taken)
    print(str(len(jobs)) + " " + str(len(machines)))


    for i in range(len(jobs)):
        start_times = dict()
        for item in things[i+1]:
            if item[0] not in start_times:
                start_times[item[0]] = item[1]
            elif item[1] < start_times[item[0]]:
                start_times[item[0]] = item[1]
        #print(start_times)
        sys.stdout.write(str(len(start_times.keys())) + " ")
        for key, value in start_times.items():
            sys.stdout.write(str(key) + ":" + str(value) + " ")
        sys.stdout.write("\n")






                






