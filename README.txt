Our project can be run by executing ./proj1 < <instance_file> > solution.txt

It is expected that the python script for the planner, the fast-downward.py, is 
on the same folder as the proj1 script, and as such, can be called with ./fast-downward.py.

Our project does not give optimal solutions for small problems, only to very
small ones, such as the intances contained in the project's statement.

For every small instance provided by the faculty, we can give a correct solution
in under 20 seconds, except for the example jss_21.in that takes a lot longer.

For medium instances, the time it takes to run is a lot longer and varies greatly 
from instance to instance, but they take over one minute.

Our approach was to divide time into individual time slices while not dividing
a task that takes n time slices into n tasks. As such, we have a static pddl domain
with only one action with five entry parameters. We assign tasks to machines while making 
sure that the preceding task is already scheduled and the current task doesn't overlap
a pre-existing one.


Diogo FerrÃ£o - 89435
Miguel Crespo - 90334