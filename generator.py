import sys

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
    def __init__(self, machine : Machine, job_number : int, relative_time : int):
        self.machine_id = machine.id
        self.job_number = job_number
        self.relative_time = relative_time
    
    def __str__(self) -> str:
        return f'task_{self.job_number}_{self.machine_id}_{self.relative_time}'

def read_file():
    machine_count = int(sys.stdin.readline().split()[1])
    for i in range(1,machine_count+1):
        machines.append(Machine(i))

    job_count = 1
    for line in sys.stdin:
        line = line.rstrip()
        for task in line.split()[1:]:
            split_task = task.split(":")
            machine = int(split_task[0])
            task_count = int(split_task[1])
            print(machine, task_count)
            for i in range(1, task_count+1):
                tasks.append(Task(machines[machine-1], job_count, i))
        job_count += 1

    for task in tasks:
        print(task)

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
    # init()
    # goal()
    metric(f)

    f.close()




