include "globals.mzn";
include "ide/vis.mzn";

int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

int: p;       % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre; % Precedence relations

int: total_duration = sum(duration);
array[TASKS] of var 0..total_duration: start;

% obj value to minimize
var int: makespan = max([start[i] + duration[i] | i in TASKS]);

% precedence constraint
constraint forall(i in PREC) 
  (start[pre[i,1]] + duration[pre[i,1]] <= start[pre[i,2]]);

 % cumulative constraint
constraint forall(i in RESOURCES) 
  (cumulative(start, duration, [req[i,j]|j in TASKS], L[i]));


% default search
solve minimize makespan;

% search on the smallest start times
% solve::int_search(start, smallest, indomain_min) 
%         minimize makespan;

output [
    "Start = ", show(start), "\n",
    "Makespan = ", show(makespan), "\n"
];