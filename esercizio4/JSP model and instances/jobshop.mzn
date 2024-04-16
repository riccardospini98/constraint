include "globals.mzn";
include "ide/vis.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;    % task durations on machines



int: total_duration = sum(duration);
array[JOB,TASK] of var 0..total_duration: start;
var 0..total_duration: makespan;

% task precedence constraint
constraint forall(j in JOB) 
    ((forall(t in 1..M-1)
        (start[j,t] + duration[j,machine[j,t]] <= start[j,t+1]))
);

% last task must end before makespan
constraint forall(j in JOB) (start[j,M] + duration[j,machine[j,M]]<=makespan);

% no overlapping constraint
constraint forall(m in MACH) (
        disjunctive([start[j,k] | j in JOB, k in TASK where machine[j,k]=m],
                    [duration[j,m] | j in JOB]));
                                                       
%default search   
solve minimize makespan;

%search on the smallest start times
% solve::int_search(start, smallest, indomain_min) minimize makespan;



